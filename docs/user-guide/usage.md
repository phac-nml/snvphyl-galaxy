# Usage

SNVPhyl is implemented as a set of tools and a workflow within the [Galaxy][] platform.  SNVPhyl can be installed within an existing Galaxy infrastructure, or provided virtual machines and [Docker][] images can be downloaded with both Galaxy and SNVPhyl.  Please see the [Install][] guide  for more details.

## Install

The easiest way to get started is to use [Docker][].  Please [install docker][] and then run:

```
docker run -p 48888:80 apetkau/snvphyl-galaxy:0.2-beta-1
```

This will download and run a docker image with SNVPhyl and Galaxy.  Once running, you may log into the SNVPhyl Galaxy instance by going to <http://localhost:48888> on your machine.  This should present you with a screen like the following:

![snvphyl-galaxy-docker][]

Once Galaxy is started, please login (**User > Login**) with the credentials `admin@galaxy.org` and `admin`.

# Input Data

SNVPhyl takes as input a set of sequence reads, a reference genome, as well as an optional masking/invalid positions file to exclude particular regions on the reference genome.  A very basic dataset can be found at [test-data.tar.gz][].

The data must first be uploaded to the SNVPhyl Galaxy instance before it can be used.  This can be accomplished by navigating to **Get Data > Upload File** in your web browser.

![get-data-galaxy][]

This should bring up a window for uploading files to Galaxy.  Please select all the sequene reads under `reads/` and set the type to **fastqsanger** (not **fastq**).  This should look like the following.

![upload-sequence-reads][]

[Galaxy]: http://galaxyproject.org/
[Docker]: https://www.docker.com/
[install docker]: https://docs.docker.com/installation/
[Install]: install/
[snvphyl-galaxy-docker]: images/snvphyl-galaxy-docker.png
[test-data.tar.gz]: workflows/SNVPhyl/0.2/test-data.tar.gz
[get-data-galaxy]: images/get-data-galaxy.png
[upload-sequence-reads]: images/upload-sequence-reads.png
