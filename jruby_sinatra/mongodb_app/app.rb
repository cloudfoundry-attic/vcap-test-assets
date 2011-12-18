require 'rubygems'
require 'sinatra'
require 'json'
require 'mongoid'

configure do

  begin
    services = JSON.parse(ENV['VCAP_SERVICES'])
    mongoKey = services.keys.select{|s| s =~ /mongodb/i}.first
    mongo = services[mongoKey].first['credentials']
    host = mongo['host']
    port = mongo['port']
    username = mongo['username']
    password = mongo['password']
    db = mongo['db']
  rescue
    host = "localhost"
    port = 27017
    username = nil
    password = nil
    db = "sinatra_mongodb_sample"
  end

  uri = "mongodb://#{username}:#{password}@#{host}:#{port}/#{db}"

  Mongoid.configure do |config|
    config.master = Mongo::Connection.from_uri(uri).db(db)
  end

end

class Message
  include Mongoid::Document
  field :message
end

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  res = ''
  res << "<h1>XXXXX Hello from the Cloud! via: #{host}:#{port}</h1>"
  res << "<ul>"
  res << "<li>RUBY_ENGINE : #{ defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'unknown' }</li>"
  res << "<li>RUBY_VERSION : #{ defined?(RUBY_VERSION) ? RUBY_VERSION : 'unknown' }</li>"
  res << "<li>JRUBY_VERSION : #{ defined?(JRUBY_VERSION) ? JRUBY_VERSION : 'unknown' }</li>"
  res << "</ul>"
  res
end

get '/env' do
  res = ''
  ENV.each do |k, v|
    res << "#{k}: #{v}<br/>"
  end
  res
end

get '/env_java' do
  res = ''
  java.lang.System.getProperties.each do |k, v|
    res << "#{k}: #{v}<br/>"
  end
  res
end

get "/mongodb" do
  res = ''
  res << "<h1>Messages:</h1>"
  res << "<ul>"
  Message.all.find_all.each do |m|
    res << "<li>#{m.message}</li>"
  end
  res << "</ul>"
  res
end

get "/mongodb/add/:message" do |m|
  Message.new(:message => m).save()
  redirect to('/mongodb')
end

