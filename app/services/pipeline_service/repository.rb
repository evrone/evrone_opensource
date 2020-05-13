# frozen_string_literal: true

module PipelineService
  # Pipeline repository actions
  module Repository
    extend self

    # Check if repository files exist and clone if necessary
    def ensure_cloned(repository_url)
      repository_url && :not_implemented
    end

    # Clones repository to our organisation and creates a new PR with
    # proposed changes
    def publish_changes(directory)
      return unless anything_to_commit?(directory)

      directory && :not_implemented
    end

    # locates directory where repository should be cloned
    def directory(repository_url)
      repository_url && :not_implemented
    end

    # checks if we made local changes in your current branch
    def anything_to_commit?(directory)
      directory && false
    end
  end
end
