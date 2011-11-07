require 'rubygems'
require 'sinatra'
require 'uri'
require 'aws/s3'
require 'json'

services = JSON.parse(ENV['VCAP_SERVICES'])
blob_gw = nil
services.each do |k,v|
  puts "#{k}"
  if k.match(/^blob-/)
    blob_gw = v
  end
end

begin
AWS::S3::Base.establish_connection!(
    :access_key_id     => blob_gw[0]['credentials']['username'],
    :secret_access_key => blob_gw[0]['credentials']['password'],
    :port => blob_gw[0]['credentials']['port'],
    :server => blob_gw[0]['credentials']['host']
  ) unless blob_gw == nil
rescue => e
  puts "#{e}"
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
  if blob_gw == nil
    return
  end
  buckets = AWS::S3::Service.buckets(:reload)
  buckets.inspect
end

post '/:bucket' do
  begin
    rc = AWS::S3::Bucket.create params[:bucket]
    rc
  rescue => e
    e.inspect
  end
end

get '/:bucket' do
  begin
    buck = AWS::S3::Bucket.find params[:bucket]
    buck.inspect
  rescue => e
    e.inspect
  end
end

delete '/:bucket' do
  begin
    rc = AWS::S3::Bucket.delete params[:bucket]
    rc
  rescue => e
    e.inspect
  end
end

post '/:bucket/:object' do
  begin
    rc = AWS::S3::S3Object.store(params[:object],request.body,params[:bucket])
    rc
  rescue => e
    e.inspect
  end
end

get '/:bucket/:object' do
  begin
    content = AWS::S3::S3Object.value params[:object],params[:bucket]
    content
  rescue => e
    e.inspect
  end
end

delete '/:bucket/:object' do
  begin
    rc = AWS::S3::S3Object.delete params[:object],params[:bucket]
    rc
  rescue => e
    e.inspect
  end
end
