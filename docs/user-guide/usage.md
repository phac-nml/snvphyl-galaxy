# Usage

SNVPhyl is implemented as a set of tools and a workflow within the [Galaxy][] platform.  SNVPhyl can be installed within an existing Galaxy infrastructure, or provided virtual machines and [Docker][] images can be downloaded with both Galaxy and SNVPhyl.  Please see the [Install][] guide  for more details.

## Install

The easiest way to get started is to use [Docker][].  To both install Docker and get SNVPhyl, please run:

```bash
curl -sSL https://get.docker.com/ | sh # Installs Docker
sudo docker run -t -p 48888:80 apetkau/snvphyl-galaxy:0.2-beta-1 # Downloads and runs SNVPhyl and Galaxy 
```

This will install Docker, download the SNVPhyl Galaxy docker image, and run this image in a Docker container.  See the [Docker Install][] guide for more details.

Once running, you may log into the SNVPhyl Galaxy instance by going to <http://localhost:48888> on your machine.  This should present you with a screen like the following:

![snvphyl-galaxy-docker][]

Once Galaxy is started, please login (**User > Login**) with the credentials `admin@galaxy.org` and `admin`.

# Input Data

SNVPhyl takes as input a set of sequence reads, a reference genome, as well as an optional masking/invalid positions file to exclude particular regions on the reference genome.  A very basic dataset can be found at [test-data.tar.gz][].

The data must first be uploaded to the SNVPhyl Galaxy instance before it can be used.  This can be accomplished by navigating to **Get Data > Upload File** in your web browser.

![get-data-galaxy][]

This should bring up a window for uploading files to Galaxy.

## Reference Genome

The reference genome should be in **fasta** format.  Galaxy will auto-detected the correct file format on upload.  When the correct file is chosen, click **Start** to begin uploading.  This will schedule an upload task in Galaxy and place the reference file in your Galaxy **History**.

![upload-reference][]

## Invalid Positions Masking File

An optional input for SNVPhyl is a list of positions on the reference genome to exclude when constructing a phylogeny.  This can be useful for excluding problematic regions such as phage regions.  The list of regions should be defined in a tab-deliminated ([BED][]-like) file which looks as follows:

```
#Chromosome    Start    End
reference      1        10
```

For the provided dataset, this file is named `invalid-positions.bed`.  Select and upload this file similar to uploading the reference genome.  When complete, the file should show up in your Galaxy history.

![upload-invalid-positions][]

## Sequence Reads

Sequence reads should be uploaded to Galaxy in the **fastqsanger** format.  From the upload window, select the all the sequence reads under `reads/` and set the type to **fastqsanger** (Galaxy will not properly auto-detect sequence reads).  This should look like the following.

![upload-sequence-reads][]

When all the reads are uploaded, you should see the following in your Galaxy history.

![upload-sequence-reads-history][]

## Preparing Sequence Reads

SNVPhyl makes use of a data structure in Galaxy called [Dataset Collections][].  Dataset collections allow the combining of files into a single entry in Galaxy to execute in a workflow.  The SNVPhyl workflow assumes all sequence reads are combined in a paired-end dataset collection, which will properly associated each pair of sequence reads files.

To construct a paired dataset collection of reads in Galaxy, please do the following:


[Galaxy]: http://galaxyproject.org/
[Docker]: https://www.docker.com/
[Docker Install]: https://docs.docker.com/installation/
[Install]: install/
[snvphyl-galaxy-docker]: images/snvphyl-galaxy-docker.png
[test-data.tar.gz]: workflows/SNVPhyl/0.2/test-data.tar.gz
[get-data-galaxy]: images/get-data-galaxy.png
[upload-sequence-reads]: images/upload-sequence-reads.png
[upload-reference]: images/upload-reference.png
[upload-invalid-positions]: images/upload-invalid-positions.png
[upload-sequence-reads-history]: images/upload-sequence-reads-history.png
[BED]: http://genome.ucsc.edu/FAQ/FAQformat#format1
