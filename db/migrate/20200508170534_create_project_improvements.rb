# frozen_string_literal: true

class CreateProjectImprovements < ActiveRecord::Migration[6.0]
  def change
    create_table :project_improvements do |t|
      t.references :project, null: false, foreign_key: true, index: true

      t.string :internal_pull_request_url, comment: <<-COMMENT.squish
      References internal PR inside the forked project
      COMMENT

      t.string :external_pull_request_url, comment: <<-COMMENT.squish
      References PR to the original project
      COMMENT

      t.integer :github_author_id, comment: <<-COMMENT.squish
      Who done the review (and responsible to get PR merged
      to the original project)
      COMMENT

      t.string :status, comment: 'stage of the improvement till it get merged'

      t.timestamps
    end
  end
end
