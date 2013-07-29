require_relative 'spec_helper'

require_relative '../main'

describe 'The Aviary App' do
  def app
    Sinatra::Application
  end

  describe 'GET /instances_aviary' do
    context 'when canaries are ok' do
      before{ InstancesAviary.any_instance.stub(ok?: true) }

      it "sings" do
        get '/instances_aviary'
        last_response.should be_ok
        last_response.body.should == 'Sing'
      end
    end

    context 'when canaries are not ok' do
      before{ InstancesAviary.any_instance.stub(ok?: false, running_ratio: 0.1 ) }

      it "returns a 500" do
        get '/instances_aviary'
        last_response.status.should == 500
      end

      it 'raises with the correct message' do
        get '/instances_aviary'
        last_response.body.should match(/running ratio: 0.1/)
      end
    end
  end

  describe 'GET /zero_downtime_aviary' do
    context 'when canaries are ok' do
      before{ ZeroDowntimeAviary.any_instance.stub(ok?: true) }

      it "sings" do
        get '/zero_downtime_aviary'
        last_response.should be_ok
        last_response.body.should == 'Sing'
      end
    end

    context 'when canaries are not ok' do
      before{ ZeroDowntimeAviary.any_instance.stub(ok?: false, dead_canaries: ['2']) }

      it "returns a 500" do
        get '/zero_downtime_aviary'
        last_response.status.should == 500
      end

      it 'raises with the correct message' do
        get '/zero_downtime_aviary'
        last_response.body.should match(/dead canary on instance: 2/)
      end
    end
  end
end