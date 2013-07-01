require 'sinatra'

get '/' do
  File.new(File.expand_path('file_in_resource_pool', File.dirname(__FILE__))).size.to_s
end