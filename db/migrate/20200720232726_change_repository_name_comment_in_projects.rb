# frozen_string_literal: true

class ChangeRepositoryNameCommentInProjects < ActiveRecord::Migration[6.0]
  def up
    change_table :projects, bulk: true do |t|
      t.change :repository_name, :citext,
               comment: 'Repository name at GitHub'
      t.change :internal_repository_name, :citext,
               comment: 'Forked repository name at GitHub'
    end
  end

  def down
    change_table :projects, bulk: true do |t|
      t.change :repository_name, :citext,
               comment: 'Original repository url'
      t.change :internal_repository_name, :citext,
               comment: 'Forked repository url'
    end
  end
end
