require_relative 'spec_helper'

describe BabelGenerator do

  let(:babel) {described_class.new('dir')}

  describe '.cleanup' do
    it 'should do the correct system call' do
      babel.should_receive(:`).with('rm dir/SPACE*.txt')
      babel.cleanup
    end
  end

  describe '.populate_until' do
    it 'should keep calling generate_file until space_used reaches the desired space size' do
      babel.should_receive(:generate_file).exactly(3).times
      babel.should_receive(:space_used).exactly(4).times.and_return(0, 100, 200, 300)
      babel.populate_until(300)
    end
  end
end