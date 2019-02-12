# frozen_string_literal: true

module Robots
  class Robot
    def self.call(instructions:)
      new(instructions: instructions).process
    end

    attr_reader :instructions, :position, :boundaries
    def initialize(instructions:)
      @instructions = instructions
      @boundaries = { x: 5, y: 5 }
    end

    def process
      instructions.map { |instruction| execute(instruction) }.compact
    end

    def execute(instruction)
      action, arg = instruction.split(' ')
      if position
        send(action.downcase) if %w[MOVE LEFT RIGHT REPORT].include? action
      elsif action == 'PLACE'
        send(action.downcase, arg)
      end
    end

    ORIENTATION_NAMES = %w[NORTH EAST SOUTH WEST].freeze
    ORIENTATION_SIZE = ORIENTATION_NAMES.size

    def place(arg)
      x, y, orientation_name = arg.split(',')
      update_position(x: x.to_i, y: y.to_i, orientation: ORIENTATION_NAMES.index(orientation_name))
      nil
    end

    MOVEMENT_MODIFIER = [{ x: 0, y: 1 }, { x: 1, y: 0 }, { x: 0, y: -1 }, { x: -1, y: 0 }].freeze
    def move
      change = MOVEMENT_MODIFIER[position[:orientation]]
      update_position(x: position[:x] + change[:x], y: position[:y] + change[:y])
    end

    TURN_LEFT  = -1
    TURN_RIGHT = 1
    def left
      rotate(TURN_LEFT)
    end

    def right
      rotate(TURN_RIGHT)
    end

    def rotate(change)
      new_orientation = (position[:orientation] + change + ORIENTATION_SIZE) % ORIENTATION_SIZE
      update_position(orientation: new_orientation)
    end

    def report
      position_to_s
    end

    def valid?(x:, y:)
      (0..boundaries[:x]).cover?(x) && (0..boundaries[:y]).cover?(y)
    end

    def update_position(x: position[:x], y: position[:y], orientation: position[:orientation])
      @position = { x: x, y: y, orientation: orientation } if valid?(x: x, y: y)
      nil
    end

    def position_to_s
      "#{position[:x]},#{position[:y]},#{ORIENTATION_NAMES[position[:orientation]].upcase}"
    end
  end
end
