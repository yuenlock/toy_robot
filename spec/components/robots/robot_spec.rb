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

  describe 'Actions' do
    let(:positioner) { class_double('Robots::Position') }
    let(:world) { instance_double('Robots::World') }

    let(:initial_location)    { instance_double('Robots::Location') }
    let(:changed_location)    { instance_double('Robots::Location') }
    let(:initial_orientation) { instance_double('Robots::Orientation') }
    let(:changed_orientation) { instance_double('Robots::Orientation') }

    let(:initial_position) {
      instance_double('Robots::Position', location: initial_location, orientation: initial_orientation)
    }
    let(:changed_position) { instance_double('Robots::Position') }

    subject {
      described_class.new(
        instructions: [],
        world: world,
        positioner: positioner,
        command_handlers: [],
        initial_position: initial_position
      )
    }

    describe '#place' do
      it 'places the robot' do
        expect(world).to receive(:valid?).with(initial_location).and_return true
        expect(positioner).to(
          receive(:new).with(location: initial_location, orientation: initial_orientation)
        ).and_return initial_position
        expect(subject.place(location: initial_location, orientation: initial_orientation)).to eq nil
      end
    end

    describe '#move' do
      it 'moves the robot' do
        expect(initial_position).to receive(:move).and_return changed_location
        expect(world).to receive(:valid?).with(changed_location).and_return true
        expect(positioner).to(
          receive(:new).with(location: changed_location, orientation: initial_orientation)
        ).and_return changed_position
        expect(subject.move).to eq nil
      end
    end

    describe '#report' do
      let(:report) { '3,4,NORTH' }
      it 'reports the position' do
        expect(initial_position).to receive(:report).and_return report

        expect(subject.report).to eq report
      end
    end

    describe 'rotate' do
      before do
        expect(world).to receive(:valid?).with(initial_location).and_return true
        expect(positioner).to(
          receive(:new).with(location: initial_location, orientation: changed_orientation)
        ).and_return changed_position
      end

      describe '#left' do
        it 'rotates the robot' do
          expect(initial_position).to receive(:left).and_return changed_orientation

          expect(subject.left).to eq nil
        end
      end

      describe '#right' do
        it 'rotates the robot' do
          expect(initial_position).to receive(:right).and_return changed_orientation

          expect(subject.right).to eq nil
        end
      end
    end
  end
end
