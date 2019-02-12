# frozen_string_literal: true

require './components/commands/right'

RSpec.describe Commands::Right do
  let(:command_name) { 'RIGHT' }

  describe '.accepts?' do
    context 'placed robot' do
      let(:robot) { instance_double('Robots::Robot', placed?: true) }

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

  context 'not placed robot' do
    let(:robot) { instance_double('Robots::Robot', placed?: false) }

    context 'accepted command' do
      subject { described_class.accepts?(robot: robot, name: command_name) }

      it { expect(subject).to eq false }
    end
  end

  describe '.call' do
    let(:robot) { instance_double('Robots::Robot', placed?: true) }
    let(:changed_orientation) { instance_double('Robots::Orientation') }

    subject { described_class.call(robot: robot, arg: nil) }

    it 'handles the command' do
      expect(robot).to receive(:right).and_return changed_orientation
      expect(subject).to eq changed_orientation
    end
  end
end
