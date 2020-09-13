# frozen_string_literal: true

require 'test_helper'

class ProjectImprovementContextTest < ActiveSupport::TestCase
  test 'cretae_project_improvement!' do
    project = projects(:without_internal_repository)

    improvement = ProjectImprovementContext.create_project_improvement! \
      project, 'internal name', 'pull request url'

    assert_equal(improvement.internal_pull_request_url, 'pull request url')
    assert_equal(project.reload.internal_repository_name, 'internal name')
  end
end
