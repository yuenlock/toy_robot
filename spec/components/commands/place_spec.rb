# frozen_string_literal: true

require './components/commands/place'

RSpec.describe Commands::Place do
  let(:command_name) { 'PLACE' }

  describe '.accepts?' do
    context 'not placed robot' do
      let(:robot) { instance_double('Robots::Robot', placed?: false) }

      context 'accepted command' do
        subject { described_class.accepts?(robot: robot, name: command_name) }

        it { expect(subject).to eq true }
      end

      context 'unknown command' do
        subject { described_class.accepts?(robot: robot, name: 'BAD_COMMAND') }

        it { expect(subject).to eq false }
      end
    end
  end

  context 'placed robot' do
    let(:robot) { instance_double('Robots::Robot', placed?: true) }

    context 'accepted command' do
      subject { described_class.accepts?(robot: robot, name: command_name) }

      it { expect(subject).to eq true }
    end
  end

  describe '.call' do
    let(:robot) { instance_double('Robots::Robot', placed?: true) }
    let(:arg) { '1,2,EAST' }
    let(:instance) { instance_double described_class }

    subject { described_class.call(robot: robot, arg: arg) }

    it 'initializes and processes' do
      expect(described_class).to receive(:new).with(robot: robot, arg: arg).and_return instance
      expect(instance).to receive(:process).and_return nil
      expect(subject).to eq nil
    end
  end

  describe '#process' do
    let(:x_coord) { 1 }
    let(:y_coord) { 2 }
    let(:facing_name) { 'SOUTH' }
    let(:arg) { "#{x_coord},#{y_coord},#{facing_name}" }

    let(:robot) { instance_double('Robots::Robot', placed?: true) }
    let(:location) { instance_double('Robots::Location') }
    let(:orientation) { instance_double('Robots::Orientation') }

    let(:locationer) { class_double 'Robots::Location' }
    let(:orientationer) { class_double 'Robots::Orientation' }

    subject {
      described_class.new(robot: robot, arg: arg, locationer: locationer, orientationer: orientationer).process
    }

    it 'handles the command' do
      expect(locationer).to receive(:new).with(x: x_coord, y: y_coord).and_return location
      expect(orientationer).to receive(:build_from_name).with(facing_name).and_return orientation
      expect(robot).to receive(:place).with(location: location, orientation: orientation).and_return nil

      expect(subject).to eq nil
    end
  end
end
