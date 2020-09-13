# frozen_string_literal: true

# GitHub repository reference (original and forked)
class Project < ApplicationRecord
  validates :repository_name, uniqueness: true
  validates :internal_repository_name, uniqueness: true, allow_nil: true

  has_many :project_impprovements, dependent: :nullify

  scope :unhandled, -> { where(handled_at: nil) }
  scope :by_repository_name, ->(name) { where(repository_name: name) }
end
