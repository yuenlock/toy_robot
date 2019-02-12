# frozen_string_literal: true

module Commands
  # accepts and executes rotate right
  class Right
    class << self
      def accepts?(robot:, name:)
        robot.placed? && name == 'RIGHT'
      end

      def call(robot:, arg:)
        robot.right
      end
    end
  end
end
