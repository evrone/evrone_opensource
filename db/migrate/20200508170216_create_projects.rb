# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :repository_url, comment: 'Original repository url'
      t.string :internal_repository_url, comment: 'Forked repository url'

      t.datetime :handled_at, comment: <<-COMMENT.squish
      When original repository was scaned for improvement opportunities
      COMMENT

      t.timestamps
    end

    add_index(:projects, :repository_url, unique: true)
    add_index(:projects, :internal_repository_url, unique: true)
    add_index(:projects, :handled_at, where: 'handled_at IS NULL')
  end
end
