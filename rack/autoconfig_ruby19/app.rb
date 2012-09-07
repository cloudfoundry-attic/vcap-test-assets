require 'sinatra'
require 'redis'
require 'json'
require 'uri'

class RackAutoConfigApp < Sinatra::Base
get '/env' do
  ENV['VCAP_SERVICES']
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

def load_redis
  Redis.new({:host => '127.0.0.1', :port => 6379, :password => 'testpw'})
end
end
