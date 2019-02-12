# frozen_string_literal: true

require './components/robots/robot_game'

RSpec.describe Robots::RobotGame do
  describe '.call' do
    let(:instructions) { ['ALICE: PLACE 1,2,SOUTH', 'ALICE: MOVE', 'ALICE: LEFT', 'BAD', 'WRONG', 'ALICE: REPORT'] }
    let(:instance) { instance_double described_class }
    let(:result) { ['ALICE: 1,1,EAST', 'BOB: 2,2,WEST'] }

    subject { described_class.call(instructions: instructions) }

    it 'initializes and processes' do
      expect(described_class).to receive(:new).with(instructions: instructions).and_return instance
      expect(instance).to receive(:process).and_return result

      expect(subject).to eq result
    end
  end

  describe '#process' do
    describe 'Robot Registry' do
      let(:positioner) { class_double('Robots::Position') }
      let(:world) { instance_double('Robots::World') }

      let(:roboter) { class_double('Robots::Robot') }
      let(:robot_alice) { instance_double('Robots::Robot', player: 'ALICE') }
      let(:robot_barry) { instance_double('Robots::Robot', player: 'BARRY') }
      let(:robot_candy) { instance_double('Robots::Robot', player: 'CANDY') }

      subject { described_class.new(instructions: instructions, world: world, roboter: roboter) }

      describe 'Player and Robot' do
        let(:instructions) { ['ALICE: STAND HERE', 'BARRY: WALK THERE', 'CANDY: SIT', 'ALICE: WALK', 'ALICE: STAND'] }

        it 'each player has only one robot' do
          # not under test
          allow(robot_alice).to receive(:execute)
          allow(robot_barry).to receive(:execute)
          allow(robot_candy).to receive(:execute)

          expect(roboter).to receive(:new).with(player: 'ALICE', world: world).and_return robot_alice
          expect(roboter).to receive(:new).with(player: 'BARRY', world: world).and_return robot_barry
          expect(roboter).to receive(:new).with(player: 'CANDY', world: world).and_return robot_candy

          subject.process
        end
      end

      describe 'instructions' do
        context 'good instructions' do
          let(:instructions) { ['ALICE: STAND HERE', 'BARRY: WALK THERE', 'CANDY: SIT', 'ALICE: WALK'] }
          it 'are handed to robot of player' do
            expect(roboter).to receive(:new).with(player: 'ALICE', world: world).and_return robot_alice
            expect(roboter).to receive(:new).with(player: 'BARRY', world: world).and_return robot_barry
            expect(roboter).to receive(:new).with(player: 'CANDY', world: world).and_return robot_candy

            expect(robot_alice).to receive(:execute).with('STAND HERE')
            expect(robot_barry).to receive(:execute).with('WALK THERE')
            expect(robot_candy).to receive(:execute).with('SIT')
            expect(robot_alice).to receive(:execute).with('WALK')

            subject.process
          end
        end

        context 'bad instructions' do
          let(:instructions) { ['# ADJASD', '$10,000.00', '2134'] }

          it 'are not handed anywhere' do
            expect(roboter).not_to receive(:new)
            subject.process
          end
        end
      end
    end
  end
end
