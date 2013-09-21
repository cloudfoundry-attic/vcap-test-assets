require 'rubygems'
require 'sinatra'

# Unique identifier for the app's lifecycle.
#
# Useful for checking that an app doesn't die and come back up.
ID = SecureRandom.uuid

get '/' do
  host = ENV['VCAP_APP_HOST']
  port = ENV['VCAP_APP_PORT']
  "<h1>Hello from VCAP! via: #{host}:#{port}</h1>"
end

get '/id' do
  ID
end

get '/find/:filename' do
  files = `find / -name #{params[:filename]}`
  files
end

get '/sigterm' do
  "Available sigterms #{`man -k signal | grep list`}"
end

get '/delay/:seconds' do
  sleep params[:seconds].to_i
  "YAWN! Slept so well for #{params[:seconds].to_i} seconds"
end

get '/sigterm/:signal' do
  pid = Process.pid
  signal = params[:signal]
  puts "Killing process #{pid} with signal #{signal}"
  Process.kill(signal, pid)
end

get '/logspew/:bytes' do
  system "dd if=/dev/urandom of=/dev/stdout bs=1 count=#{params[:bytes].to_i} 2> /dev/null"
  "Just wrote #{params[:bytes]} random bytes to the log"
end

get '/env/:name' do
  ENV[params[:name]]
end

