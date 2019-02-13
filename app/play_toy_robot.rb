# frozen_string_literal: true

require './components/robots/robot'
require './components/robots/robot_game'
require './components/utils/file_reader'
require './components/utils/std_output'

class PlayToyRobot
  def self.call(filename, game:, input_handler: nil, output_handler: nil)
    new(
      filename: filename, game: game,
      input_handler: input_handler,
      output_handler: output_handler
    ).process
  end

  attr_reader :filename, :game, :input_handler, :output_handler, :file_commands

  def initialize(filename:, game:, input_handler:, output_handler:)
    @filename = filename
    @game     = game

    @input_handler  = input_handler  || Utils::FileReader
    @output_handler = output_handler || Utils::StdOutput
  end

  def process
    instructions, file_read_error = read_batch_input

    output(file_read_error || run_game(instructions))
  end

  def output(results)
    output_handler.call(results)
  end

  def read_batch_input
    input_handler.call(filename)
  end

  def run_game(instructions)
    game.call(instructions: instructions)
  end
end
