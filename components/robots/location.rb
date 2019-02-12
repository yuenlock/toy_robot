# frozen_string_literal: true

module Robots
  # Stores 2-dimensional coordinates
  class Location
    def initialize(x:, y:)
      @x = x
      @y = y
    end

    def to_h
      { x: x, y: y }
    end

    def to_s
      "#{x},#{y}"
    end

    private

    attr_reader :x, :y
  end
end
