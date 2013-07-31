require "sinatra"
require_relative('lib/babel_generator')

SPACE = ENV["SPACE"] ? ENV["SPACE"].to_i : 500
# if SPACE is 0, the app will use 102MB, instance has 1GB
DIR = ENV["DIR"] ? ENV["DIR"].to_s : "/tmp"
set :port, ENV["PORT"] ? ENV["PORT"].to_i : 3000

get "/" do
  return "Sing"
end

Thread.new do
  babel = BabelGenerator.new(DIR)
  babel.cleanup
  babel.populate_until(SPACE)
end