# frozen_string_literal: true

module Robots
  # robot's world
  class SquareGrid
    def initialize(max_x: MAX_Y, max_y: MAX_X)
      @boundaries = { x: max_x - 1, y: max_y - 1 }
      @occupied_cells = []
    end

    def valid?(location)
      location_h = location.to_h

      coordinates_valid?(location_h) && cell_vacant?(location_h)
    end

    def occupy(location)
      @occupied_cells << location.to_h
    end

    def relocate(old_location, new_location)
      occupy(new_location)
      vacate(old_location)
    end

    private

    MAX_X = 6
    MAX_Y = 6

    attr_reader :boundaries, :occupied_cells

    def cell_vacant?(location_h)
      !occupied_cells.find { |cell| cell == location_h }
    end

    def coordinates_valid?(coordinates)
      (0..boundaries[:x]).cover?(coordinates[:x]) && (0..boundaries[:y]).cover?(coordinates[:y])
    end

    def vacate(location)
      @occupied_cells.delete(location.to_h)
    end
  end
end
