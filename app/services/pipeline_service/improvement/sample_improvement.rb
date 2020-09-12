# frozen_string_literal: true

module PipelineService
  module Improvement
    # Sample improvement handler
    module SampleImprovement
      module_function

      def call(directory)
        File.open(directory + '/README.md', 'wb') do |file|
          file.write(Time.now)
        end
      end
    end
  end
end
