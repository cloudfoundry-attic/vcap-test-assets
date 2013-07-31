require "sinatra"
require_relative "lib/memory_kudzu"

MEMORY = ENV["MEMORY"] ? ENV["MEMORY"].to_i : 120
set :port, ENV["PORT"] ? ENV["PORT.to_i"] : 3000

MemoryKudzu.grow_until(MEMORY)

get "/" do
  return "Sing"
end