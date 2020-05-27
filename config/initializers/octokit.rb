# frozen_string_literal: true

Octokit.configure do |c|
  c.access_token = ENV.fetch('GITHUB_ACCESS_TOKEN')
end

module Octokit
  class Client
    # Add attribute `current_organization` for Octokit::Client
    module CurrentOrganization
      attr_writer :current_organization

      def current_organization
        @current_organization ||= working_organization
      end

      private

      def working_organization
        client = Octokit::Client.new
        client.organization(ENV.fetch('GITHUB_ORGANIZATION_NAME'))
      end
    end
  end
end

Octokit::Client.include Octokit::Client::CurrentOrganization
