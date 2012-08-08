require "sinatra"
require "vcap/logging"
require "eventmachine"

logger = VCAP::Logging.logger("hello from git")

get "/" do
  logger.name
end