require 'rubygems'
require 'sinatra'

BLOWUP_MB = 100

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  msg = "<h1>Hello from DiskHog! via: #{host}:#{port} </h1>"
  msg += "<h2>Visit /evil to trigger bad behavior to create a file of size #{BLOWUP_MB} MB.</h2>"
end

get '/evil' do
  a = Array.new(1024*1024, 'a')
  File.open('garbage', 'w') do |f|
    (1..BLOWUP_MB).each { f.puts "#{a}" }
  end
  "BAD BAD!"
end
