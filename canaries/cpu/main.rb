require "sinatra"

set :port, ENV["PORT"] ? ENV["PORT"].to_i : 3000
SLEEP = ENV["SLEEP"] ? ENV["SLEEP"].to_f : 0.000005 #this pegs one CPU at about 50% on a 3.4 GHz Intel Core i7

t1 = Thread.new do
  while true do
    ((2**30 - 1)*rand).floor & ((2**30 - 1)*rand).floor
    sleep SLEEP
  end
end

get "/" do
  return "Sing"
end