# frozen_string_literal: true

# GitHub repository reference (original and forked)
class Project < ApplicationRecord
  has_many :project_impprovements, dependent: :nullify
end
