require 'sinatra'

get '/env' do
  ENV["VCAP_SERVICES"] || "nil"
end
