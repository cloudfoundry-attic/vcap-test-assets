require 'sinatra'
require 'json'
require 'uri'
require 'pg'
require "yajl"
require 'eventmachine'

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

post '/service/mysql/querytime/:time' do
  client = load_mysql
  results = client.query("select sleep(#{params[:time]})")
  client.close
  res = 0
  results.each{|rs|
    res = rs.values[0].to_i
  }
  if res == 0
    return "OK"
  elsif res == 1
    return "query interrupted"
  end
end

post '/service/postgresql/querytime/:time' do
  client = load_postgresql
  begin
    client.query("select pg_sleep(#{params[:time]})")
    result = "OK"
  rescue Exception => e
    puts e.message
    result = "query interrupted"
  ensure
    client.close if client
  end
  result
end

post '/service/mysql/txtime/:time' do
  EventMachine.run{
    client = load_mysql
    client.query("drop table if exists a")
    client.query("create table a (id int) engine=innodb")
    client.query("begin")
    client.query("select * from a for update")
    EventMachine.add_timer(params[:time].to_i){
      begin
        client.query("select * from a for update")
        result = "OK"
      rescue Exception => e
        puts e.message
        result = "transaction interrupted"
      ensure
        client.close if client
      end
      return result
      EventMachine.stop
    }
  }
end

post '/service/postgresql/tables/:table' do
  client = load_postgresql
  begin
    client.query("create table #{params[:table]} (value text);")
    params[:table]
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
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
  begin
    client.query("create function #{params[:function]}() returns integer as 'select 1234;' language sql;")
    params[:function]
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

post '/service/postgresql/sequences/:sequence' do
  client = load_postgresql
  begin
    client.query("create sequence #{params[:sequence]};")
    params[:sequence]
  rescue => e
    "#{e}"
  ensure
    client.close if client
  end
end

# delete from table
delete '/service/postgresql/tables/:name/data' do
  client = load_postgresql
  table = params[:name]
  # truncate is preferred and much faster, furthermore, it reclaims disk space immediately
  # see also http://wiki.postgresql.org/wiki/VACUUM_FULL
  #client.query("delete from #{table};")
  #client.query("vacuum full #{table};")
  client.query("truncate table #{table};")
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
post '/service/postgresql/tables/:name/:megabytes' do
  client = load_postgresql
  begin
    content = prepare_data(1)
    client = load_postgresql
    size = params[:megabytes].to_i
    i = 0
    while i < size do
      client.query("insert into #{params[:name]} (value) values('#{content}');")
      i += 1
    end
    'ok'
  rescue => e
    "#{e}"
  ensure
    client.close if client
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

  def prepare_data(size)
    b = size * 1024 * 1024
    c = [('a'..'z'),('A'..'Z')].map{|i| Array(i)}.flatten
    (0..b).map{ c[rand(c.size)] }.join
  end
end

def load_postgresql
  postgresql_service = load_service('postgresql')
  client = PGconn.open(postgresql_service['host'], postgresql_service['port'], :dbname => postgresql_service['name'], :user => postgresql_service['username'], :password => postgresql_service['password'])
  client
end

def load_mysql
  mysql_service = load_service('mysql')
  client = Mysql2::Client.new(:host => mysql_service['hostname'], :port => mysql_service['port'], :username => mysql_service['user'], :password => mysql_service['password'])
  client
end

def load_service(service_name)
  services = JSON.parse(ENV['VMC_SERVICES'])
  service = services.find {|service| service["vendor"].downcase == service_name}
  service = service["options"] if service
end
