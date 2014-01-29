require "spec_helper"
require "final_decider"

describe FinalDecider do
  subject(:decider) { described_class.new([]) }

  describe "#can_i_bump?" do

    context "when no deciders are present" do
      it "should return false when there are no deciders" do
        decider.can_i_bump?.should be false
      end
    end

    context "when we have deciders" do
      let(:pingdom) { Decider::Pingdom.new('app_key', 'username', 'password', 'hostname') }
      let(:jenkins) { Decider::Jenkins.new }
      let(:deciders) { [pingdom, jenkins] }
      let(:decider) { described_class.new deciders}

      context "when any of the concrete deciders return false" do
        before do
          pingdom.stub(:can_i_bump?).and_return(false)
          jenkins.stub(:can_i_bump?).and_return(true)
        end

        it "should return false" do
          decider.can_i_bump?.should be false
        end
      end

      context "when ALL of the concrete deciders return true" do
        before do
          pingdom.stub(:can_i_bump?).and_return(true)
          jenkins.stub(:can_i_bump?).and_return(true)
        end

        it "should return true only" do
          decider.can_i_bump?.should be true
        end
      end
    end
  end
end