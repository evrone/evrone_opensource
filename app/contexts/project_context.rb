# frozen_string_literal: true

# Queries for Project model
module ProjectContext
  extend self

  REPOS_PATH = 'tmp/repos'
  CLONE_DEPTH = 3

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
    if work_dir.exist? && work_dir.directory? && !work_dir.empty?
      return work_dir.to_s
    end

    clone(project)
  end

  def clone(project)
    repo = Octokit::Repository.from_url(project.internal_repository_url)
    client = Octokit::Client.new
    repo = client.repository repo
    git = Git.clone(repo.ssh_url,
                    repo.name,
                    path: directory_for_clone,
                    depth: CLONE_DEPTH)
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
    repo = Octokit::Repository.from_url(repository_url)
    client = Octokit::Client.new
    org_name = client.current_organization.login
    forked_repository = client.fork(repo, organization: org_name)
    save_fork(repository_url, forked_repository.html_url)
    forked_repository
  end
end
