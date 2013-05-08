require 'spec_helper'
require_relative '../lib/app'

describe 'Service Pinger App' do
  def app
    Sinatra::Application
  end

  let(:db_name) { "service_pinger_test" }
  let(:root_connection) { Sequel.connect "mysql2://root@localhost" }
  before(:each) do
    root_connection.run "CREATE DATABASE IF NOT EXISTS #{db_name}"
    root_connection.run "GRANT ALL ON *.* TO 'testuser'@'localhost'"
  end

  around(:each) do |example|
    original_env = ENV.to_hash
    example.run
    ENV.replace(original_env)
  end

  let(:response) do
    get '/metrics'
    last_response
  end

  let(:parsed_metrics) do
    JSON.parse(response.body)
  end

  before(:each) do
    ENV["VCAP_SERVICES"] =<<-JSON
{"_":[{"name":"_name","label":"rds_mysql-n/a","plan":"10mb","credentials":{"name":"#{db_name}","hostname":"localhost","host":"localhost","port":3306,"user":"testuser","username":"testuser","password":""}}]}
    JSON
  end

  describe 'GET', '/metrics' do
    context "when it cannot connect to the database" do
      before(:each) do
        ENV["VCAP_SERVICES"] =<<-JSON
{"_":[{"name":"_name","label":"rds_mysql-n/a","plan":"10mb","credentials":{"name":"#{db_name}","hostname":"localhost","host":"localhost","port":3305,"user":"testuser","username":"testuser","password":""}}]}
        JSON
      end

      it "reports connection error" do
        response.status.should == 200
      end
    end

    it 'connects to database, provides success/failure and connect latency ' do
      response.status.should == 200
      connect = parsed_metrics.fetch('connect')
      connect.fetch('error').should be_nil
      connect.fetch('latency').should > 0
    end

    it 'writes to the database, outputs success and write latency' do
      response.status.should == 200
      connect = parsed_metrics.fetch('write')
      connect.fetch('error').should be_nil
      connect.fetch('latency').should > 0
    end

    it 'reads from the database, outputs success and read latency' do
      response.status.should == 200
      connect = parsed_metrics.fetch('read')
      connect.fetch('error').should be_nil
      connect.fetch('latency').should > 0
    end
  end
end
