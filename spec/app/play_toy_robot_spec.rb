# frozen_string_literal: true

require './app/play_toy_robot'

RSpec.describe PlayToyRobot do
  let(:filename) { 'some/file' }
  let(:game) { class_double('Robots::RobotGame') }
  let(:input_handler) { class_double 'Utils::FileReader' }
  let(:output_handler) { class_double 'Utils::ConsoleOutput' }
  let(:call_params) { [filename, { game: game, input_handler: input_handler, output_handler: output_handler }] }
  let(:new_params) { { filename: filename, game: game, input_handler: input_handler, output_handler: output_handler } }

  let(:instance) { instance_double described_class }
  let(:results) { ['ALICE: 1,2,EAST'] }

  describe '.call' do
    subject { described_class.call(*call_params) }

    it 'calls and processes' do
      expect(described_class).to receive(:new).with(new_params).and_return instance
      expect(instance).to receive(:process).and_return results
      expect(subject).to eq results
    end
  end

  describe '#process' do
    let(:instructions) { ['ALICE: PLACE 1,2,3', 'BARRY: MOVE'] }
    let(:input_handler_result) { [instructions, nil] }

    subject { described_class.new(new_params) }

    it 'calls the proper components' do
      expect(input_handler).to receive(:call).with(filename).and_return input_handler_result

      expect(game).to receive(:call).with(instructions: instructions).and_return results

      expect(output_handler).to receive(:call).with(results)

      subject.process
    end
  end
end
