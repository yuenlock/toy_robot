# frozen_string_literal: true

require './components/robots/robot.rb'

RSpec.describe 'Play' do
  describe 'Basic movements' do
    let(:instructions) {
      [
        'PLACE 0,0,NORTH',
        'MOVE',            # 0,1,NORTH
        'RIGHT',           # 0,1,EAST
        'MOVE',            # 1,1,EAST
        'LEFT',            # 1,1,NORTH
        'LEFT',            # 1,1,WEST
        'REPORT'
      ]
    }
    subject { Robots::Robot.call(instructions: instructions) }

    it 'returns a report' do
      expect(subject).to eq ['1,1,WEST']
    end
  end
end
