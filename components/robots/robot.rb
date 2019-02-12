# frozen_string_literal: true

require './components/robots/location'
require './components/robots/orientation'
require './components/robots/position'
require './components/robots/square_grid'
require './components/command_handlers'

require 'forwardable'

module Robots
  # Dependency injector
  class RobotInject
    class << self
      def command_handlers
        [Commands::Move, Commands::Left, Commands::Right, Commands::Report, Commands::Place]
      end

      def world
        SquareGrid.new
      end

      def positioner
        Robots::Position
      end
    end
  end

  # robot class accepts and runs commands
  class Robot
    extend Forwardable
    def_delegators :@world, :valid?

    def_delegators :@position, :report

    def self.call(instructions:)
      new(instructions: instructions).process
    end

    def initialize(instructions:,
                   world:            RobotInject.world,
                   positioner:       RobotInject.positioner,
                   command_handlers: RobotInject.command_handlers,
                   initial_position: nil)

      @instructions     = instructions
      @world            = world
      @positioner       = positioner
      @command_handlers = command_handlers
      @position         = initial_position
    end

    def process
      instructions.map { |instruction| execute(instruction) }.flatten.compact
    end

    def execute(instruction)
      action, arg = instruction.split(' ')

      command_handlers.map { |handler| run_command(handler, action, arg) }
    end

    def place(location:, orientation:)
      update_position(location: location, orientation: orientation)
    end

    def move
      update_position(location: position.move)
    end

    def left
      update_position(orientation: position.left)
    end

    def right
      update_position(orientation: position.right)
    end

    def placed?
      position != nil
    end

    private

    attr_reader :instructions, :world, :positioner, :command_handlers
    attr_reader :position

    def run_command(handler, action, arg)
      handler.call(robot: self, arg: arg) if handler.accepts?(robot: self, name: action)
    end

    def update_position(location: position.location, orientation: position.orientation)
      @position = positioner.new(location: location, orientation: orientation) if valid?(location)
      nil
    end
  end
end
