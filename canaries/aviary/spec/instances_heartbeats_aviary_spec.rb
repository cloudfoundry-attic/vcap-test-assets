require_relative 'spec_helper'

describe InstancesHeartbeatsAviary do
  subject(:aviary) { described_class.new('target', 'user', 'password', 'org', 'space', 'app-name')}

  let(:client) { double("cfoundry_client").as_null_object }

  let(:app_url) { "http://instances-canaries" }

  let(:app) do
    app = double('app')
    app.stub(url: app_url)
    app.stub(total_instances: 10)
    app
  end

  before do
    client.stub(app_by_name: app)
    CFoundry::Client.stub(get: client)
  end

  def forward_grace_period
    aviary
    Timecop.travel(Time.now + described_class::KEEP_ALIVE_TIME + 1)
  end

  before { forward_grace_period }

  describe "#ok?" do
    around { |example| Timecop.freeze(&example) }

    context "when not all instances have heartbeated" do
      context "when the start time grace period has not passed" do
        before { Timecop.travel(aviary.started) }

        it "should return true" do
          expect(aviary.ok?).to be_true
        end
      end

      context "when start time grace period has passed" do

        it "returns false" do
          expect(aviary.ok?).to be_false
          expect(aviary.error_message).to match(/10 instances haven't heartbeated/)
        end
      end
    end

    context "when the app is missing" do
      before { client.stub(app_by_name: nil) }

      it "returns false" do
        expect(aviary.ok?).to be_false
        expect(aviary.error_message).to match(/app 'app-name' does not exist/)
      end
    end

    context "when all heartbeats are within 30 seconds" do
      before do
        10.times { |i| aviary.process_heartbeat(i) }
      end

      it "returns true" do
        expect(aviary.ok?).to be_true
      end
    end

    context "when a few heartbeat came in too long ago" do
      before do
        10.times { |i| aviary.process_heartbeat(i) }

        Timecop.travel(Time.now + 2 * described_class::KEEP_ALIVE_TIME)

        8.times { |i| aviary.process_heartbeat(i) }
      end

      it "returns false" do
        expect(aviary.ok?).to be_false
        expect(aviary.error_message).to match(/indices 8, 9 haven't tweeted/)
      end
    end
  end
end
