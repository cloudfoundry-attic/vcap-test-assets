require 'main'

use Rack::ShowExceptions
run Rack::URLMap.new \
  "/"       => RackServiceApp.new
