# frozen_string_literal: true

class RenameUrlToNameInProjects < ActiveRecord::Migration[6.0]
  def change
    change_table :projects do |t|
      t.rename :repository_url, :repository_name
      t.rename :internal_repository_url, :internal_repository_name
    end
  end
end
