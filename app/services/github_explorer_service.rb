# frozen_string_literal: true

module GithubExlorerService
  KIT = Octokit::Client.new

  module_function

  # https://docs.github.com/en/rest/reference/search#search-repositories
  def search
    KIT.search_repositories('language:ruby', per_page: 100, sort: 'updated')
       .items
  end
end
