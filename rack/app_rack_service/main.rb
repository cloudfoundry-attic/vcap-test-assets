require 'sinatra'
require 'redis'
require 'json'
require 'mongo'
require 'mysql2'
require 'carrot'
require 'uri'
require 'pg'

class RackServiceApp < Sinatra::Base
get '/env' do
  ENV['VMC_SERVICES']
end

get '/' do
  'hello from sinatra'
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end

get '/service/redis/:key' do
  redis = load_redis
  redis[params[:key]]
end

post '/service/redis/:key' do
  redis = load_redis
  redis[params[:key]] = request.env["rack.input"].read
end

post '/service/mongo/:key' do
  coll = load_mongo
  value = request.env["rack.input"].read
  if coll.find('_id' => params[:key]).to_a.empty?
    coll.insert( { '_id' => params[:key], 'data_value' => value } )
  else
    coll.update( { '_id' => params[:key] }, { '_id' => params[:key], 'data_value' => value } )
  end
  value
end

get '/service/mongo/:key' do
  coll = load_mongo
  coll.find('_id' => params[:key]).to_a.first['data_value']
end

not_found do
  'This is nowhere to be found.'
end

post '/service/mysql/:key' do
  client = load_mysql
  value = request.env["rack.input"].read
  key = params[:key]
  result = client.query("select * from data_values where id='#{key}'")
  if result.count > 0
    client.query("update data_values set data_value='#{value}' where id='#{key}'")
  else
    client.query("insert into data_values (id, data_value) values('#{key}','#{value}');")
  end
  client.close
  value
end

get '/service/mysql/:key' do
  client = load_mysql
  result = client.query("select data_value from  data_values where id = '#{params[:key]}'")
  value = result.first['data_value']
  client.close
  value
end

post '/service/postgresql/:key' do
  client = load_postgresql
  value = request.env["rack.input"].read
  client.query("insert into data_values (id, data_value) values('#{params[:key]}','#{value}');")
  client.close
  value
end

get '/service/postgresql/:key' do
  client = load_postgresql
  value = client.query("select data_value from  data_values where id = '#{params[:key]}'").first['data_value']
  client.close
  value
end

post '/service/rabbit/:key' do
  value = request.env["rack.input"].read
  client = rabbit_service
  write_to_rabbit(params[:key], value, client)
  value
end

get '/service/rabbit/:key' do
  client = rabbit_service
  read_from_rabbit(params[:key], client)
end

post '/service/rabbitmq/:key' do
  value = request.env["rack.input"].read
  client = rabbit_srs_service
  write_to_rabbit(params[:key], value, client)
  value
end

get '/service/rabbitmq/:key' do
  client = rabbit_srs_service
  read_from_rabbit(params[:key], client)
end

def load_redis
  redis_service = load_service('redis')
  Redis.new({:host => redis_service["hostname"], :port => redis_service["port"], :password => redis_service["password"]})
end

def load_mysql
  mysql_service = load_service('mysql')
  client = Mysql2::Client.new(:host => mysql_service['hostname'], :username => mysql_service['user'], :port => mysql_service['port'], :password => mysql_service['password'], :database => mysql_service['name'])
  result = client.query("SELECT table_name FROM information_schema.tables WHERE table_name = 'data_values'");
  client.query("Create table IF NOT EXISTS data_values ( id varchar(20), data_value varchar(20)); ") if result.count != 1
  client
end

def load_mongo
  mongodb_service = load_service('mongodb')
  conn = Mongo::Connection.new(mongodb_service['hostname'], mongodb_service['port'])
  db = conn[mongodb_service['db']]
  coll = db['data_values'] if db.authenticate(mongodb_service['username'], mongodb_service['password'])
end

def load_postgresql
  postgresql_service = load_service('postgresql')
  client = PGconn.open(postgresql_service['host'], postgresql_service['port'], :dbname => postgresql_service['name'], :user => postgresql_service['username'], :password => postgresql_service['password'])
  client.query("create table data_values (id varchar(20), data_value varchar(20));") if client.query("select * from information_schema.tables where table_name = 'data_values';").first.nil?
  client
end

def load_service(service_name)
  services = JSON.parse(ENV['VMC_SERVICES'])
  service = services.find {|service| service["vendor"].downcase == service_name}
  service = service["options"] if service
end

def rabbit_service
  service = load_service('rabbitmq')
  Carrot.new( :host => service['hostname'], :port => service['port'], :user => service['user'], :pass => service['pass'], :vhost => service['vhost'] )
end

def rabbit_srs_service
  service = load_service('rabbitmq')
  uri = URI.parse(service['url'])
  host = uri.host
  port = uri.port
  user = uri.user
  pass = uri.password
  vhost = uri.path[1..uri.path.length]
  Carrot.new( :host => host, :port => port, :user => user, :pass => pass, :vhost => vhost )
end

def write_to_rabbit(key, value, client)
  q = client.queue(key)
  q.publish(value)
end

def read_from_rabbit(key, client)
  q = client.queue(key)
  msg = q.pop(:ack => true)
  q.ack
  msg
end
end
