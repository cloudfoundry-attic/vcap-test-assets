require "webmock/rspec"
require "support/can_i_bump_runner"

$:.unshift(File.expand_path("../lib", __FILE__))

RSpec.configure do |rspec_config|
  rspec_config.include(CanIBumpRunner)

  WebMock.disable_net_connect!(:allow => /127.0.0.1/)
end