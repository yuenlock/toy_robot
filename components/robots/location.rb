# frozen_string_literal: true

module Robots
  # Stores 2-dimensional coordinates
  class Location
    attr_reader :x, :y

    def initialize(x:, y:)
      @x = x
      @y = y
    end

    def to_s
      "#{x},#{y}"
    end
  end
end
