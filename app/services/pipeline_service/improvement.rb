# frozen_string_literal: true

module PipelineService
  # Scan directory for improvement opportunities and capitalise on
  # them
  module Improvement
    extend self

    PROCESSORS = [
      SampleImprovement,
      CurrentTimeImprovement
    ].freeze

    def call(directory)
      PROCESSORS.each do |klass|
        klass.call(directory)
      end
    end
  end
end
