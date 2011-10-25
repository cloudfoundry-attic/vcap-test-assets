require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'redis'

$stdout.sync = true

def get_redis_client
  redis_host = ENV['VMC_REDIS']
  return unless redis_host
  services = JSON.parse(ENV['VMC_SERVICES'])

  redis_service = services.find {|service| service["vendor"].downcase == "redis"}
  if redis_service
    options = redis_service["options"]
    Redis.new(:host => options["hostname"], :port => options["port"], :password => options["password"])
  end
rescue
end

get '/' do
  if get_redis_client
    "OK"
  else
    "FAIL: #{ENV['VMC_SERVICES']}"
  end
end

get '/healthcheck' do
  if get_redis_client
    "OK"
  else
    "FAIL: #{ENV['VMC_SERVICES']}"
  end
end


get '/incr' do
  if redis = get_redis_client
    app_instance = JSON.parse(ENV['VMC_APP_INSTANCE'])
    instance_key = "redis_lb_#{app_instance["instance_index"]}"
    total_operations = redis.incr('redis_lb_total_operations')
    redis.hincrby('redis_lb_hash', instance_key, 1)
    "OK: total_operations = #{total_operations}, last_update from #{instance_key} set: #{redis.hgetall('redis_lb_hash').to_json}"
  else
    "FAIL: #{ENV['VMC_SERVICES']}"
  end
end

get '/reset' do
  if reset_stats
    "OK"
  else
    "FAIL: #{ENV['VMC_SERVICES']}"
  end
end

get '/getstats' do
  if redis = get_redis_client
    redis.hgetall('redis_lb_hash').to_json
  else
    "FAIL: #{ENV['VMC_SERVICES']}"
  end
end

get '/env' do
  res = ''
  ENV.each do |k, v|
    res << "#{k}: #{v}<br/>"
  end
  res
end

def compute_stats(redis, operations)
  if redis = get_redis_client
    stats = redis.hgetall('redis_lb_hash', 0, -1, :with_scores => true)
    stats.each do |stat|
      $stderr.puts stat
    end
  else
    raise "compute_stats: no redis"
  end
end

def reset_stats
  if redis = get_redis_client
    redis.del('redis_lb_total_operations')
    redis.del('redis_lb_hash')
    true
  end
end
