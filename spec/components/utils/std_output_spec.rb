# frozen_string_literal: true

require './components/utils/std_output'

RSpec.describe Utils::StdOutput do
  describe '.call' do
    let(:single_string) { 'aaa' }
    let(:string_array) { %w[aaa bbb ccc] }

    before do
      allow($stdout).to receive(:puts).with('')
    end

    context 'a string' do
      subject { described_class.call(single_string) }
      it 'gets printed' do
        expect($stdout).to receive(:puts).with(single_string)

        subject
      end
    end

    context 'a string' do
      subject { described_class.call(string_array) }

      it 'gets printed' do
        string_array.each do |str|
          expect($stdout).to receive(:puts).with(str)
        end

        subject
      end
    end
  end
end
