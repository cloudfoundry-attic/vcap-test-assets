require "spec_helper"
require "deciders/jenkins"

describe Decider::Jenkins do
  subject(:jenkins) { described_class.new }

  describe "#can_i_bump?" do
    subject { jenkins.can_i_bump? }

    context "when can i bump set to yes" do
      before do
        jenkins.set_can_i_bump("yes", "build is green")
      end

      it { should be_true }
    end

    context "when can i bump set to no" do
      before do
        jenkins.set_can_i_bump("no", "build is red")
      end

      it { should be_false }

      it "should have reason: build is red" do
        expect(jenkins.reason).to eq("build is red")
      end
    end
  end
end