if ENV['VMC_SERVICES']
  services = JSON.parse(ENV['VMC_SERVICES'])
  if services
    redis_service = services.find {|service| service["vendor"].downcase == "redis"}
    if redis_service
      redis_service = redis_service["options"]
      $redis = Redis.new({:host => redis_service["hostname"], :port => redis_service["port"], :password => redis_service["password"]})
    end
  end
end