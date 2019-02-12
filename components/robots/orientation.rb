# frozen_string_literal: true

module Robots
  # holds orientation
  class Orientation
    def self.build_from_name(name)
      new(ORIENTATION_NAMES.index(name))
    end

    def initialize(facing)
      @facing = facing
    end

    # actions
    def left
      rotate(LEFT)
    end

    def right
      rotate(RIGHT)
    end

    def move_modifier
      MOVEMENT_MODIFIER[facing]
    end

    # conversions
    def to_h
      { orientation: facing }
    end

    def to_s
      ORIENTATION_NAMES[facing]
    end

    def to_i
      facing
    end

    private

    ORIENTATION_NAMES = %w[NORTH EAST SOUTH WEST].freeze
    ORIENTATION_SIZE  = ORIENTATION_NAMES.size
    MOVEMENT_MODIFIER = [{ x: 0, y: 1 }, { x: 1, y: 0 }, { x: 0, y: -1 }, { x: -1, y: 0 }].freeze

    LEFT = -1
    RIGHT = 1

    attr_reader :facing

    def rotate(turn)
      Orientation.new((facing + ORIENTATION_SIZE + turn) % ORIENTATION_SIZE)
    end
  end
end
