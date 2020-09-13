# frozen_string_literal: true

module PipelineService
  # Pipeline repository actions
  module Repository
    module_function

    # Check if repository files exist and clone if necessary
    #
    # @param repository [String]: repository name at github
    #
    # @returns relative to project's root repository path
    def ensure_cloned(repository)
      RepositoryService.clone(repository)
    end

    # Clones repository to our organization and creates a new PR with
    # proposed changes
    #
    # @param directory [String]: path to the repository relative to project root
    # @param repository [String]: repository name at GitHub
    def publish_changes(repository)
      return unless RepositoryService.anything_to_commit?(repository)

      forked_repository_name =
        GithubAccountService.fork_to_account(repository)

      RepositoryService.change_branch(repository, 'changes')
      RepositoryService.commit(repository, 'improvements')
      RepositoryService.push(repository, forked_repository_name)

      # publish pull request to our repository
      GithubAccountService.create_pull_request \
        repository: forked_repository_name,
        target: 'master', from: 'changes',
        title: 'title', description: 'description'
    end
  end
end
