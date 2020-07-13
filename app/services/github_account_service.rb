# frozen_string_literal: true

# Manage `evrone_opensource` account actions
module GithubAccountService
  extend self

  KIT = Octokit::Client.new
  FORK_ORGANISATION = 'fork-town'

  # Fork repository to internal organisation
  # @param repository_name [String] repository name at github
  #
  # @example
  #   fork_to_organisation('evrone/evrone_opensource')
  #   => 'fork-town/evrone_opensource'
  def fork_to_organisation(repository)
    KIT.fork(repository, organization: FORK_ORGANISATION)[:full_name]
  end

  # Create pull request from branch (inside organisation)
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
  end
end
