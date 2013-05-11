require 'rubygems'
require 'sinatra'

get '/' do
  msg = "<h1>Hello from Crash! </h1>"
  msg += "<h2>Visit /crash to trigger the application to kill itself.</h2>"
  msg += "<h1><font weight=bold color=red>DO NOT DO THIS ON A NON-SECURE DEA!</font></h1>"
end


get "/crash" do
Process.kill("KILL", Process.pid)
end


