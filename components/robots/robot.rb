# frozen_string_literal: true

require './components/robots/location'
require './components/robots/orientation'
require './components/robots/position'
require './components/robots/square_grid'

require 'forwardable'

module Robots
  class Robot
    extend Forwardable
    def_delegators :@world, :valid?

    def_delegators :@position, :report

    def self.call(instructions:)
      new(instructions: instructions).process
    end

    attr_reader :instructions, :position, :world
    def initialize(instructions:, world: SquareGrid.new)
      @instructions = instructions
      @world = world
    end

    def process
      instructions.map { |instruction| execute(instruction) }.compact
    end

    def execute(instruction)
      action, arg = instruction.split(' ')
      if position
        send(action.downcase) if %w[MOVE LEFT RIGHT REPORT].include? action
      elsif action == 'PLACE'
        send(action.downcase, arg)
      end
    end

    def place(arg)
      x, y, orientation_name = arg.split(',')
      location = Location.new(x: x.to_i, y: y.to_i)
      orientation = Orientation.new_from_name(orientation_name)
      update_position(location: location, orientation: orientation)
      nil
    end

    def move
      update_position(location: position.move)
    end

    def position_h
      position.to_h
    end

    def left
      update_position(orientation: position.left)
    end

    def right
      update_position(orientation: position.right)
    end

    def update_position(location: position.location, orientation: position.orientation)
      @position = Position.new(location: location, orientation: orientation) if valid?(location.to_h)
      nil
    end
  end
end
