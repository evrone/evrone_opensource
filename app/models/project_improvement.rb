# frozen_string_literal: true

# PRs (improvements) flow to the original project
class ProjectImprovement < ApplicationRecord
  belongs_to :project

  validates :internal_pull_request_url, uniqueness: true
  validates :external_pull_request_url, uniqueness: true, allow_nil: true
end
