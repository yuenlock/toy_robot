# frozen_string_literal: true

require './components/robots/robot_game.rb'

RSpec.describe 'Play' do
  describe 'Single Player' do
    describe 'Multi PLACE' do
      let(:instructions) {
        [
          'ALICE: PLACE 0,0,NORTH',
          'ALICE: MOVE',            # 0,1,NORTH
          'ALICE: RIGHT',           # 0,1,EAST
          'ALICE: MOVE',            # 1,1,EAST
          'ALICE: PLACE 5,5,SOUTH', # 5,5,SOUTH
          'ALICE: LEFT',            # 5,5,EAST
          'ALICE: REPORT'
        ]
      }
      let(:result) { ['ALICE: 5,5,EAST'] }

      subject { Robots::RobotGame.call(instructions: instructions) }

      it { expect(subject).to eq result }
    end
  end

  describe 'Two Player movements' do
    describe 'PLACE without a position and clashing will not place' do
      let(:instructions) {
        [
          'ALICE: PLACE 0,0,NORTH',
          'ALICE: MOVE',            # 0,1,NORTH
          'BARRY: PLACE 0,1,EAST',  # fail quietly
          'BARRY: REPORT',          # nothing
          'ALICE: REPORT'
        ]
      }
      let(:result) { ['ALICE: 0,1,NORTH'] }

      subject { Robots::RobotGame.call(instructions: instructions) }

      it { expect(subject).to eq result }
    end

    describe 'PLACE again and clashing ignore the PLACE command' do
      let(:instructions) {
        [
          'ALICE: PLACE 0,0,NORTH',
          'ALICE: MOVE',            # 0,1,NORTH
          'BARRY: PLACE 4,4,EAST',  # 4,4,EAST
          'BARRY: REPORT',          # 4,4,EAST
          'BARRY: PLACE 0,1,EAST',  # fails, stays at 4,4,EAST
          'BARRY: MOVE',            # 5,4,EAST
          'BARRY: REPORT',          # 5,4,EAST
          'ALICE: REPORT',          # 0,1,NORTH
        ]
      }
      let(:result) { ['BARRY: 4,4,EAST', 'BARRY: 5,4,EAST', 'ALICE: 0,1,NORTH'] }

      subject { Robots::RobotGame.call(instructions: instructions) }

      it { expect(subject).to eq result }
    end
  end
end
