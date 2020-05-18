# frozen_string_literal: true

# Queries for Project model
module ProjectContext
  extend self

  def next_unhandled_project
    Project.unhandled.first
  end

  def mark_handled!(project)
    project.update!(handled_at: Time.zone.now)
  end
end
