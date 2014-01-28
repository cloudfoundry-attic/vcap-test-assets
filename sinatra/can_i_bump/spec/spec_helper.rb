require "vcr"
require "support/can_i_bump_runner"

$:.unshift(File.expand_path("../lib", __FILE__))

RSpec.configure do |rspec_config|
  rspec_config.include(CanIBumpRunner)
end


VCR.configure do |c|
  c.cassette_library_dir = File.expand_path("../fixtures/vcr_cassettes", __FILE__)
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = {
    :serialize_with => :syck,
    :decode_compressed_response => true
  }
end