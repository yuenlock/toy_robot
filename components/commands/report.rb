# frozen_string_literal: true

module Commands
  # accepts and executes report
  class Report
    class << self
      def accepts?(robot:, name:)
        robot.placed? && name == 'REPORT'
      end

      def call(robot:, arg:)
        robot.report
      end
    end
  end
end
