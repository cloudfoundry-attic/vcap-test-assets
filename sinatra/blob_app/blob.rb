require 'rubygems'
require 'sinatra'
require 'uri'
require 'json'
require 'net/http'
require 'net/http/digest_auth'
services = JSON.parse(ENV['VCAP_SERVICES'])
blob_gw = nil
services.each do |k,v|
  puts "#{k}"
  if k.match(/^vblob-/)
    blob_gw = v
  end
end

user = blob_gw[0]['credentials']['username']
passwd = blob_gw[0]['credentials']['password']
dest_port = blob_gw[0]['credentials']['port']
dest_host = blob_gw[0]['credentials']['host']

def make_request(dest_host, dest_port, user, passwd, method, resource, content)
  uri = URI.parse "http://#{dest_host}:#{dest_port}/#{resource}"
  uri.user = user
  uri.password = passwd
  h = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Get.new uri.request_uri
  res = h.request req
  digest_auth = Net::HTTP::DigestAuth.new
  auth = digest_auth.auth_header uri, res['www-authenticate'], method
  if method == 'GET'
    req = Net::HTTP::Get.new uri.request_uri
  elsif method == 'PUT'
    req = Net::HTTP::Put.new uri.request_uri
    if content != nil 
      req.body_stream=content
      req.add_field 'content-length', content.length
    end
  elsif method == 'DELETE'
    req = Net::HTTP::Delete.new uri.request_uri
  end
  req.add_field 'Authorization', auth
  res = h.request req
end

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  "<h1>XXXXX Hello from the Cloud! via: #{host}:#{port}</h1>"
end

get '/env' do
  res = ''
  ENV.each do |k, v|
    res << "#{k}: #{v}<br/>"
  end
  res
end

get '/list' do
  res = make_request dest_host, dest_port, user, passwd, 'GET', "", nil
  status res.code
  body res.body
end

post '/:container' do
  res = make_request dest_host, dest_port, user, passwd, 'PUT', "#{params[:container]}", nil
  status res.code
  body res.body
end

get '/:container' do
  res = make_request dest_host, dest_port, user, passwd, 'GET', "#{params[:container]}", nil
  status res.code
  body res.body
end

delete '/:container' do
  res = make_request dest_host, dest_port, user, passwd, 'DELETE', "#{params[:container]}", nil
  status res.code
  body res.body
end

post '/:container/:file' do
  res = make_request dest_host, dest_port, user, passwd, 'PUT', "#{params[:container]}/#{params[:file]}", request.body
  status res.code
  body res.body
end

get '/:container/:file' do
  res = make_request dest_host, dest_port, user, passwd, 'GET', "#{params[:container]}/#{params[:file]}", nil
  status res.code
  body res.body
end

delete '/:container/:file' do
  res = make_request dest_host, dest_port, user, passwd, 'DELETE', "#{params[:container]}/#{params[:file]}", nil
  status res.code
  body res.body
end
