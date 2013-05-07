require "json"
require 'sequel'

class DbVerifier
  class ExpectedOneDatabaseError < StandardError;
  end

  def self.db_connect_string
    json = JSON.parse(ENV["VCAP_SERVICES"])
    if json.values.length != 1
      raise ExpectedOneDatabaseError, "Expected to only have 1 service, but found #{json.values.length}"
    end

    first_type_of_service = json.values.first
    if first_type_of_service.length != 1
      raise ExpectedOneDatabaseError, "Expected to only have 1 service, but found #{first_type_of_service.length}"
    end

    first_service = first_type_of_service.first
    credentials = first_service["credentials"]
    "mysql2"+
      "://#{credentials.fetch("user")}"+
      ":#{credentials.fetch("password")}"+
      "@#{credentials.fetch("host")}"+
      ":#{credentials.fetch("port")}"+
      "/#{credentials.fetch("name")}"
  end

  def metrics
    rv = {}
    begin
      t1 = Time.now
      db = Sequel.connect(self.class.db_connect_string, :test => true)
      connect_latency = (Time.now - t1)
      rv[:connect] = {
        :latency => connect_latency,
        :error => nil,
      }
    rescue Sequel::Error => e
      return {:connect => {:latency => -1, :error => "#{e.class}: #{e.message}"}}
    end

    begin
      db.create_table?(:our_table) do
        String "value"
      end

      t2 = Time.now
      old_value = "PreviousValue#{rand}#{Time.now}"
      new_value = "AfterValue#{rand}#{Time.now}"
      db[:our_table].delete
      db[:our_table].insert(:value => old_value)
      db[:our_table].update(:value => new_value)
      write_latency = Time.now - t2
      rv[:write] = {
        :latency => write_latency,
        :error => nil,
      }
    rescue Sequel::Error => e
      return rv.merge(
        :write => {
          :error => "#{e.class}: #{e.message}",
          :latency => -1,
        }
      )
    end

    begin
      t3 = Time.now
      read_value = db[:our_table].first[:value]
      raise "" unless new_value == read_value
      read_latency = Time.now - t3

      return rv.merge(
        :read => {
          :error => nil,
          :latency => read_latency,
        }
      )
    rescue Sequel::Error => e
      return rv.merge(
        :read => {
          :error => "#{e.class}: #{e.message}",
          :latency => -1,
        }
      )
    end
  end
end
