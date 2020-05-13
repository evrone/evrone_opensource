# frozen_string_literal: true

namespace :pipeline do
  desc 'Consume unhandled projects from the queue'
  task run: :environment do
    PipelineService.run
  end
end
