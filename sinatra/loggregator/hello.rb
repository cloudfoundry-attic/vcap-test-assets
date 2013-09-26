require 'rubygems'
require 'sinatra'
STDOUT.sync = true

get '/' do
  host = ENV['VCAP_APP_HOST']
  port = ENV['VCAP_APP_PORT']
  "<h1>Hello from VCAP! via: #{host}:#{port}</h1>"
  STDOUT.puts("Hello on STDOUT")
  STDERR.puts("Hello on STDERR")
end

