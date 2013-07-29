

class ZeroDowntimeAviary
  def initialize(domain, app_name, number_of_canaries)
    @domain, @app_name, @number_of_canaries = domain, app_name, number_of_canaries
  end


  def ok?
    dead_canaries.empty?
  end

  def error_message
    "dead canary on instance: #{dead_canaries.first}"
  end

  def dead_canaries
    canaries_status.select{ |k,v| v.to_i != 200}.keys
  end

  private
  def canaries_status
    result = {}
    1.upto(@number_of_canaries.to_i).each do |n|
      result[n.to_s] = Net::HTTP.get_response(URI("http://#{@app_name}#{n}.#{@domain}")).code
    end
    result
  end

end