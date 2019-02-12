# frozen_string_literal: true

module Commands
  # accepts and executes rotate left
  class Left
    class << self
      def accepts?(robot:, name:)
        robot.placed? && name == 'LEFT'
      end

      def call(robot:, arg:)
        robot.left
      end
    end
  end
end
