require "sinatra"

set :port, ENV["PORT"] ? ENV["PORT"].to_i : 3000
SLEEP = ENV["SLEEP"] ? ENV["SLEEP"].to_f : 0.000002 #this pegs one CPU at about 50% on a 3.4 GHz Intel Core i7
# on a1 it uses about 16% of the CPU
# 8,9 cpu 512M       (256M x 2)   0: 16.3%, 1: 16.7%


t1 = Thread.new do
  while true do
    ((2**30 - 1)*rand).floor & ((2**30 - 1)*rand).floor
    sleep SLEEP
  end
end

get "/" do
  return "Sing"
end