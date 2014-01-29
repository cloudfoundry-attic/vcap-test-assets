require "rest-client"

module Decider
  class Pingdom
    PINGDOM_API_ENDPOINT = "https://api.pingdom.com/api/2.0"
    UPDATE_INTERVAL = 30

    attr_reader :reason

    def initialize app_key, username, password, hostname
      @app_key = app_key
      @username = username
      @password = password
      @hostname = hostname
      @can_i_bump = false
      @reason = "No data yet"

      message = "Invalid argument, cannot be nil"
      [@app_key, @username, @password, @hostname].each {|param| raise ArgumentError, message if param.nil?}
    end

    def can_i_bump?
      verify_pingdom
      @can_i_bump
    end

    private

    def verify_pingdom
      checks = pingdom_checks
      return set_can_i_bump(false, "No data from pingdom") if checks.empty?
      failed_checks = checks.select { |c| c["status"] != "up" && c["status"] != "paused" }

      unless failed_checks.empty?
        return set_can_i_bump(
          false,
          "Pingdom failed to connect to #{failed_checks.map {|c| c["hostname"]}.join(", ")}")
      end

      return set_can_i_bump(true, nil)
    rescue => e
      return set_can_i_bump(false, "Can't connect to pingdom: #{e.message}")
    end

    def set_can_i_bump(value, reason)
      @can_i_bump = value
      @reason = reason
    end

    def pingdom_checks
      response = RestClient::Request.new(
        :method => :get,
        :url => "#{Pingdom::PINGDOM_API_ENDPOINT}/checks",
        :user => @username,
        :password => @password,
        :headers => {
          "App-Key" => @app_key
        }
      ).execute
      filter_checks(JSON.parse(response.body)["checks"])
    end

    def filter_checks(checks)
      checks.select { |c| c["hostname"] =~ /#{@hostname}/ }
    end
  end
end