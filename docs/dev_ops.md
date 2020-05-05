# DevOps documentation

Production container is running inside single-node docker-swarm
cluster. All server configuration is provisioned by Ansible.

Ansible configuration stored in a separate repository.

## Deployment

Each 2 minutes cronjob task is looking for registry container
updates. If new image got published with tag `latest`, then service
update command is performed.

Cronjob
```sh
$ docker service update --image evrone/evrone_opensource:latest production_app
```
