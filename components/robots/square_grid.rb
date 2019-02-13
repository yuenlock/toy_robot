# frozen_string_literal: true

module Robots
  # robot's world
  class SquareGrid
    def initialize(max_x: MAX_Y, max_y: MAX_X)
      @boundaries = { x: max_x - 1, y: max_y - 1 }
      @occupied_cells = []
    end

    def valid?(location)
      coordinates_valid?(location) && cell_vacant?(location)
    end

    def occupy(location)
      @occupied_cells << location
    end

    def relocate(old_location, new_location)
      occupy(new_location)
      vacate(old_location)
    end

    def vacate(location)
      @occupied_cells.delete(location)
    end

    private

    MAX_X = 6
    MAX_Y = 6

    attr_reader :boundaries, :occupied_cells

    def cell_vacant?(location)
      !occupied_cells.find { |cell| cell.x == location.x && cell.y == location.y }
    end

    def coordinates_valid?(location)
      (0..boundaries[:x]).cover?(location.x) && (0..boundaries[:y]).cover?(location.y)
    end
  end
end
