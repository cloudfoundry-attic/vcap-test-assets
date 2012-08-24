# my_app.rb
require 'sinatra/base'
require 'json'
require 'cfruntime'

class SecondApp < Sinatra::Base

  get '/module' do
    "hello from module"
  end

end

class MyApp < Sinatra::Base
  use SecondApp

  configure do
    set(:port, CFRuntime::CloudApp.port || 4567)
  end

  get '/' do
    "hello from sinatra"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
