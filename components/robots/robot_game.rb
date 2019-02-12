# frozen_string_literal: true

require './components/robots/square_grid'
require './components/robots/robot'

module Robots
  # Depency Injector
  class RobotGameInject
    class << self
      def world
        Robots::SquareGrid.new
      end

      def roboter
        Robots::Robot
      end
    end
  end

  class RobotGame
    def self.call(instructions:)
      new(instructions: instructions).process
    end

    attr_reader :instructions, :world, :robot_registry, :roboter
    def initialize(instructions:, world: nil, roboter: nil)
      @instructions = instructions
      @world    = world   || RobotGameInject.world
      @roboter  = roboter || RobotGameInject.roboter
      @robot_registry = []
    end

    def process
      instructions.map { |instruction| execute(instruction) }.flatten.compact
    end

    private

    def execute(instruction)
      player, action = instruction.split(': ')

      run_command(player, action) if action
    end

    def run_command(player, action)
      find_or_create_robot(player: player)&.execute(action)
    end

    def find_or_create_robot(player:)
      find_robot(player: player) || register_robot(player: player)
    end

    def find_robot(player:)
      robot_registry.find { |robot| robot.player == player }
    end

    def register_robot(player:)
      create_robot(player: player).tap { |robot| @robot_registry << robot }
    end

    def create_robot(player:)
      roboter.new(player: player, world: world)
    end
  end
end
