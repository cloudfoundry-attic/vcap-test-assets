require 'sinatra'

get '/:seconds' do |s|
  sleep s.to_f
  "slept for #{s} seconds"
end
