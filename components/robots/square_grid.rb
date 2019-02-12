# frozen_string_literal: true

module Robots
  # robot's world
  class SquareGrid
    def initialize(max_x: MAX_Y, max_y: MAX_X)
      @boundaries = { x: max_x - 1, y: max_y - 1 }
    end

    def valid?(position)
      coordinates_valid?(position.to_h)
    end

    private

    MAX_X = 6
    MAX_Y = 6

    attr_reader :boundaries

    def coordinates_valid?(coordinates)
      (0..boundaries[:x]).cover?(coordinates[:x]) && (0..boundaries[:y]).cover?(coordinates[:y])
    end
  end
end
