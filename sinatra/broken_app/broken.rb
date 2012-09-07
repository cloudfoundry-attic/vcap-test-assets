require 'rubygems'
require 'sinatra'
require 'junk'

get '/' do
  host = ENV['VCAP_APP_HOST']
  port = ENV['VCAP_APP_PORT']
  "<h1>Hello from a broken app on VCAP! via: #{host}:#{port}</h1>"
end
