require "sinatra"

$:.unshift(File.expand_path("../../lib", __FILE__))

require "deciders/jenkins"

jenkins = Decider::Jenkins.new

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
  erb :main, :locals => { can_i_bump: jenkins.can_i_bump?, reason: jenkins.reason }
end
