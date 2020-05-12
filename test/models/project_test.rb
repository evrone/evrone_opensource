# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'has case insensitive urls' do
    Project.create!(repository_url: 'url', internal_repository_url: 'url')

    invalid = Project.new(repository_url: 'Url', internal_repository_url: 'Url')

    assert_not(invalid.valid?, 'Project is invalid')

    assert_equal(
      {
        repository_url: ['has already been taken'],
        internal_repository_url: ['has already been taken']
      },
      invalid.errors.messages
    )
  end

  test 'internal_repository_url can be nil' do
    assert(
      Project.create!(repository_url: 'url'),
      'created without internal_repository_url field'
    )
  end
end
