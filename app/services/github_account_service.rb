# frozen_string_literal: true

# Manage `evrone_opensource` account actions
module GithubAccountService
  KIT = Octokit::Client.new

  module_function

  # Fork repository to the GITHUB_ACCESS_TOKEN owner's accout
  #
  # (can't fork to organization because only individual accounts can
  # propose pull requests)
  #
  # @param repository [String]: repository name at github
  #
  # @example
  #   fork_to_account('evrone/evrone_opensource')
  #   => 'evrone-opensource/evrone_opensource'
  def fork_to_account(repository)
    KIT.fork(repository)[:full_name]
  end

  # Create pull request from branch (inside organization)
  #
  # @param [Hash] opts the options to create pull request
  # @option opts [String] :repository Target repository name at github
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

  # Propose pull request to upstream repository
  #
  # look `create_pull_request` for args
  #
  # @param github_account [String] Account nickname with forked upstream project
  #
  # :from argument should be a branch from the same named project as
  # :repository
  def propose_pull_request(github_account, params)
    params[:from] = "#{github_account}:#{params[:from]}"
    create_pull_request(params)
  end
end
