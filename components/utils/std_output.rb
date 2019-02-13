# frozen_string_literal: true

module Utils
  # output to console
  class StdOutput
    class << self
      attr_reader :io_handler
      def call(contents, io_handler: $stdout)
        @io_handler = io_handler

        print
        contents.empty? ? no_results : process(Array(contents))
        print
      end

      private

      def process(contents)
        contents.each { |line| print line }
      end

      def no_results
        print '     Nothing to do.'
      end

      def print(line = '')
        io_handler.puts line
      end
    end
  end
end
