require 'rubygems'
require 'sinatra'

BLOWUP_MEM = 512

get '/' do
  host = ENV['VCAP_APP_HOST']
  port = ENV['VCAP_APP_PORT']
  msg = "<h1>Hello from CpuHog! via: #{host}:#{port} </h1>"
  msg += "<h2>Visit /evil to trigger bad behavior to create processes to peg the cpu!.</h2>"
  msg += "<h1><font weight=bold color=red>DO NOT DO THIS ON A NON-SECURE DEA!</font></h1>"
end

get '/evil' do
  # Compile the app..
  `gcc -o peg peg.c`
  8.times do
    if pid = fork
      Process.detach(pid)
    else
      `./peg&`
    end
  end
  "BAD BAD!"
end
