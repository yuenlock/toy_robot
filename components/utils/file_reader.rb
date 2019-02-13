# frozen_string_literal: true

module Utils
  # Reads a file and cleans up the lines
  class FileReader
    class << self
      attr_reader :filename

      def call(filename)
        @filename = filename

        [retrieve_commands, file_error]
      end

      private

      def retrieve_commands
        process_file unless file_error
      end

      def file_error
        filename_missing? || file_not_found?
      end

      def process_file
        remove_empty sanitise(raw_lines)
      end

      def remove_empty(lines)
        lines.select { |line| line.size.positive? }
      end

      def sanitise(lines)
        lines.map(&:chomp)
      end

      def raw_lines
        File.readlines(filename)
      end

      def filename_missing?
        filename_required_msg unless filename
      end

      def file_not_found?
        file_not_found_msg unless File.file?(filename)
      end

      def file_not_found_msg
        "Can't find File #{filename}."
      end

      def filename_required_msg
        'Please provide a valid file.'
      end
    end
  end
end
