require "sinatra"

get "/health" do
  "ok"
end

get "/sleep" do
  duration = params[:duration].to_i
  halt 400, "Duration must be positive integer" unless duration > 0

  sleep(duration)
  "slept for #{duration} secs"
end
