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
docker run -d -p 8080:80 apetkau/snvphyl-test
```

This may take a while to download the docker images and start up Galaxy.  Once completed, you will be able to log into Galaxy by navigating to <http://localhost:8080>.  

[Docker]: https://www.docker.com/
[Docker installation]: https://docs.docker.com/installation/
