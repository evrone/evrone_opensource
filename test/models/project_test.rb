# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'has case insensitive urls' do
    Project.create!(repository_name: 'url', internal_repository_name: 'url')

    invalid = Project.new \
      repository_name: 'Url', internal_repository_name: 'Url'

    assert_not(invalid.valid?, 'Project is invalid')

    assert_equal(
      {
        repository_name: ['has already been taken'],
        internal_repository_name: ['has already been taken']
      },
      invalid.errors.messages
    )
  end

  test 'internal_repository_name can be nil' do
    assert \
      Project.create!(repository_name: 'url'),
      'created without internal_repository_name field'
  end
end
