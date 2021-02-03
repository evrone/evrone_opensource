# frozen_string_literal: true

module PipelineService
  # Scan directory for improvement opportunities and capitalise on
  # them
  module Improvement
    module_function

    PROCESSORS = [
      # SampleImprovement
      ReadmeGemImprovement1,
      ReadmeGemImprovement2
    ].freeze

    def call(directory)
      PROCESSORS.each do |klass|
        klass.call(directory)
      end
    end
  end
end
