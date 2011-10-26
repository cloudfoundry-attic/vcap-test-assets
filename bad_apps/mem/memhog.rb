require 'rubygems'
require 'sinatra'

BLOWUP_MEM = 512

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  msg = "<h1>Hello from MemHog! via: #{host}:#{port} </h1>"
  msg += "<h2>Visit /evil to trigger bad behavior to create array of #{BLOWUP_MEM} Millions elements.</h2>"
  msg += "<h1><font weight=bold color=red>DO NOT DO THIS ON A NON-SECURE DEA!</font></h1>"
end

get '/evil' do
  @@stay_around = Array.new(BLOWUP_MEM*1024*1024, 'a')
  "BAD BAD!"
end
