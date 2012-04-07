#puts "$LOAD_PATH : #{$LOAD_PATH.join(", ")}"
require 'rubygems'
#puts "Gem.path   : #{Gem.path.join(", ")}"
require 'sinatra'
require 'java'
  
get '/' do
  host = ENV['VMC_APP_HOST']
  port = ENV['VMC_APP_PORT']
  res = ''
  res << "<h1>XXXXX Hello from VCAP! via: #{host}:#{port}</h1>"
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
