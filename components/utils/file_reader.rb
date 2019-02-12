# frozen_string_literal: true

module Utils
  # Reads a file and cleans up the lines
  class FileReader
    class << self
      attr_reader :filename

      def call(filename)
        return { error: filename_required_msg } unless filename

        @filename = filename
        file_exist? ? { commands: process_file } : { error: file_not_found_msg }
      end

      private

      def file_exist?
        File.file?(filename)
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

      def file_not_found_msg
        "Can't find File #{filename}."
      end

      def filename_required_msg
        'Please provide a valid file.'
      end
    end
  end
end
