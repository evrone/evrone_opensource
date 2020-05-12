# frozen_string_literal: true

# PRs (improvements) flow to the original project
# awaiting review -- if project corrected
#   reviewed -- after successful local review
#     published -- to the origin repository
#       merged -- by origin
#       rejected -- by origin
#       awaiting author response -- origin requested changes/response
class ProjectImprovement < ApplicationRecord
  STATUSES = %i[
    awaiting_review
    reviewed
    published
    merged
    rejected
    awaiting_author_response
  ].freeze

  belongs_to :project

  validates :internal_pull_request_url, uniqueness: true
  validates :external_pull_request_url, uniqueness: true, allow_nil: true
  validates :status, inclusion: { in: STATUSES }
end
