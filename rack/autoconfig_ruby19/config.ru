require File.join(File.expand_path('../', __FILE__), 'app.rb')

use Rack::ShowExceptions
run Rack::URLMap.new \
  "/"       => RackAutoConfigApp.new
