require "sinatra"

can_i_bump = "no"
reason = "No data yet"

put "/:value" do |value|
  if params["token"] != ENV["CAN_I_BUMP_TOKEN"]
    status 401
    return
  end

  if value != "yes" && value != "no"
    status 500
    body "Incorrect value"
  else
    can_i_bump = value
    reason = params["reason"]
  end
end

get "/" do
  erb :main, :locals => { can_i_bump: can_i_bump == "yes", reason: reason }
end
