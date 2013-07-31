require "sinatra"
require_relative "lib/memory_kudzu"

MEMORY = ENV["MEMORY"] ? ENV["MEMORY"].to_i : 128 #64 seems to work on a 128mb instance
set :port, ENV["PORT"] ? ENV["PORT"].to_i : 3000

#foo = `ps -eo pid,rss,command` for debugging purposes

get "/" do
  "Sing"
end

Thread.new do
  sleep 60
  MemoryKudzu.grow_until(MEMORY)
end

