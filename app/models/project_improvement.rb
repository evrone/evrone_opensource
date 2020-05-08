# frozen_string_literal: true

# PRs (improvements) flow to the original project
class ProjectImprovement < ApplicationRecord
  belongs_to :project

  validates :repository_url, uniqueness: true
  validates :internal_repository_url, uniqueness: true
end
