require 'rubygems'
require 'sinatra'

BLOWUP_MB = 2

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  msg = "<h1>Hello from DiskHog! via: #{host}:#{port} </h1>"
  msg += "<h2>Visit /evil to trigger bad behavior</h2>"
end

def random_str(size)
 File.open('/dev/urandom') { |x| x.read(size).unpack('H*')[0] }
end

def bad_app(size)
 random_str(size)
end

get '/evil' do
  File.open('garbage' + random_str(5), 'w') do |f|
    (1..BLOWUP_MB).each { f.write(bad_app(2**26)) }
  end
  "BAD BAD!"
end