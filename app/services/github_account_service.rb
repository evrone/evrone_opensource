# frozen_string_literal: true

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
  def fork_to_organisation(name)
    KIT.fork(name, organization: FORK_ORGANISATION)[:full_name]
  end
end
