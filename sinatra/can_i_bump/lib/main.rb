require "sinatra"

$:.unshift(File.expand_path("../../lib", __FILE__))

require "deciders/jenkins"
require "deciders/pingdom"
require "final_decider"

jenkins = Decider::Jenkins.new
pingdom = Decider::Pingdom.new(
  ENV["PINGDOM_APP_KEY"],
  ENV["PINGDOM_USERNAME"],
  ENV["PINGDOM_PASSWORD"],
  ENV["PINGDOM_HOSTNAME"]
)

final_decider = FinalDecider.new([jenkins, pingdom])

put "/:value" do |value|
  if params["token"] != ENV["CAN_I_BUMP_TOKEN"]
    status 401
    return
  end

  if value != "yes" && value != "no"
    status 500
    body "Incorrect value"
  else
    jenkins.set_can_i_bump(value, params["reason"])
  end
end

get "/" do
  erb :main, :locals => { can_i_bump: final_decider.can_i_bump?, reasons: final_decider.reasons }
end
