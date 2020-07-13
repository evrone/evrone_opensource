# frozen_string_literal: true

module PipelineService
  # Pipeline repository actions
  module Repository
    module_function

    # Check if repository files exist and clone if necessary
    #
    # @param repository [String]: repository name at github
    def ensure_cloned(repository)
      RepositoryService.clone(repository)
    end

    # Clones repository to our organisation and creates a new PR with
    # proposed changes
    #
    # @param directory [String]: path to the repository relative to project root
    # @param repository [String]: repository name at GitHub
    def publish_changes(directory, repository)
      return unless anything_to_commit?(directory)

      # commpit current changes
      RepositoryService.commit(repository, 'improvements')

      # publish pull reuest to our repo
      GithubAccountService.create_pull_request \
        repository: repository,
        target: 'master',
        from: 'master',
        title: 'title',
        description: 'description'
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
