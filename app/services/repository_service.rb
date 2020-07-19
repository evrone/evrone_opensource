# frozen_string_literal: true

# Manage repositories
module RepositoryService
  GIT_AUTHOR = {
    name: 'Evrone Opensource',
    email: ENV.fetch('GIT_AUTHOR_EMAIL')
  }.freeze

  # internal repository's origin to push changes
  REMOTE = 'evrone-opensource'

  module_function

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
  # @param name [String] repository name at github
  def locate(name)
    "repositories/#{name}"
  end

  # Git repository object to interact with
  def git(name)
    path = locate(name)

    Git.open(path)
  end

  # Clones repository locally
  # @param name [String] repository name at github
  def clone(name)
    path = locate(name)

    return true if Dir.exist?(path)

    Git.clone(name_to_url(name), path, depth: 1) && path
  end

  # Creates a commit with all current uncommited changes
  # @param name [String] repository name at github
  # @param message [String] git commit message
  def commit(name, message)
    git = git(name)

    git.config('user.name', GIT_AUTHOR[:name])
    git.config('user.email', GIT_AUTHOR[:email])

    git.add(all: true)
    git.commit(message)
  end

  # Check for uncommited changes
  # @param name [String] repository name at github
  def anything_to_commit?(name)
    git(name).status.changed.present?
  end

  def change_branch(name, branch)
    git(name).checkout(branch)
  end

  # Pushes changes to the internal repository
  def push(name)
    git = git(name)
    branch = git.current_branch

    git.config \
      "remote.#{REMOTE}.push",
      "refs/heads/#{branch}:refs/heads/#{branch}"

    git.push(remote, branch)
  end
end
