require 'sinatra'
require 'redis'
require 'json'
require 'mongo'
require 'mysql2'
require 'carrot'
require 'uri'
require 'pg'

get '/env' do
  ENV['VMC_SERVICES']
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

not_found do
  'This is nowhere to be found.'
end


def load_redis
  Redis.new({:host => '127.0.0.1', :port => 6379, :password => 'testpw'})
end


