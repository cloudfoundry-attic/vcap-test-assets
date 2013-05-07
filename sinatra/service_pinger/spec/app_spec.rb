require 'spec_helper'
require_relative '../lib/app'

describe 'Service Pinger App' do
  def app
    Sinatra::Application
  end

  describe 'GET', '/env' do
    it "shows you the services env var" do
      get "/env"
      last_response.status.should eq 200
    end
  end
end
