require 'sinatra'
require 'net/http'
require 'uri'
require 'yajl'

# To use this application, bind a simple key-value application as
# brokered service.

get '/service' do
  ENV['VCAP_SERVICES']
end

# example post /brokered-service/simple-kv with body key1:value1
# app will search for services with given key
post '/brokered-service/:label' do
  label = params[:label]
  puts "searching service: #{label}"
  svcs = Yajl::Parser.parse(ENV["VCAP_SERVICES"], :symbolize_keys => true)
  bsvc = nil
  svcs.each do |k,v|
    if k == label.to_sym
      bsvc = v[0]
    end
  end
  halt 404, "Can't find service #{label}" unless bsvc
  url = bsvc[:credentials][:url]
  key, value = request.body.read.split(":")
  uri = URI.parse(url)
  req = Net::HTTP::Post.new("/service/#{key}")
  req.body = value
  res = Net::HTTP.new(uri.host, uri.port).start {|http| http.request(req) }
  halt 500, "Error when communicate with #{label}: status=#{res.code}, msg=#{res.message}" unless res.is_a? Net::HTTPSuccess
  ""
end
