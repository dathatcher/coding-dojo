# Coding Dojo Jenkins

## Pre-installation before attending the dojo

The practice session of this dojo relies on docker to provide a local containerized environment.
We suggest that you pull the required docker images prior to attend to save some time during the session.

```bash
docker pull dockage/mailcatcher:0.8.2
docker pull alpine:3.18.0
docker pull scrasnups/jenkins-dojo-blueocean:v2
docker pull scrasnups/jenkins-dojo-ssh-agent:v2
docker pull docker:24-dind
docker pull registry:2.8.2
```

## Installation

Clone this project in wsl:
`git clone git@github.com:wiley/pl_coding_dojo_jenkins.git`

From this project directory, run the following command that will create necessary
ssh keys, for jenkins controller and agent being able to communicate.
`./setup.sh`

Setup the local containers with the following command:
`docker-compose up -d`

For information, the following services are created:

- jenkins: the jenkins server/controller itself including UI web server that will redirect
  directives to the agent
- jenkins-agent: the jenkins agent/node that will run the jenkinsfile directives
- docker: docker in docker container used to run [docker inside docker](https://hub.docker.com/_/docker)
  itself, this container will be used as a node by the jenkins controller
- docker-registry: a local docker registry that will be used in the Exercise 03
- mail-catcher: local smtp and mail web UI
- jenkins-data: service that actually acts as a volume (workaround used for docker in docker to
  work almost seamless)

The first time this command will be launched, the needed images will be downloaded and customized
jenkins server image will be built.

Once the services are up, browse to <http://localhost:8080>.

Afterwards, Jenkins UI will ask you for login(`admin`) and password(`admin`).

If you have ports conflicts, please update the `.env` file accordingly. But please mind to change the
urls provided in this coding dojo accordingly too.

Let's start by the [Exercise 1](/Exercise01.md). Happy coding dojo !

## Cleaning at the end of the Dojo

Please ensure that at least you stopped all the containers to avoid consuming resources for nothing

```bash
(cd react-dojo && docker-compose down --rmi all -v)
docker-compose down --rmi all -v
```
## Resources

[Jenkins Glossary](https://www.jenkins.io/doc/book/glossary/): explains the terms Agent,
Controller, Step, Stage, ...
