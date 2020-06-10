[![CircleCI](https://circleci.com/gh/evrone/evrone_opensource.svg?style=svg)](https://app.circleci.com/pipelines/github/evrone/evrone_opensource)
[![Maintainability](https://api.codeclimate.com/v1/badges/3c2ddedd6fa03ab8eea3/maintainability)](https://codeclimate.com/github/evrone/evrone_opensource/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/3c2ddedd6fa03ab8eea3/test_coverage)](https://codeclimate.com/github/evrone/evrone_opensource/test_coverage)


# Evrone Opensource

Improve READMEs of opensource projects.

This project scans GitHub and other sources for projects where
README.md file can be improved.

On the next step, we fork and improve the readme (add syntax highlighting,
fix formating and so on) in our forked repository.

Then we create a PR within cloned repository and after PR got approved
we propose changes to the original project.

Our goal is to make README of opensource projects as great as they can
be.

## Documentation

- [DevOps](docs/dev_ops.md)

## Resources

- [Production Docker Image](https://hub.docker.com/repository/docker/evrone/evrone_opensource)

## Setup

* `GITHUB_ACCESS_TOKEN` - token for access github api
* `GITHUB_ORGANIZATION_NAME` - fork target organization
* `GIT_AUTHOR_EMAIL` - email for creating commits

```
$ docker-compoer up
$ docker-compose exec app sh
$ rails s -b 0.0.0.0
$ rails test
$ rubocop
```
