require "sinatra"
require 'sys/filesystem'

SPACE = ENV["SPACE"] ? ENV["SPACE"].to_i : 500
DIR = ENV["DIR"] ? ENV["DIR"].to_s : "/tmp"
stat = Sys::Filesystem.stat('/')
set :port, ENV["PORT"] ? ENV["PORT"].to_i : 3000

`rm #{DIR}/SPACE*.txt`

stat = Sys::Filesystem.stat('/')
AVAIL_SPACE = stat.blocks_free * stat.block_size / 1024**2

def mb_used
  stat = Sys::Filesystem.stat('/')
  AVAIL_SPACE - (stat.block_size * stat.blocks_free / 1024**2)
end

def rando
  ((2**30 - 1)*rand).floor
end

while mb_used < SPACE
  puts mb_used
  f = File.new("#{DIR}/SPACE#{rando}.txt", "w+")
  (3*1024*1024).times do
    f.write(rand.to_s)
  end
  f.close()
end


get "/" do
  return "Sing"
end