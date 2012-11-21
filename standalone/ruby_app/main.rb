require 'sinatra'

get '/env' do
  ENV['VCAP_SERVICES']
end

get '/' do
    "running version #{RUBY_VERSION}"
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end

not_found do
  'This is nowhere to be found.'
end
