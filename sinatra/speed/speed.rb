require 'rubygems'
require 'sinatra'

# Try to avoid gzip doing too much outbound

base = Array.new(600*1024) { "%01x" % rand(16) }.join('').freeze

set :_1k,   base[1, 1    * 1024]
set :_8k,   base[1, 8    * 1024]
set :_16k,  base[1, 16   * 1024]
set :_32k,  base[1, 32   * 1024]
set :_64k,  base[1, 64   * 1024]
set :_128k, base[1, 128  * 1024]
set :_256k, base[1, 256  * 1024]
set :_512k, base[1, 512  * 1024]

get '/' do
  'ok'
end

get '/1k' do
  settings._1k
end

get '/8k' do
  settings._8k
end

get '/16k' do
  settings._16k
end

get '/32k' do
  settings._32k
end

get '/64k' do
  settings._64k
end

get '/128k' do
  settings._128k
end

get '/256k' do
  settings._256k
end

get '/512k' do
  settings._512k
end
