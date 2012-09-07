require 'sinatra'
require 'json'
require 'carrot'
require 'uri'

get '/env' do
  ENV['VCAP_SERVICES']
end

get '/' do
  'hello from sinatra'
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end

get '/service/carrot/connection' do
  begin
    carrot = Carrot.new(:host => '127.0.0.1', :port =>1234, :user=>'testuser',
      :pass=>'testpass', :vhost=>'testvhost')
    carrot.server
  rescue Exception => e
    e.message.gsub(/\s+/, "")
  end
end

not_found do
  'This is nowhere to be found.'
end
