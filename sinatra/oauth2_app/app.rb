require 'sinatra'
require 'base64'
require 'yajl'
require 'omniauth-uaa-oauth2'
require 'restclient'

enable :sessions

config = {}

config = {:token_server_url => "http://localhost:8080/uaa",
:cloud_controller => "http://localhost:8080/api", :client_id => "app",
:client_secret => "appclientsecret"}

SERVICE_LABEL = 'oauth2-1.0'.to_sym
services = JSON.parse(ENV['VCAP_SERVICES']||"{}", :symbolize_keys=>true)
if services[SERVICE_LABEL] && services[SERVICE_LABEL].length>0
  config.merge!(services[SERVICE_LABEL][0][:credentials])
  prefix = ENV["PORT"] ? 'ccng' : 'api'
  config[:cloud_controller] = config[:auth_server_url].sub(/\/\/[^.]*\./,"//#{prefix}.") if config[:auth_server_url]
end

puts "Config: #{config.inspect}"

# URL of the uaa token server
config[:token_server_url] = ENV['UAA_TOKEN_SERVER'] if ENV['UAA_TOKEN_SERVER']
# URL of the uaa login (SSO) server
config[:auth_server_url] = ENV['UAA_LOGIN_SERVER'] if ENV['UAA_LOGIN_SERVER']
config[:auth_server_url] ||= config[:token_server_url]
# URL of the cloud_controller
config[:cloud_controller] = ENV['CLOUD_CONTROLLER_SERVER'] if ENV['CLOUD_CONTROLLER_SERVER']
# CLIENT_ID
config[:client_id] = ENV['CLIENT_ID'] if ENV['CLIENT_ID']
# CLIENT_SECRET
config[:client_secret] = ENV['CLIENT_SECRET'] if ENV['CLIENT_SECRET']

puts "Services: #{services.inspect}"
puts "Config: #{config.inspect}"

use OmniAuth::Builder do
  provider :cloudfoundry, config[:client_id], config[:client_secret], {:auth_server_url => config[:auth_server_url], :token_server_url => config[:token_server_url]}
end

before do
  unprotected = ['/auth/cloudfoundry/callback', '/logout']
  if !unprotected.include?(request.path_info) then
     redirect '/auth/cloudfoundry' unless session[:auth]
  end
end

get '/' do
  <<-HTML
<html>
<body>
	<h1>Sample Home Page</h1>
	<p>Welcome #{session[:user]["name"]}</p>
	<ul>
		<li><a href="/apps">Apps</a></li>
		<li><a href="/logout">Logout</a></li>
		<li><a href="/">Home</a></li>
	</ul>
	<h3>Technical Information</h3>
	<p>Your principal object is....: #{session[:user].to_hash}</p>
	<p>Your authentication is....: #{session[:auth].to_hash}</p>
</body>
</html>
  HTML
end

get '/apps' do
  token = session[:auth][:credentials][:token]
  apps = JSON.parse(RestClient.get("#{config[:cloud_controller]}/apps", :authorization=>"#{token}"), :symbolize_keys=>true)
  tree = ""
  apps.each do |app|
    body = ""
    app.each do |k,v|
      body << "<li>#{k}: #{v}</li>"
    end
    tree << "<li>#{app[:name]}<ul>#{body}</ul></li>"
  end
  <<-HTML
<html>
<body>
<h1>Your Apps</h1>
	<ul>
		<li><a href="/">Home</a></li>
	</ul>
Your Apps:
    <ul id="tree" class="treeview">#{tree}</ul>
</body>
</html>
  HTML
end

get '/logout' do
  session.delete(:auth)
  <<-HTML
<html>
<body>
	<h1>Logged Out</h1>
	<ul>
		<li><a href="#{config[:auth_server_url]}/logout.do?redirect=#{url('logout')}">Logout</a> of Cloud Foundry</li>
		<li><a href="/">Home</a></li>
	</ul>
</body>
</html>
  HTML
end

get '/auth/cloudfoundry/callback' do
  auth = request.env['omniauth.auth']
  session[:auth] = auth
  token = auth[:credentials][:token]
  session[:user] = auth[:info]
  status, headers, body = call env.merge("PATH_INFO" => '/')
  [status, headers, body]
end
