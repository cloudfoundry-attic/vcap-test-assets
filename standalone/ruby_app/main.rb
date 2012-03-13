require 'sinatra'

get '/env' do
  ENV['VMC_SERVICES']
end

get '/' do
   if RUBY_VERSION =~ /\A1.8/
     "running version 1.8"
   elsif RUBY_VERSION =~ /\A1.9/
     "running version 1.9"
   else
     "unexpected ruby version #{RUBY_VERSION}"
   end
end

get '/crash' do
  Process.kill("KILL", Process.pid)
end

not_found do
  'This is nowhere to be found.'
end
