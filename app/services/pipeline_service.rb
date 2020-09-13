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
    end
  end

  # scan project for improvement opportunities, apply them, fork and
  # create a PR for local review
  def handle(project)
    # persist the repository
    directory = Repository
                .ensure_cloned(project.repository_name)

    # improvements scan
    Improvement.call(directory)

    pull_request =
      Repository.publish_changes(project.repository_name)

    ProjectImprovementContext.create_project_improvement! \
      project, pull_request[:repo][:full_name], pull_request[:html_url]
  ensure
    ProjectContext.mark_handled!(project)
  end
end
