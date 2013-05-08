require 'sinatra'
require 'sequel'
require 'json'
require_relative 'db_verifier'

get '/metrics' do
  DbVerifier.new.metrics.to_json
end
