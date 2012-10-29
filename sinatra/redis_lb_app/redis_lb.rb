require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require 'redis'

$stdout.sync = true

def get_redis_client
  services = JSON.parse(ENV['VCAP_SERVICES'])

  redis_service = nil
  services.each do |k, v|
    v.each do |s|
      if k.split('-')[0].downcase == 'redis'
        redis_service = s["credentials"]
      end
    end
  end
  if redis_service
    Redis.new(:host => redis_service["hostname"], :port => redis_service["port"], :password => redis_service["password"])
  end
end

get '/' do
  if get_redis_client
    "OK"
  else
    "FAIL: #{ENV['VCAP_SERVICES']}"
  end
end

get '/healthcheck' do
  if get_redis_client
    "OK"
  else
    "FAIL: #{ENV['VCAP_SERVICES']}"
  end
end


get '/incr' do
  begin
    if redis = get_redis_client
      app_instance = JSON.parse(ENV['VCAP_APPLICATION'])
      instance_key = "redis_lb_#{app_instance["instance_index"]}"
      total_operations = redis.incr('redis_lb_total_operations')
      redis.hincrby('redis_lb_hash', instance_key, 1)
      "OK: total_operations = #{total_operations}, last_update from #{instance_key} set: #{redis.hgetall('redis_lb_hash').to_json}"
    else
      "FAIL: #{ENV['VCAP_SERVICES']}"
    end
  ensure
    redis.quit
  end
end

get '/reset' do
  if reset_stats
    "OK"
  else
    "FAIL: #{ENV['VCAP_SERVICES']}"
  end
end

get '/getstats' do
  if redis = get_redis_client
    redis.hgetall('redis_lb_hash').to_json
  else
    "FAIL: #{ENV['VCAP_SERVICES']}"
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
