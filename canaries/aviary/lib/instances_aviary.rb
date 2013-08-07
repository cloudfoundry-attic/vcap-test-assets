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
    "Instances canary croaked (cfoundry running ratio: #{cfoundry_running_ratio}%, pinged running ratio: #{pinged_running_ratio}%)"
  end

  def app
    return @app if @app
    @app = client.app_by_name(@app_name)
  end

  def ok?
    cfoundry_running_ratio >= 0.8 && pinged_running_ratio >= 0.8
  end

  def cfoundry_running_ratio
    return app.running_instances.to_f  / app.total_instances
  end

  def pinged_running_ratio
    threads = []
    indexes = {}
    mutex = Mutex.new
    url = app.url
    num_instances = app.total_instances
    (num_instances * 4).times do
      threads << Thread.new(indexes) do |indexes|
        index = Net::HTTP.get(url, '/instance-index')
        mutex.synchronize { indexes[index] = true }
      end
    end

    threads.each(&:join)

    indexes.size.to_f / num_instances
  end
end