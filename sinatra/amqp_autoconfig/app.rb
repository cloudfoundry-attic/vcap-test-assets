require 'sinatra'
require 'json/pure'
require 'uri'
require 'amqp'
require 'cfautoconfig'

get '/env' do
  ENV['VCAP_SERVICES']
end

get '/' do
  'hello from sinatra'
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end

not_found do
  'This is nowhere to be found.'
end

post '/service/amqpoptions/:key' do
  value = request.env["rack.input"].read
  write_to_rabbit_connecting_with_options(params[:key], value)
end

get '/service/amqpoptions/:key' do
  options.amqp_option_msg
end

post '/service/amqpurl/:key' do
  value = request.env["rack.input"].read
  write_to_rabbit_connecting_with_url(params[:key], value)
end

get '/service/amqpurl/:key' do
  options.amqp_url_msg
end

def write_to_rabbit_connecting_with_options(key, value)
  EventMachine.run do
    connection = AMQP.connect(:host => '127.0.0.1', :port => 4567)
    channel  = AMQP::Channel.new(connection)
    queue    = channel.queue(key, :auto_delete => true)
    exchange = channel.default_exchange
    queue.subscribe do |payload|
      puts "Received a message: #{payload}. Disconnecting..."
      set :amqp_option_msg, payload
      connection.close { EventMachine.stop }
    end
    exchange.publish value, :routing_key => queue.name, :app_id => "Hello world"
  end
end

def write_to_rabbit_connecting_with_url(key, value)
  EventMachine.run do
    connection = AMQP.connect('amqp://testuser:testpass@127.0.0.1:1234/testvhost')
    channel  = AMQP::Channel.new(connection)
    queue    = channel.queue(key, :auto_delete => true)
    exchange = channel.default_exchange
    queue.subscribe do |payload|
      puts "Received a message: #{payload}. Disconnecting..."
      set :amqp_url_msg, payload
      connection.close { EventMachine.stop }
    end
    exchange.publish value, :routing_key => queue.name, :app_id => "Hello world"
  end
end
