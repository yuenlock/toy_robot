# frozen_string_literal: true

module Robots
  # holds orientation
  class Orientation
    def self.build_from_name(name)
      new(ORIENTATION_NAMES.index(name))
    end

    attr_reader :facing
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

    def to_s
      ORIENTATION_NAMES[facing]
    end

    private

    ORIENTATION_NAMES = %w[NORTH EAST SOUTH WEST].freeze
    ORIENTATION_SIZE  = ORIENTATION_NAMES.size

    MODIFIER_STRUCT = Struct.new(:x, :y)
    MOVEMENT_MODIFIER = [MODIFIER_STRUCT.new(0, 1), MODIFIER_STRUCT.new(1, 0),
                         MODIFIER_STRUCT.new(0, -1), MODIFIER_STRUCT.new(-1, 0)].freeze

    LEFT = -1
    RIGHT = 1

    def rotate(turn)
      Orientation.new((facing + ORIENTATION_SIZE + turn) % ORIENTATION_SIZE)
    end
  end
end
