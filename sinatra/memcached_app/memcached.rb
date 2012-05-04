require 'rubygems'
require 'sinatra'
require 'json'

require 'dalli'


def get_memcached_service_info
  services = JSON.parse(ENV['VCAP_SERVICES']) 
  memcached_key = services.keys.select { |srv| srv =~ /memcached/i }.first
  memcached = services[memcached_key].first['credentials']
  [memcached['host'], memcached['port'], memcached['user'], memcached['password']]
end

def get_dalli_client
  host, port, user, pass = get_memcached_service_info
  Dalli::Client.new("#{host}\:#{port}", :username => user, :password => pass)
end

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  "<h1>Hello from the Cloud! via: #{host}:#{port}</h1>"
end

get '/env' do
  res = ''
  ENV.each do |k, v|
    res << "#{k}: #{v}<br/>"
  end
  res
end

get '/svc' do
 ENV['VCAP_SERVICES']
end

get '/mc' do
  host, port, user, pass = get_memcached_service_info
  "<b>Memcached configured at</b><br>" \
  "host: #{host}<br>" \
  "port: #{port} <br>" \
  "username: #{user} <br>" \
  "password: #{pass}"
end

get '/mcget/:key' do
  begin
    client = get_dalli_client

    value = client.get(params[:key])
    "<H1>Getting from memcached</H1>" \
    "<b>#{params[:key]}</b> maps to #{value}"
  rescue => ex
    "Error: #{ex.to_s}"
  end
end

# NOTE: this should really be post, but we use get here for ease of testing 
# directly using a browser
get '/mcput/:key/:value' do
   begin
     client = get_dalli_client

     client.set(params[:key], params[:value])
     "<H1>Saved to memcached</H1>" \
     "<b>#{params[:key]}</b> = #{params[:value]}"
   rescue => ex
     "Error: #{ex.to_s}"
   end
end


get '/getfromcache/:key', :provides => :json do |key|
  content_type :json

  client = get_dalli_client
  v = client.get(params[:key])
  { :requested_key => key, :value => v }.to_json
end

post '/storeincache' do
   begin
     client = get_dalli_client
     params = JSON.parse request.body.read

     client.set(params['key'], params['value'])

     "<H1>Saved to memcached</H1>" \
     "<b>#{params[:key]}</b> = #{params[:value]}"
   rescue => ex
     "Error: #{ex.to_s}"
   end
end
