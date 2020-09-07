# frozen_string_literal: true

Octokit.configure do |c|
  c.access_token = ENV.fetch('GITHUB_ACCESS_TOKEN', nil)
end
