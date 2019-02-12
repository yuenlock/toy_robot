# frozen_string_literal: true

require './components/robots/robot'

RSpec.describe Robots::Robot do
  describe '.call' do
    let(:instructions) { ['PLACE 0,1,SOUTH', 'MOVE', 'REPORT', 'BAD', 'WRONG'] }
    let(:instance) { described_class.new(instructions: instructions) }
    let(:result) { ['0,0,SOUTH'] }

    subject { described_class.call(instructions: instructions) }

    it 'initializes and processes' do
      expect(described_class).to receive(:new).with(instructions: instructions).and_return instance
      expect(instance).to receive(:process).and_return result

      expect(subject).to eq result
    end
  end

  describe '#process' do
    let(:instructions) { ['PLACE 0,1,SOUTH', 'REPORT', 'LEFT', 'REPORT', 'MOVE', 'REPORT', 'RIGHT', 'REPORT', 'MOVE', 'REPORT'] }
    let(:instance) { described_class.new(instructions: instructions) }
    let(:result) { ['0,1,SOUTH', '0,1,EAST', '1,1,EAST', '1,1,SOUTH', '1,0,SOUTH'] }

    subject { described_class.new(instructions: instructions) }

    it 'initializes and processes' do
      expect(subject.process).to eq result
    end
  end
end
