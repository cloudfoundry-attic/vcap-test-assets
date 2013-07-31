require 'rspec'
require 'rack/test'

require_relative '../lib/babel_generator'


RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end