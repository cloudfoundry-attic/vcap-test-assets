require 'rubygems'
require 'sinatra'
require 'json'

require "couchrest"

def get_service_info()
  services = JSON.parse(ENV['VCAP_SERVICES'])
  service_key = services.keys.select { |srv| srv =~ /couchdb/i }.first
  services[service_key].first['credentials']  
end

def get_couchdb_client()
  service = get_service_info
  host, port, user, pass = [service['host'], service['port'], service['username'], service['password']]

  @dbname = service['name']
  CouchRest.new("http://#{user}:#{pass}@#{host}:#{port}/")
end

post '/storeincouchdb' do
  params = JSON.parse request.body.read

  client = get_couchdb_client
  db = client.database!(@dbname)
  begin
    id = db.save_doc({
      "_id" => "testentry", 
      params['key'] => params['value']
    })
    "id = #{id}"
  rescue => ex
    "Error: #{ex}"
  end
end

get '/getfromcouchdb/:key', :provides => :json do |key|
  content_type :json

  client = get_couchdb_client
  db = client.database!(@dbname)

  v = db.get("testentry")[params['key']]
  { :requested_key => key, :value => v }.to_json
end

