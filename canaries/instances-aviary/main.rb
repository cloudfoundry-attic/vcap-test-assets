require "sinatra"
require "cfoundry"

TARGET = ENV["TARGET"]
USERNAME = ENV["USERNAME"]
PASSWORD = ENV["PASSWORD"]

set :port, ENV["PORT"].to_i

get "/" do
  client = CFoundry::Client.get(TARGET)
  client.login(username: USERNAME, password: PASSWORD)

  client.current_organization = client.organization_by_name("pivotal")
  client.current_space = client.space_by_name("coal-mine")

  client.current_space.summarize!

  webscale = client.app_by_name("instances-canary")

  expected = webscale.total_instances
  actual = webscale.running_instances

  running_ratio = (expect - actual) / expected

  if running_ratio < 0.1
    raise "Instances canary croaked (ratio: #{running_ratio * 100}%)"
  end

  "Instances canary sings"
end
