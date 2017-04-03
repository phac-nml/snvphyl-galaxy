# Benchmarking

A number of datasets have been used to benchmark the runtime of SNVPhyl across a range of scenarios. These are as follows.

## Manuscript datasets

The datasets from the [SNVPhyl manuscript][] were run on a single machine using the Docker version of the pipeline.  The following table presents the run times (to go from sequence reads to a phylogeny) and data sizes of each case.

| Case                    | Number of genomes | Total size of reads (GB) | Runtime (min) |
|:-----------------------:|:-----------------:|:------------------------:|:-------------:|
| Simulated data          | 4                 | 1.4                      | 16            |
| SNV density filtering   | 11                | 13                       | 21            |
| *Salmonella* Heidelberg | 59                | 40                       | 192           |

The **Simulated data** case was run using a set of simulated reads through SNVPhyl, based off of *E. coli* str. Sakai (NC_002695) and two plasmids (NC_002128 and NC_002127).  The other two cases were run with real-world data. The **SNV density filtering** case was run using a set of 11 *Streptococcus pneumoniae* genomes through SNVPhyl, in particular the runtime presented was recorded when no SNV density filtering was applied. The **_Salmonella_ Heidelberg** case was run using a set of 59 *Salmonella* Heidelberg genomes, and in particular the runtime presented corresponds to the case of using a minimum coverage threshold of 10X while keeping all other parameters at default values.

The machine used to run each of these cases was an Intel Xeon CPU @ 3.33 GHz, 16 cores, and 24 GB of memory. More details on the methods can be found in the [SNVPhyl manuscript][], or in [snvphyl-validations][] github project.

[docker version of SNVPhyl]: ../install/docker
[SNVPhyl manuscript]: http://biorxiv.org/content/early/2016/12/10/092940
[snvphyl-validations]: https://github.com/apetkau/snvphyl-validations
