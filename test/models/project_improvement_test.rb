# frozen_string_literal: true

require 'test_helper'

class ProjectImprovementTest < ActiveSupport::TestCase
  test 'has case insensitive urls' do
    ProjectImprovement.create!(
      project: projects(:one),
      internal_pull_request_url: 'url',
      external_pull_request_url: 'url'
    )

    invalid = ProjectImprovement.new(
      project: projects(:one),
      internal_pull_request_url: 'Url',
      external_pull_request_url: 'Url'
    )

    assert_not(invalid.valid?, 'ProjectImprovement is invalid')

    assert_equal(
      {
        internal_pull_request_url: ['has already been taken'],
        external_pull_request_url: ['has already been taken']
      },
      invalid.errors.messages
    )
  end

  test 'external_pull_request_url can be nil' do
    assert(
      ProjectImprovement.create!(
        project: projects(:one),
        internal_pull_request_url: 'url'
      ),
      'created without external_pull_request_url field'
    )
  end
end
