require "sinatra"

get "/health" do
  "ok"
end

get "/ruby_version" do
  RUBY_VERSION
end
