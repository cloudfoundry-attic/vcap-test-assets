require "cfoundry"

class InstancesAviary
  def initialize(target, user, password, org, space, app_name)
    @target, @user, @password, @org, @space, @app_name = target, user, password, org, space, app_name
  end

  def client
    return @client if @client
    @client = CFoundry::Client.get(@target).tap do |c|
      c.login(username: @user, password: @password)
      c.current_organization = c.organization_by_name(@org)
      c.current_space = c.space_by_name(@space)
      c.current_space.summarize!
    end
  end

  def error_message
    "Instances canary croaked (running ratio: #{running_ratio}%)"
  end

  def app
    return @app if @app
    @app = client.app_by_name(@app_name)
  end

  def ok?
    running_ratio >= 0.8
  end

  def running_ratio
    return app.running_instances.to_f  / app.total_instances
  end

end