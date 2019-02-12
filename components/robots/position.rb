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

    def to_h
      location.to_h.merge(facing: orientation.to_i)
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
      location_h = location.to_h

      locationer.new(x: location_h[:x] + change[:x], y: location_h[:y] + change[:y])
    end
  end
end
