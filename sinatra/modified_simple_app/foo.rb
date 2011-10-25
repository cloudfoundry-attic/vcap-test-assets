require 'rubygems'
require 'sinatra'

get '/' do
  host = ENV['VMC_DEA_HOST']
  port = ENV['VMC_DEA_PORT']
  "<h1>Hello from modified VCAP! via: #{host}:#{port}</h1>"
end

get '/crash/:id' do
  ps = "kill -9 #{params[:id]}"
  Kernel.`ps
end
