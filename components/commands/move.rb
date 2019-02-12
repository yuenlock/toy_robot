# frozen_string_literal: true

module Commands
  # accepts and executes move forward
  class Move
    class << self
      def accepts?(robot:, name:)
        robot.placed? && name == 'MOVE'
      end

      def call(robot:, arg:)
        robot.move
      end
    end
  end
end
