require 'rubygems'
require 'sinatra'
require 'json'
require 'rest-client'

ES_INDEX = "inbox"
ES_TYPE = "message"

def elasticsearch_url
  services = JSON.parse(ENV['VCAP_SERVICES'])
  elasticsearch_key = services.keys.select { |srv| srv =~ /elasticsearch/i }.first
  elasticsearch = services[elasticsearch_key].first['credentials']
  "#{elasticsearch['url']}/#{ES_INDEX}/#{ES_TYPE}"
end

def save_to_elasticsearch(params)
  begin
    document = { "message" => params[:message]  }.to_json
    RestClient.put "#{elasticsearch_url}/#{params[:id]}", document
  rescue => ex
    "Error: #{ex}"
  end
end

get '/' do
  host = ENV['VCAP_APP_HOST']
  port = ENV['VCAP_APP_PORT']
  "<h1>Hello from the Cloud! via: #{host}:#{port}</h1>" \
  "elasticsearch url: #{elasticsearch_url}"
end

get '/es/get/:id' do
  begin
    RestClient.get "#{elasticsearch_url}/#{params[:id]}"
  rescue => ex
    "Error: #{ex}"
  end
end

# NOTE: this should really be post, but we use get here for ease of testing
# directly using a browser
get '/es/save/:id/:message' do
  save_to_elasticsearch(params)
end

post '/es/save' do
  save_to_elasticsearch(params)
end
