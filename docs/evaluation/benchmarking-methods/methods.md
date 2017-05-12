# Benchmarking Methods

The below describes the methods used to gather the information used for benchmarking SNVPhyl.  In all cases, SNVPhyl was run with version 1.0.1, and using default parameters (minimum coverage = 10, min mean mapping = 30, relative snv abundance = 0.75, SNV filtering = 2 SNVs in a 500 bp window).

## Docker only

The SNVPhyl Docker container was run using:

```
docker run -d -p 48888:80 phacnml/snvphyl-galaxy-1.0.1:1.0.1b
```

The following presentes how each field was obtained, mostly from the Docker [cgroups](https://docs.docker.com/engine/admin/runmetrics/).

1. Max RSS

    Record `total_rss` from the following file.

    ```
    cat /sys/fs/cgroup/memory/docker/[docker id]/memory.stat
    ```

2. Max Mem.

    ```
    cat /sys/fs/cgroup/memory/docker/[docker id]/memory.max_usage_in_bytes
    ```

3. Disk Space

    This was obtained by using `du -sh /var/lib/docker/` before and after running the container and recording the difference.

## Other cases

For the other cases, the script [snvphyl-stats.sh](snvphyl-stats.sh) was used to run SNVPhyl (via the [SNVPhyl CLI](https://github.com/phac-nml/snvphyl-galaxy-cli)) and record information. The following describes how each field was obtained.

1. Runtime

    The value is the one recorded in `total_seconds` from the file `runSettings.txt.

2. Max RSS

    The value is sampled in `snvphyl-stats.sh` every 10 seconds from the file `cat /sys/fs/cgroup/memory/docker/[docker id]/memory.max_usage_in_bytes` for the time SNVPhyl runs. The maximum value (of `total_rss`) after SNVPhyl completes is recorded.

3. Max Memory

    The value from `cat /sys/fs/cgroup/memory/docker/[docker id]/memory.max_usage_in_bytes`.

4. Disk Space

    The command `du -sh /var/lib/docker/` was run before the SNVPhyl docker container was launched and after SNVPhyl completes and the difference was taken.

For the **Simulated data**, **Density filter**, and **_S._ Heidelberg** the data was taken from the [SNVPhyl Manuscript](http://biorxiv.org/content/early/2016/12/10/092940) (with **_S._ Heidelberg** being run using the downsampled dataset so the minimum genome has a mean coverage of 30X).

For the **189 _S. pneumoniae_** genomes, the genomes were obtained from <http://www.ncbi.nlm.nih.gov/pubmed/24957517> (a table of the genomes can be found at [1-pneumo.tsv](1-pneumo.tsv)).  The reference genome `CP002176` (670-6B) was used.

## Gubbins analysis

To construct a fasta alignment of polymorphic and monomorphic sites, the `snvTable.tsv` and reference genome `CP002176` were run through the Galaxy tool **Positions to SNV invariant alignment** (provided with SNVPhyl), setting **Keep all positions** to **Yes**.

The following commands were run on the alignment to replace ambiguous bases `R` and  `K` with `N`.

```
sed -i -e 's/TK/TN/' alignment-all-positions.fasta
sed -i -e 's/TR/TN/' alignment-all-positions.fasta
```
The modified alignment was run through Gubbins with `run_gubbins.py alignment.fasta`. The `Reference` label in the produced phylogenetic tree was renamed to `670-6B ` to be consistent with Microreact.
