require_relative 'spec_helper'

describe ZeroDowntimeAviary do
  let(:number_of_canaries) { 2 }
  let(:aviary){ described_class.new('http://domain', 'appname', number_of_canaries)}

  describe 'ok?' do
    context 'when all canaries are responding' do

      before{ aviary.stub(dead_canaries: []) }

      it 'should return true' do
        aviary.should be_ok
      end
    end

    context 'when no canaries are responding' do
      before{ aviary.stub(dead_canaries: [ '1' ]) }

      it 'should return false' do
        aviary.should_not be_ok
      end
    end
  end

  describe '.dead_canaries' do

    it 'should get on each canary' do
      Net::HTTP.stub(get_response: double('response').as_null_object)
      Net::HTTP.should_receive(:get_response).exactly(number_of_canaries).times
      aviary.dead_canaries
    end

    describe 'when canaries are alive' do
      before { Net::HTTP.stub(get_response: double('response',code: 200)) }

      it 'returns a hash of status' do
        aviary.dead_canaries.should == []
      end
    end

    describe 'when canaries is dead' do
      before { Net::HTTP.stub(get_response: double('response',code: 404)) }

      it 'returns the dead nodes' do
        aviary.dead_canaries.should == ['1', '2']
      end
    end
  end
end