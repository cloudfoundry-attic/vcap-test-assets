require_relative 'spec_helper'

describe MemoryKudzu do
  let(:kudzu) { described_class }

  it 'returns the current size' do
    kudzu.stub(:system_ps_call).and_return("95289  10664\n")
    kudzu.memory_size.should == 10.4140625
  end

  it 'grows until it hits the desire size' do
    kudzu.should_receive(:memory_size).exactly(3).times.and_return(100, 200, 300)
    kudzu.grow_until(300)
  end
end
