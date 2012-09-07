class ServiceController < ApplicationController

  def hello
    render :text => 'hello from rails'
  end

  def env
    render :text => ENV['VCAP_SERVICES']
  end

  def service
    value = ''
    if params[:service] == 'redis'
      begin
        client = redis_service
        value = client[params[:key]]
      rescue Exception => e
        value = e.message.gsub(/\s+/, "")
      end
    end
    render :text => value
  end

  private
  def redis_service
    Redis.new({:host => '127.0.0.1', :port => 6379, :password => 'mypass'})
  end

end
