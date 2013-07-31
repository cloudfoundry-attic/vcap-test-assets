require 'rspec'
require 'rack/test'

require_relative '../lib/memory_kudzu'


RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end