# frozen_string_literal: true

module PipelineService
  module Improvement
    # Sample improvement handler
    module SampleImprovement
      extend self

      def call(directory)
        "processing #{directory}"
      end
    end
  end
end
