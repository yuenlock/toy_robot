# frozen_string_literal: true

module Robots
  # holds the location and orientation
  class Position
    attr_reader :location, :orientation, :locationer
    def initialize(location:, orientation:, locationer: Robots::Location)
      @location    = location
      @orientation = orientation
      @locationer  = locationer
    end

    def report
      "#{location},#{orientation}"
    end

    def left
      orientation.left
    end

    def right
      orientation.right
    end

    def move
      change = orientation.move_modifier

      locationer.new(x: location.x + change[:x], y: location.y + change[:y])
    end
  end
end
