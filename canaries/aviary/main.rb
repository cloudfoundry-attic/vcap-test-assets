require "sinatra"
require "cfoundry"
require_relative 'lib/instances_aviary'
require_relative 'lib/zero_downtime_aviary'

TARGET = ENV["TARGET"]
USERNAME = ENV["USERNAME"]
PASSWORD = ENV["PASSWORD"]
ORG = 'pivotal'
DOMAIN = ENV["DOMAIN"]
SPACE = "coal-mine"
ZERO_DOWNTIME_NUM_INSTANCES = ENV['NUM_INSTANCES']

set :port, ENV["PORT"].to_i

get "/instances_aviary" do
  aviary = InstancesAviary.new(TARGET, USERNAME, PASSWORD, ORG, SPACE, "instances-canary")
  check(aviary)
end

get "/zero_downtime_aviary" do
  aviary = ZeroDowntimeAviary.new(DOMAIN,'zero-downtime-canary', ZERO_DOWNTIME_NUM_INSTANCES )
  check(aviary)
end

def check(aviary)
  if aviary.ok?
    return "Sing"
  else
    status 500
    body "zero downtime canary croaked (#{aviary.error_message}%)"
  end
end