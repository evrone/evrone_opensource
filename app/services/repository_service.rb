# frozen_string_literal: true

# Manage repositories
module RepositoryService
  extend self

  # Converts repository name to https url
  # @param name [String] repository name at github
  #
  # @example
  #   name_to_url('evrone/evrone_opensource')
  #   => "https://github.com/evrone/evrone_opensource.git"
  def name_to_url(name)
    "https://github.com/#{name}.git"
  end

  # Repository location relative to current project
  # @paams name [String] repository name at github
  def locate(name)
    "repositories/#{name}"
  end

  # Clones repository locally
  # @paams name [String] repository name at github
  def clone(name)
    path = locate(name)

    return true if Dir.exist?(path)

    Git.clone(name_to_url(name), path, depth: 1) && true
  end
end
