require 'spec_helper'
require_relative '../lib/db_verifier'

describe DbVerifier do
  let(:db_name) { "service_pinger_test" }
  let(:root_connection) { Sequel.connect "mysql2://root@localhost" }
  before(:each) do
    root_connection.run "CREATE DATABASE IF NOT EXISTS #{db_name}"
    root_connection.run "GRANT ALL ON *.* TO 'testuser'@'localhost'"
  end

  describe "#db_connect_string" do
    it 'should find the first service' do
      ENV["VCAP_SERVICES"] =<<JSON
{"rds_mysql-n/a":[{"name":"rds_pinger","label":"rds_mysql-n/a","plan":"10mb","credentials":{"name":"dbname","hostname":"dbhost.rds.amazonaws.com","host":"dbhost.rds.amazonaws.com","port":3306,"user":"u","username":"u","password":"p"}}]}
JSON
      described_class.db_connect_string.should eq('mysql2://u:p@dbhost.rds.amazonaws.com:3306/dbname')
    end

    it 'should fail when there are no services' do
      ENV["VCAP_SERVICES"] = "{}"
      expect {
        described_class.db_connect_string
      }.to raise_error(DbVerifier::ExpectedOneDatabaseError)
    end
  end

  describe "#metrics" do
    shared_examples "closing database connections" do
      it "closes the database connection" do
        expect {
          described_class.new.metrics
        }.not_to change {
          Sequel::DATABASES.size
        }
      end
    end

    context "when the connect, read, and write all work" do
      before do
        ENV["VCAP_SERVICES"] =<<JSON
{"_":[{"name":"_name","label":"rds_mysql-n/a","plan":"10mb","credentials":{"name":"#{db_name}","hostname":"localhost","host":"localhost","port":3306,"user":"testuser","username":"testuser","password":""}}]}
JSON
      end

      it "returns metrics" do
        v = described_class.new
        results = v.metrics

        [:connect, :write, :read].each do |mname|
          result = results[mname]
          result.keys.should =~ [:latency, :error]
          result[:error].should be_nil
          result[:latency].should be_a Numeric
        end
      end
      include_examples "closing database connections"
    end

    context "when the database cannot be connected to" do
      before do
        ENV["VCAP_SERVICES"] = <<JSON
{"_":[{"name":"_name","label":"rds_mysql-n/a","plan":"10mb","credentials":{"name":"#{db_name}","hostname":"localhost","host":"localhost","port":33306,"user":"wrongroot","username":"wrongroot","password":"wrong"}}]}
JSON
      end

      it "returns connect failure info" do
        v = described_class.new
        v.metrics.keys.should =~ [:connect]
        result = v.metrics[:connect]
        result.keys.should =~ [:latency, :error]
        result[:latency].should == -1
        result[:error].should =~ /Access denied/
      end
      include_examples "closing database connections"
    end

    context "when the database cannot be written to" do
      before do
        root_connection.run "REVOKE INSERT ON *.* FROM 'testuser'@'localhost';"
      end

      it "returns write failure info" do
        ENV["VCAP_SERVICES"] =<<JSON
{"_":[{"name":"_name","label":"rds_mysql-n/a","plan":"10mb","credentials":{"name":"#{db_name}","hostname":"localhost","host":"localhost","port":3306,"user":"testuser","username":"testuser","password":""}}]}
JSON
        v = described_class.new
        v.metrics.keys.should =~ [:connect, :write]
        v.metrics[:connect][:error].should be_nil
        result = v.metrics[:write]
        result.keys.should =~ [:latency, :error]
        result[:latency].should == -1
        result[:error].should =~ /INSERT command denied to user/
      end
      include_examples "closing database connections"
    end

    context "when the database cannot be read" do
      before do
        root_connection.run "REVOKE SELECT ON *.* FROM 'testuser'@'localhost';"
      end

      it "returns read failure info" do
        ENV["VCAP_SERVICES"] =<<JSON
{"_":[{"name":"_name","label":"rds_mysql-n/a","plan":"10mb","credentials":{"name":"#{db_name}","hostname":"localhost","host":"localhost","port":3306,"user":"testuser","username":"testuser","password":""}}]}
JSON
        metrics = described_class.new.metrics
        metrics.keys.should =~ [:connect, :write, :read]
        metrics[:connect][:error].should be_nil
        result = metrics[:read]
        result.keys.should =~ [:latency, :error]
        result[:latency].should == -1
        result[:error].should =~ /SELECT command denied to user/
      end
      include_examples "closing database connections"
    end
  end
end
