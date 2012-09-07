class ServiceController < ApplicationController

  def hello
    render :text => 'hello from rails'
  end

  def env
    render :text => ENV['VCAP_SERVICES']
  end

  def crash
    Process.kill("KILL", Process.pid)
  end

  def service
    value = ''
    if request.post?
      value = request.raw_post
      if params[:service] == 'redis'
        $redis[params[:key]] = value
      elsif params[:service] == 'postgresql'
        DataValue.new(:key => params[:key], :data_value => value).save
      elsif params[:service] == 'mysql'
        DataValue.new(:key => params[:key], :data_value => value).save
      elsif params[:service] == 'mongo'
        MongoDataValue.new(:key => params[:key], :data_value => value).save
      elsif params[:service] == 'rabbit'
        client = rabbit_service
        value = write_to_rabbit(params[:key], value, client)
      elsif params[:service] == 'rabbitmq'
        client = rabbit_service
        value = write_to_rabbit(params[:key], value, client)
      end
    else
      if params[:service] == 'redis'
        value = $redis[params[:key]]
      elsif params[:service] == 'postgresql'
        value = DataValue.where(:key => params[:key]).first.data_value
      elsif params[:service] == 'mysql'
        value = DataValue.where(:key => params[:key]).first.data_value
      elsif params[:service] == 'mongo'
        value = MongoDataValue.find_by_key(params[:key]).data_value
      elsif params[:service] == 'rabbit'
        client = rabbit_service
        value = read_from_rabbit params[:key], client
      elsif params[:service] == 'rabbitmq'
        client = rabbit_service
        value = read_from_rabbit params[:key], client
      end
    end
     render :text => value
  end

  private
  def write_to_rabbit(key, value, client)
    q = client.queue(key)
    q.publish(value)
  end

  def read_from_rabbit(key, client )
    q = client.queue(key)
    msg = q.pop(:ack => true)
    q.ack
    msg
  end

  def rabbit_service
    Carrot.new( :host => '127.0.0.1', :port => 5678, :user => 'testuser', :pass => 'testpass', :vhost => 'testvhost' )
  end
end
