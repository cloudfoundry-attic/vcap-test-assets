require "cfoundry"
require "net/http"

class InstancesHeartbeatsAviary
  attr_reader :instances
  attr_reader :error_message
  attr_reader :started

  KEEP_ALIVE_TIME = 15

  def initialize(target, user, password, org, space, app_name)
    @target, @user, @password, @org, @space, @app_name = target, user, password, org, space, app_name
    @instances = {}
    @started = Time.now
  end

  def ok?
    expired = []

    app = client.app_by_name(@app_name)
    unless app
      @error_message = "app '#{@app_name}' does not exist"
      return false
    end

    return true if (Time.now - @started) < KEEP_ALIVE_TIME

    if app.total_instances > instances.size
      @error_message = "#{app.total_instances - instances.size} instances haven't heartbeated"
      return false
    end

    instances.each do |index, last_heartbeat|
      if (Time.now - last_heartbeat) > KEEP_ALIVE_TIME
        expired << index
      end
    end

    unless expired.empty?
      @error_message = "indices #{expired.join(", ")} haven't tweeted within #{KEEP_ALIVE_TIME} seconds"
    end

    expired.empty?
  end

  def process_heartbeat(index)
    instances[index] = Time.now
  end

  private

  def client
    CFoundry::Client.get(@target).tap do |c|
      c.login(username: @user, password: @password)
      c.current_organization = c.organization_by_name(@org)
      c.current_space = c.space_by_name(@space)
    end
  end
end