require 'app'

use Rack::ShowExceptions
run Rack::URLMap.new \
  "/"       => RackAutoConfigApp.new
