require 'rubygems'
require 'sinatra'

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  msg = "<h1>Hello from FDHog! via: #{host}:#{port} </h1>"
  msg += "<h2>Visit /evil to trigger bad behavior.</h2>"
  msg += "<h1><font weight=bold color=red>DO NOT DO THIS ON A NON-SECURE DEA!</font></h1>"
end

get '/evil' do
  @@stick_around ||= []
  # Try to get 10000 file descriptors (sockets)
  Socket.do_not_reverse_lookup = true
  (1..100000).each do |i|
    @@stick_around[i] = s = TCPServer.new(0)
    puts "#{i} --> PORT= #{s.addr[1]}"
  end
  "BAD BAD!"
end
