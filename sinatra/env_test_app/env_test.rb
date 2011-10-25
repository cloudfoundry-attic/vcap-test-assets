require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'

$stdout.sync = true

def dump_env(fmt)
  if fmt == 'html' || fmt == nil
    res = ''
    ENV.each do |k, v|
      res << "#{k}: #{v}<br/>"
    end
    res
  elsif fmt == 'json'
    res = {}
    ENV.each do |k, v|
      res[k] = v
    end
    puts res
    res.to_json
  end
end

get '/' do
  dump_env('html')
end

get '/healthcheck' do
  "OK"
end

get '/env' do
  dump_env('json')
end


get '/services' do
  app_instance = JSON.parse(ENV['VMC_APP_INSTANCE'])
  services = JSON.parse(ENV['VMC_SERVICES'])

  valid_services = false
  service_list = []
  services.each do |v|
    s = {}
    s['type'] = v['type']
    s['vendor'] = v['vendor']
    s['name'] = v['name']
    service_list << s
    valid_services = true
  end
  response = "{\"status\":\"ok\", \"services\": #{service_list.to_json}}" if valid_services
  response = "{\"status\":\"fail\", \"services\": []}" if !valid_services

  puts "my response: #{response}"
  response
end
