# frozen_string_literal: true

module Commands
  # accepts, prepares and executes place
  class Place
    class << self
      def accepts?(robot:, name:)
        name == 'PLACE'
      end

      def call(robot:, arg:)
        new(robot: robot, arg: arg).process
      end
    end

    def initialize(robot:, arg:, locationer: Robots::Location, orientationer: Robots::Orientation)
      @robot = robot
      @arg = arg

      @locationer = locationer
      @orientationer = orientationer
    end

    def process
      x, y, orientation_name = arg.split(',')

      robot.place(location: build_location(x.to_i, y.to_i), orientation: build_orientation(orientation_name))
    end

    private

    attr_reader :robot, :arg, :locationer, :orientationer

    def build_location(x, y)
      locationer.new(x: x, y: y)
    end

    def build_orientation(name)
      orientationer.build_from_name(name)
    end
  end
end
