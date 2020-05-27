# frozen_string_literal: true

# Queries for Project model
module ProjectContext
  extend self

  REPOS_PATH = 'tmp/repos'

  def next_unhandled_project
    Project.unhandled.first
  end

  def mark_handled!(project)
    project.update!(handled_at: Time.zone.now)
  end

  def clone_repo(repository_url)
    fork(repository_url)
    project = Project.find_by(repository_url: repository_url)
    work_dir = directory(project)
    return work_dir.to_s if work_dir.exist? && work_dir.directory? && !work_dir.empty?

    clone(project)
  end

  def clone(project)
    repository = Octokit::Repository.from_url(project.internal_repository_url)
    client = Octokit::Client.new
    repository = client.repository repository
    git = Git.clone(repository.ssh_url, repository.name, path: directory_for_clone)
    git.dir.to_s
  end

  def directory_for_clone
    client = Octokit::Client.new
    client.current_organization
    Rails.root.join(REPOS_PATH, client.current_organization.login)
  end

  def directory(project)
    repository = Octokit::Repository.from_url(project.internal_repository_url)
    directory_for_clone.join(repository.name)
  end

  def save_fork(repository_url, fork_repository_url)
    project = Project.find_by(repository_url: repository_url)
    project.internal_repository_url = fork_repository_url
    project.save
  end

  def fork(repository_url)
    repository = Octokit::Repository.from_url(repository_url)
    client = Octokit::Client.new
    forked_repository = client.fork(repository, organization: client.current_organization.login)
    save_fork(repository_url, forked_repository.html_url)
    forked_repository
  end
end
