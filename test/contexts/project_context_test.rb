# frozen_string_literal: true

require 'test_helper'

class ProjectContextTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  test 'mark_handled!' do
    project = projects(:unhandled)

    ProjectContext.mark_handled!(project)

    assert_not_nil(project.reload.handled_at)
  end

  test 'next_unhandled_project' do
    next_unhandled_project =
      ProjectContext.next_unhandled_project

    assert_nil(next_unhandled_project.handled_at)
  end
end
