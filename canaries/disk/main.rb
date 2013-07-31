require "sinatra"
require_relative('lib/babel_generator')

SPACE = ENV["SPACE"] ? ENV["SPACE"].to_i : 500
DIR = ENV["DIR"] ? ENV["DIR"].to_s : "/tmp"
set :port, ENV["PORT"] ? ENV["PORT"].to_i : 3000

babel = BabelGenerator.new(DIR)
babel.cleanup
babel.populate_until(SPACE)

get "/" do
  return "Sing"
end