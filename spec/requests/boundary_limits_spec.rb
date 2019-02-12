# frozen_string_literal: true

require './components/robots/robot'

RSpec.describe 'Play' do
  describe 'Basic movements' do
    context 'exceed North' do
      let(:instructions) { ['PLACE 0,4,NORTH', 'MOVE', 'MOVE', 'MOVE', 'MOVE', 'REPORT'] }

      subject { Robots::Robot.call(instructions: instructions) }

      it 'returns a report' do
        expect(subject).to eq ['0,5,NORTH']
      end
    end

    context 'exceed EAST' do
      let(:instructions) { ['PLACE 4,4,EAST', 'MOVE', 'MOVE', 'MOVE', 'MOVE', 'REPORT'] }

      subject { Robots::Robot.call(instructions: instructions) }

      it 'returns a report' do
        expect(subject).to eq ['5,4,EAST']
      end
    end

    context 'exceed South' do
      let(:instructions) { ['PLACE 0,1,SOUTH', 'MOVE', 'MOVE', 'MOVE', 'MOVE', 'REPORT'] }

      subject { Robots::Robot.call(instructions: instructions) }

      it 'returns a report' do
        expect(subject).to eq ['0,0,SOUTH']
      end
    end

    context 'exceed WEST' do
      let(:instructions) { ['PLACE 1,4,WEST', 'MOVE', 'MOVE', 'MOVE', 'MOVE', 'REPORT'] }

      subject { Robots::Robot.call(instructions: instructions) }

      it 'returns a report' do
        expect(subject).to eq ['0,4,WEST']
      end
    end
  end
end
