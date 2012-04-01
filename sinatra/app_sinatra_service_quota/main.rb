require 'sinatra'
require 'json'
require 'uri'
require 'pg'
require "yajl"

get '/env' do
  ENV['VMC_SERVICES']
end

get '/' do
  'hello from sinatra'
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end


not_found do
  'This is nowhere to be found.'
end

post '/service/postgresql/tables/:table' do
  client = load_postgresql
  client.query("create table #{params[:table]} (value text);")
  client.close
  params[:table]
end

delete '/service/postgresql/:object/:name' do
  client = load_postgresql
  object = params[:object]
  name = params[:name]
  name += "()" if object=="function" # PG 'drop function' docs: "The argument types to the function must be specified"
  client.query("drop #{object} #{name};")
  client.close
  name
end

post '/service/postgresql/functions/:function' do
  client = load_postgresql
  client.query("create function #{params[:function]}() returns integer as 'select 1234;' language sql;")
  client.close
  params[:function]
end

post '/service/postgresql/sequences/:sequence' do
  client = load_postgresql
  client.query("create sequence #{params[:sequence]};")
  client.close
  params[:sequence]
end

# delete from table
delete '/service/postgresql/table/:name/data' do
  client = load_postgresql
  table = params[:name]
  client.query("delete from #{table};")
  client.query("vacuum full;")
  client.close
  table
end

# get db size
get '/service/postgresql/database/size' do
  client = load_postgresql
  db_size = client.query("select pg_database_size('#{db_name}')").first['pg_database_size']
  client.close
  db_size
end

# populate data into table
post '/service/postgresql/:table/:mega' do
  begin
    content = prepare_data(1)
    client = load_postgresql
    mega_no = params[:mega].to_i
    i = 0
    while i < mega_no do
      client.query("insert into #{params[:table]} (value) values('#{content}');")
      i += 1
    end
    client.close
    'ok'
  rescue => e
    "#{e}"
  end
end

# helper methods
helpers do
  def parse_env()
    svcs = ENV['VMC_SERVICES']
    svcs = Yajl::Parser.parse(svcs)
    svcs.each do |svc|
      if svc["name"] =~ /db_quota_apppostgresql/
        opts = svc["options"]
        return opts
      end
    end
  end

  def db_name
    opts = parse_env
    opts["name"]
  end

  def prepare_data(mega)
    b = mega * 1024 * 1024
    c = [('a'..'z'),('A'..'Z')].map{|i| Array(i)}.flatten
    (0..b).map{ c[rand(c.size)] }.join
  end
end

def load_postgresql
  postgresql_service = load_service('postgresql')
  client = PGconn.open(postgresql_service['host'], postgresql_service['port'], :dbname => postgresql_service['name'], :user => postgresql_service['username'], :password => postgresql_service['password'])
  client
end

def load_service(service_name)
  services = JSON.parse(ENV['VMC_SERVICES'])
  service = services.find {|service| service["vendor"].downcase == service_name}
  service = service["options"] if service
end
