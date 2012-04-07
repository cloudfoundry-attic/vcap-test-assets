require 'rubygems'
require 'sinatra'
require 'json'
require 'data_mapper'

configure do

  begin
    services = JSON.parse(ENV['VCAP_SERVICES'])
    serviceKey = services.keys.select{|s| s =~ /mysql/i}.first
    service = services[serviceKey].first['credentials']
    host = service['host']
    port = service['port']
    username = service['username']
    password = service['password']
    database = service['name']
  rescue
    # connect local mysql server
    #host = 'localhost'
    #port = 27017
    #username = nil
    #password = nil
    #database = 'test'

    # connect mysql service via caldcott
    host = 'localhost'
    port = 1000
    username = 'xxxxx'
    password = 'xxxxx'
    database = 'xxxxx'
  end

  DataMapper::Logger.new($stdout, :debug)

  # with URI String
  #uri = "mysql://#{username}:#{password}@#{host}:#{port}/#{database}"
  #DataMapper.setup(:default, uri)

  # with Hash
  config = {
    :adapter  => 'mysql',
    :database => database,
    :username => username,
    :password => password,
    :host     => host,
    :port     => port
  }
  DataMapper.setup(:default, config)

  class Message
    include DataMapper::Resource
    property :id,           Serial
    property :message,      String, :length => 140, :allow_nil => false
    #property :created_at, DateTime, :default => DateTime.now
    auto_upgrade!
  end

  DataMapper.finalize
  
end

get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  res = ''
  res << "<h1>XXXXX Hello from VCAP via: #{host}:#{port}</h1>"
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

get "/mysql" do
  res = ''
  Message.all.each do |m|
    res << "#{m.message}<br/>"
  end
  res
end

get "/mysql/add/:message" do |m|
  Message.create :message => m
  redirect to('/mysql')
end

