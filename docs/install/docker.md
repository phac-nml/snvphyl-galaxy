SNVPhyl Docker
==============

SNVPhyl and Galaxy can both be installed and run very quickly using the provided [Docker][] image.  Docker provides a method to package software along with all dependencies and run on any machine with Docker installed.  Please refer to the [Docker installation][] guide for more details, however, Docker can quickly be installed under Linux with:

```bash
curl -sSL https://get.docker.com/ | sh
```

Running SNVPhyl
===============

Once Docker is installed, the latest version of SNVPhyl can be downloaded and run with:

```bash
docker run -t -p 48888:80 apetkau/snvphyl-galaxy:0.2-beta-1
```

This will download and run a docker image with SNVPhyl and Galaxy.  Once running, you may log into the SNVPhyl Galaxy instance by going to <http://localhost:48888> on your machine.  This should present you with a screen like the following:

![snvphyl-galaxy-docker][]

Once Galaxy is started, please login (**User > Login**) with the credentials `admin@galaxy.org` and `admin`.  See the [User Guide][] for more details on using SNVPhyl.

Shutdown SNVPhyl
================

To shutdown the Docker container, first run:

```
docker ps
```

This will show a list of all running docker containers, similar to:

```
CONTAINER ID        IMAGE ...
0d56c773a972        apetkau/snvphyl-galaxy:0.2-beta-1 ...
```

This shows all running docker containers and a unique container id.  To shutdown the docker container, please use this container id and run the below command.  **Important: by default, no data is persisted in the SNVPhyl/Galaxy docker container between runs.  For persisting Galaxy data within this Docker container please refer to the [Galaxy Docker Usage][] documentation**.

```
docker kill 0d56c773a972
```

The SNVPhyl/Galaxy Docker image is based on the [Galaxy Docker][] image.  Please refer to the documentation for more information on using this Docker image.

[Docker]: https://www.docker.com/
[Docker installation]: https://docs.docker.com/installation/
[snvphyl-galaxy-docker]: images/snvphyl-galaxy-docker.png
[User Guide]: ../user/usage.md
[Galaxy Docker]: https://github.com/bgruening/docker-galaxy-stable
[Galaxy Docker Usage]: https://github.com/bgruening/docker-galaxy-stable#usage
