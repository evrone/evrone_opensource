# frozen_string_literal: true

# Handle queued projects from pipeline
module PipelineService
  module_function

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

  # scan project for improvement opportunities, apply them, fork and
  # create a PR for local review
  def handle(repository_name)
    # persist the repository
    directory = Repository
                .ensure_cloned(repository_name)

    # improvements scan
    Improvement.call(directory)
    Repository.publish_changes(repository_name)
  end
end
