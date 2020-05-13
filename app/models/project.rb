# frozen_string_literal: true

# GitHub repository reference (original and forked)
class Project < ApplicationRecord
  validates :repository_url, uniqueness: true
  validates :internal_repository_url, uniqueness: true, allow_nil: true

  has_many :project_impprovements, dependent: :nullify
end
