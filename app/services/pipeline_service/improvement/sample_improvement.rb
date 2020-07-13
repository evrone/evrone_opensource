# frozen_string_literal: true

module PipelineService
  module Improvement
    # Sample improvement handler
    module SampleImprovement
      module_function

      def call(directory)
        "processing #{directory}"
      end
    end
  end
end
