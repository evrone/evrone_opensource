# frozen_string_literal: true

# Queries for ProjectImprovement model
module ProjectImprovementContext
  module_function

  def create_project_improvement!(
    project, internal_repository_name, pull_request_url
  )
    # ensure internal name on first improvement
    project.internal_repository_name ||
      project.update!(internal_repository_name: internal_repository_name)

    ProjectImprovement.create! \
      project: project,
      internal_pull_request_url: pull_request_url
  end
end
