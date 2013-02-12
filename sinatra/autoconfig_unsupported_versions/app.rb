require 'sinatra'
require 'redis'
require 'json'
require 'mongo'
require 'mysql2'
require 'uri'
require 'pg'
require 'cfautoconfig'

get '/env' do
  ENV['VCAP_SERVICES']
end

get '/' do
  'hello from sinatra'
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end

get '/service/redis/connection' do
  begin
    redis = load_redis
    redis[:host] + ':' + redis[:port]
  rescue Exception => e
    e.message.gsub(/\s+/, "")
  end
end

get '/service/mongo/connection' do
  begin
    mongo = load_mongo
    mongo.host_to_try
  rescue Exception => e
    e.message.gsub(/\s+/, "")
  end
end

get '/service/mysql/connection' do
  begin
    mysql = load_mysql
    mysql.query_options[:host] + ':' +  mysql.query_options[:port]
  rescue Exception => e
    e.message.gsub(/\s+/, "")
  end
end

get '/service/amqp/connection' do
  begin
    EventMachine.run do
      connection = AMQP.connect(:host => '127.0.0.1', :port => 4567)
    end
  rescue Exception => e
    e.message.gsub(/\s+/, "")
  end
end

get '/service/postgres/connection' do
  begin
    PGconn.open(:host=> '127.0.0.1', :port=> '8675', :dbname => 'testdb', :user => 'testuser', :password => 'testpw')
  rescue Exception => e
    e.message.gsub(/\s+/, "")
  end
end

not_found do
  'This is nowhere to be found.'
end


def load_redis
  Redis.new({:host => '127.0.0.1', :port => 6379, :password => 'testpw'})
end

def load_mongo
  conn = Mongo::Connection.new('127.0.0.1', 4567)
  db = conn['testdb']
  coll = db['data_values']
end

def load_mysql
  Mysql2::Client.new(:host => '127.0.0.1', :username =>'testuser', :port => 3834, :password => 'testpw', :database => 'testdb')
end
