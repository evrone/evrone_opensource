# frozen_string_literal: true

module PipelineService
  module Improvement
    # Sample improvement handler
    module CurrentTimeImprovement
      module_function

      def call(directory)
        readme_file(directory)
      end

      def readme_file(directory)
        dir = Pathname.new(directory)
        file_name = 'README.md'
        return unless dir.join(file_name).exist?

        File.open(dir.join(file_name), 'a') do |file|
          file.write current_time
        end
      end

      def current_time
        "[//]: # (#{Time.zone.now.to_s(:number)})"
      end
    end
  end
end
