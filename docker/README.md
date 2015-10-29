SNVPhyl Galaxy Docker
=====================

This is an extension of the [Galaxy Docker Image][] for running a Galaxy instance with the [SNVPhyl Pipeline](http://snvphyl.readthedocs.org) installed.

Usage
=====

Before running this image, please make sure [Docker][] is installed.  Once Docker is installed, please run:

```bash
docker run -d -p 48888:80 apetkau/snvphyl-galaxy
```

This will download an instance of the SNVPhyl Galaxy image from [Docker Hub](https://hub.docker.com/) and run this image.  Galaxy will be accessible on your local machine at http://localhost:48888.  This will take a while to load, especially if it is the first time running.

Note, at the end this will give you a long id for the running docker image that looks like `40ab8e4a4494bf47ba60c372ab31b5ef6281c8c22f076ae4877f6be3e9db1911`.  This can be used to interact with the running docker image.  For example to view the logs, please run:

```bash
docker logs -f 40ab8e4a4494bf47ba60c372ab31b5ef6281c8c22f076a
```

To stop the docker image, please run:

```bash
docker kill 40ab8e4a4494bf47ba60c372ab31b5ef6281c8c22f076a
```

To see other docker processes, please run:

```bash
docker ps
```

To build a new Docker container with SNVPhyl and Galaxy, please run:


```bash
docker build .
```

Please see the [Docker Galaxy][Galaxy Docker Image] and [Docker][] documentation for more information. 

[Galaxy Docker Image]: https://github.com/bgruening/docker-galaxy-stable/
[Docker]: https://www.docker.com/
[Docker Hub]: https://hub.docker.com/
