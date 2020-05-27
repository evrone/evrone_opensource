# frozen_string_literal: true

module PipelineService
  # Pipeline repository actions
  module Repository
    extend self

    # Check if repository files exist and clone if necessary
    def ensure_cloned(repository_url)
      ProjectContext.clone_repo(repository_url)
    end

    # Clones repository to our organisation and creates a new PR with
    # proposed changes
    def publish_changes(project)
      directory = ProjectContext.directory(project)
      return unless anything_to_commit?(directory)

      msg = 'Open src improvement'
      git = Git.open(directory)
      git.add(all: true)
      git.commit(msg)
      git.push
      create_pull_request(project, git.branch.to_s)
    end

    # locates directory where repository should be cloned
    def directory(repository_url)
      project = Project.find_by(repository_url: repository_url)
      ProjectContext.directory(project)
    end

    # checks if we made local changes in your current branch
    def anything_to_commit?(directory)
      git = Git.open(directory)
      git.status.changed.present?
    end

    def create_pull_request(project, current_branch)
      msg = 'Open src improvement'
      repository = Octokit::Repository.from_url(project.repository_url)
      client = Octokit::Client.new
      head = "#{client.current_organization.login}:#{current_branch}"
      client.create_pull_request(repository, current_branch, head, msg, msg)
    end
  end
end
