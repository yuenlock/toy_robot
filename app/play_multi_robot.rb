# frozen_string_literal: true

require './components/robots/robot_game'
require './components/utils/file_reader'

class PlayMultiRobot
  FILE_NOT_FOUND = 'Please provide a valid file.'

  def self.call(filename)
    return [FILE_NOT_FOUND] unless filename && File.file?(filename)

    new(filename: filename).process
  end

  attr_reader :filename
  def initialize(filename:)
    @filename = filename
  end

  def process
    return file_read_error if file_read_error

    Robots::RobotGame.call(instructions: file_commands)
  end

  def file_commands
    results_from_file[:commands]
  end

  def file_read_error
    results_from_file[:error]
  end

  def results_from_file
    @results_from_file ||= Utils::FileReader.call(filename)
  end
end
