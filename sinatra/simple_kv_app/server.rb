require 'sinatra'

# a toy in memory key-value service

@@value = {}

get '/info' do
  "#{ENV["VCAP_APP_HOST"]}:#{ENV["VCAP_APP_PORT"]}"
end

get '/list' do
  @@value.inspect
end

get '/service/:key' do
  value = @@value[params[:key]]
  halt 404 unless value
  value
end

post '/service/:key' do
  key = params[:key]
  @@value[key] = request.body.read
  # return created
  [201, {'Location'=>"/service/#{key}"}, ""]
end
