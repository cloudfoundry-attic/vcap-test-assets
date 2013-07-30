require "sinatra"

MEMORY = ENV["MEMORY"] ? ENV["MEMORY"].to_i : 1000
set :port, ENV["PORT"] ? ENV["PORT.to_i"] : 3000

foo = []
(6541*MEMORY).times do
  foo << rand.to_s.to_sym
end

get "/" do
  return "Sing"
end