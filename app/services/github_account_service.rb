# frozen_string_literal: true

# Manage `evrone_opensource` account actions
module GithubAccountService
  KIT = Octokit::Client.new
  FORK_ORGANIZATION = ENV.fetch('GITHUB_ORGANIZATION_NAME')

  module_function

  # Fork repository to internal organization
  # @param repository [String]: repository name at github
  #
  # @example
  #   fork_to_organization('evrone/evrone_opensource')
  #   => 'fork-town/evrone_opensource'
  def fork_to_organization(repository)
    KIT.fork(repository, organization: FORK_ORGANIZATION)[:full_name]
  end

  # Create pull request from branch (inside organization)
  # @param [Hash] opts the options to create pull request
  # @option opts [String] :repository Repository name at github
  # @option opts [String] :target Target branch name
  # @option opts [String] :from From which branch create pull request
  # @option opts [String] :title Pull request title
  # @option opts [String] :description Pull request description (markdown)
  #
  # @example
  #   create_pull_request \
  #     repository: 'evrone/evrone_opensource',
  #     target: 'master',
  #     from: 'feature/readme-syntax-highlighting',
  #     title: 'Improves code highlighting in readme',
  #     description: 'Here is a description of pull request'
  def create_pull_request(repository:, target:, from:, title:, description:)
    KIT.create_pull_request(repository, target, from, title, description)
  end

  # Publish pull request to the original repository
  def propose_pull_request()

  end
end
