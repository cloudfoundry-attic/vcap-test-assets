require "spec_helper"
require "deciders/pingdom"

describe Decider::Pingdom do
  describe "initialize" do
    context "invalid parameters" do

      it "any parameter is nil" do
        expect { Decider::Pingdom.new(nil, 'foo', 'bar', 'foo') }.to raise_error(ArgumentError)
        expect { Decider::Pingdom.new('foo', nil, 'bar', 'foo') }.to raise_error(ArgumentError)
        expect { Decider::Pingdom.new('foo', 'bar', nil, 'foo') }.to raise_error(ArgumentError)
        expect { Decider::Pingdom.new('foo', 'bar', 'baz', nil) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#can_i_bump?" do
    subject(:decider) { Decider::Pingdom.new('foobar', 'fake_user', 'fake_password', 'target_hostname') }

    context "when pingdom is unreachable" do
      before do
        stub_request(:get, "https://fake_user:fake_password@api.pingdom.com/api/2.0/checks").to_return(:status => 500)
      end

      it "says NO" do
        expect(decider.can_i_bump?).to be_false
        expect(decider.reason).to match /500 Internal Server Error/
      end
    end

    context "when pingdom does not return any checks" do
      before do
        stub_request(:get, "https://fake_user:fake_password@api.pingdom.com/api/2.0/checks").
          to_return(:body => JSON.dump({"checks" => []}))
      end

      it "says NO" do
        expect(decider.can_i_bump?).to be_false
        expect(decider.reason).to match /No data/
      end
    end

    context "when some matching checks are DOWN" do
      before do
        stub_request(:get, "https://fake_user:fake_password@api.pingdom.com/api/2.0/checks").
          to_return(:body => JSON.dump(
            {
              "checks" => [
                {"id" => 123, "status" => "down", "hostname" => "a.target_hostname"},
                {"id" => 456, "status" => "up", "hostname" => "b.target_hostname"},
                {"id" => 789, "status" => "down", "hostname" => "c.target_hostname"}
              ]
            }))
      end

      it "says NO" do
        expect(decider.can_i_bump?).to be_false
        expect(decider.reason).to match /Pingdom failed to connect to a.target_hostname, c.target_hostname/
      end
    end

    context "when all matching checks are UP" do
      before do
        stub_request(:get, "https://fake_user:fake_password@api.pingdom.com/api/2.0/checks").
          to_return(:body => JSON.dump(
          {
            "checks" => [
              {"id" => 123, "status" => "down", "hostname" => "a.bar"},
              {"id" => 456, "status" => "up", "hostname" => "b.target_hostname"}
            ]
          }))
      end

      it "ignores checks not matching the hostname" do
        expect(decider.can_i_bump?).to be_true
      end
    end
  end
end