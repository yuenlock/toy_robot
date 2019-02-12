# frozen_string_literal: true

require './components/robots/robot_game.rb'

RSpec.describe 'Play' do
  describe 'Single Player movements' do
    let(:instructions) {
      [
        'ALICE: PLACE 0,0,NORTH',
        'ALICE: MOVE',            # 0,1,NORTH
        'ALICE: RIGHT',           # 0,1,EAST
        'ALICE: MOVE',            # 1,1,EAST
        'ALICE: LEFT',            # 1,1,NORTH
        'ALICE: LEFT',            # 1,1,WEST
        'ALICE: REPORT'
      ]
    }
    let(:result) { ['ALICE: 1,1,WEST'] }

    subject { Robots::RobotGame.call(instructions: instructions) }

    it { expect(subject).to eq result }
  end

  describe 'Two Player movements' do
    let(:instructions) {
      [
        'ALICE: PLACE 0,0,NORTH',
        'ALICE: MOVE',            # 0,1,NORTH
        'BARRY: PLACE 1,1,EAST',
        'BARRY: MOVE',            # 2,1,EAST
        'ALICE: RIGHT',           # 0,1,EAST
        'ALICE: MOVE',            # 1,1,EAST
        'BARRY: RIGHT',           # 2,1,SOUTH
        'BARRY: MOVE',            # 2,0,SOUTH
        'BARRY: RIGHT',           # 2,0,WEST
        'ALICE: LEFT',            # 1,1,NORTH
        'ALICE: LEFT',            # 1,1,WEST
        'BARRY: MOVE',            # 1,0,WEST
        'ALICE: REPORT',          # 1,1,WEST
        'BARRY: MOVE',            # 0,0,WEST
        'BARRY: REPORT'           # 0,0,WEST
      ]
    }
    let(:result) { ['ALICE: 1,1,WEST', 'BARRY: 0,0,WEST'] }

    subject { Robots::RobotGame.call(instructions: instructions) }

    it { expect(subject).to eq result }
  end
end
