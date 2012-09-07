#require 'rubygems'
#require 'bundler'
#Bundler.setup
require 'rubygems'
require 'sinatra'
require 'yaml'
require 'optparse'
require 'thin'
require 'datamapper'
require 'dm-migrations'
require 'logger'
require 'pp'

$:.unshift(File.join(File.dirname(__FILE__), 'lib/models'))
require 'user'

configure do
  port = nil # Allow override of this on command line
  config_file = File.join(File.dirname(__FILE__), 'config/simple_db_app.yml')

  begin
    config = File.open(config_file) do |f|
      YAML.load(f)
    end
  rescue => e
    puts "Could not read configuration file:  #{e}"
    exit
  end

  # Next two lines are needed in order to have error handlers work
  # These lines shouldn't be needed if http://groups.google.com/group/sinatrarb/browse_thread/thread/27572882da4a4bbe
  # is to be believed... oh, well
  set(:raise_errors, false)
  set(:show_exceptions, false)

  logger = Logger.new(config['log_file'] ? config['log_file'] : STDOUT, 'daily')
  logger.level = Logger::DEBUG
  {
    :logger => logger
  }.each {|k,v| set(k, v) }


  # Reset current working directory for sqlite databases.
  Dir.chdir(File.dirname(__FILE__))
  Sinatra::Application.logger.debug "Current wd = #{File.dirname(__FILE__)}"
  DataMapper::Logger.new(STDOUT, :debug)
  Sinatra::Application.logger.debug "DB setup #{config['database_uri']}"
  DataMapper.setup(:default, config['database_uri'])
  DataMapper::auto_upgrade!

  # Announce we are starting up
  logger.info("simple_db_app starting up..")
end

helpers do
  def unmarshall(json_str)
    json_object = JSON.parse(json_str)
  end
end

get '/' do
  host = ENV['VCAP_DEA_HOST']
  port = ENV['VCAP_DEA_PORT']
  "<h1>Hello from Simple DB app! via: #{host}:#{port}</h1>"
end

get '/users/:id' do
  Sinatra::Application.logger.debug "get /users #{params[:id]}"
  content_type :json
  user = User.first(:id => params[:id])
  if (user != nil)
    attr = user.attributes
    Sinatra::Application.logger.debug "get #{params[:id]} #{attr}"
    attr.to_json
  else
    puts "#{params[:id]} not found"
    status 404
  end
end

post '/users' do
  user_hash = JSON.parse(request.body.read)
  Sinatra::Application.logger.debug "post /users #{user_hash['id']}, #{user_hash['desc']}"
  user_id = user_hash['id']
  user_desc = user_hash['desc']
  if (user_id == nil)
    status 400
  end

  user = User.first(:id => user_id)
  if user != nil
    status 400
  end
  user = User.new(:id => user_id, :desc => user_desc)
  user.save
end

put '/users/:id' do
  user_id = params[:id]
  user_hash = JSON.parse(request.body.read)
  Sinatra::Application.logger.debug "put /users #{user_hash['id']}, #{user_hash['desc']}"
  new_user_desc = user_hash['desc']
  if (user_id == nil)
    status 400
  end

  user = User.first(:id => user_id)
  if user == nil
    status 400
  end
  current_desc = user['desc']
  Sinatra::Application.logger.debug "Changing desc #{current_desc} to #{new_user_desc} for user id #{user_id} from db"
  user['desc'] = new_user_desc
  user.save!
end

delete '/users/:id' do
  Sinatra::Application.logger.debug "delete /users #{params[:id]}"
  status 400 unless params[:id] != nil
  user = User.first(:id => params[:id])
  if user != nil
    user.destroy
  else
    status 404
  end
end
