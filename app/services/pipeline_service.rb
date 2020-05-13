# frozen_string_literal: true

# Handle queued projects from pipeline
module PipelineService
  extend self

  # process the queue
  def run
    loop do
      project = ProjectContext.next_unhandled_project

      unless project
        sleep(10)
        next
      end

      handle(project)
      ProjectContext.mark_handled!(project)
    end
  end

  def handle(project)
    # persist the repository
    directory = Repository
                .ensure_cloned(project.repository_url)

    # improvements scan
    Improvement.call(directory)

    # is anything to commit
    Repository.publish_changes(directory)
  end
end
