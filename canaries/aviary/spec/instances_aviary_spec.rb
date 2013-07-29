require_relative 'spec_helper'

describe InstancesAviary do
  let(:aviary){ described_class.new('target', 'user', 'password', 'org', 'space', 'app')}
  let(:client){ double( 'cfoundry_client').as_null_object }
  let(:app){ double('app') }


  before{ CFoundry::Client.stub(get: client ) }

  describe '.running_ratio' do
    it 'returns the correct ratio' do
      client.stub(app_by_name: app)
      app.stub(:total_instances).and_return(100)
      app.stub(:running_instances).and_return(80)
      aviary.running_ratio.should == 0.8
    end
  end

  describe '.client' do
    it 'creates the client only once' do
      CFoundry::Client.should_receive :get
      aviary.client
      CFoundry::Client.should_not_receive :get
      aviary.client
    end
  end

  describe '.ok?' do
    context 'running more than 80% of the instances' do
      before do
        aviary.stub(:running_ratio).and_return(0.80)
      end

      it 'should be true' do
        aviary.should be_ok
      end
    end

    context 'running less than 80% of the instances' do
      before do
        aviary.stub(:running_ratio).and_return(0.10)
      end
      it 'should be false' do
        aviary.should_not be_ok
      end
    end
  end
end



#get '/instance_canary'
#aviary = InstanceAviary.new(username, password, organization, space, app_name)

#raise "ratio: #{aviary.running_ratio}" unless aviary.ok?

#end

#get '/zero_downtime_canary'

