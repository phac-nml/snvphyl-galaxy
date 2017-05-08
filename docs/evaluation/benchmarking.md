# Benchmarking

A number of datasets have been used to benchmark the runtime of SNVPhyl across a range of scenarios. These are as follows.

## Manuscript datasets

The datasets from the [SNVPhyl manuscript][] were run on a single machine using the Docker version of the pipeline.  The following table presents the run times (to go from sequence reads to a phylogeny) and data sizes of each case.

| Case                    | Number of genomes | Total size of reads (GB) | Runtime (min) |
|:-----------------------:|:-----------------:|:------------------------:|:-------------:|
| Simulated data          | 4                 | 1.4                      | 16            |
| SNV density filtering   | 11                | 13                       | 63            |
| *Salmonella* Heidelberg | 59                | 40                       | 192           |

The **Simulated data** case was run using a set of simulated reads through SNVPhyl, based off of *E. coli* str. Sakai (NC_002695) and two plasmids (NC_002128 and NC_002127).  The other two cases were run with real-world data. The **SNV density filtering** case was run using a set of 11 *Streptococcus pneumoniae* genomes through SNVPhyl, in particular the runtime presented was recorded when no SNV density filtering was applied. The **_Salmonella_ Heidelberg** case was run using a set of 59 *Salmonella* Heidelberg genomes, and in particular the runtime presented corresponds to the case of using a minimum coverage threshold of 10X while keeping all other parameters at default values.

## 189 *Streptococcus pneumoniae* genomes

For this scenario, we ran 189 *Streptococcus pneumoniae* genomes, published in <http://www.ncbi.nlm.nih.gov/pubmed/24957517>, under a number of different parameter settings. We also provide a comparison of the SNVPhyl-produced phylogenetic tree with the tree available on [Microreact][] for this same dataset <https://microreact.org/project/N1TRn11L>.

| Case                           | SNVs used for phylogenetic tree | Runtime with docker (hours) | Runtime on cluster (hours) | Phylogenetic tree comparison |
|:------------------------------:|:-------------------------------:|:---------------------------:|:--------------------------:|:----------------------------:|
| SNVPhyl (2 SNVs in 500 bp)     | 800                             | 8.04                        | 2.33                       | <http://phylo.io/#2e656069ebe8e2ec69374ef75dde8cf7%23bac6e0fc58be1fea772e304682eb34f1> |
| SNVPhyl (no density filtering) | 20,185                          |                             | 5.09                       | <http://phylo.io/#56eb4dfaed14ca3d086b31c65365c52c%230ea3c6aba4c8d3151f3a8b7a47b163a5> |

We also extract out the SNVs identified by SNVPhyl from the `snvTable.tsv` file to an alignment with both polymorphic and monomorphic SNVs, which was then ran through Gubbins (with default parameters). We note that this gives phylogenetic trees most closely matching the tree available on Microreact.

| Case                             | Gubbins runtime (minutes) | Phylogenetic tree comparison |
|:--------------------------------:|:-------------------------:|:----------------------------:|
| SNVs without density filtering   |                           | <http://phylo.io/#e6ade76551bfb717c90f5b0e870478cd%23ff42dc3ffc873cd87684d9d44a5afabc> |


[docker version of SNVPhyl]: ../install/docker
[SNVPhyl manuscript]: http://biorxiv.org/content/early/2016/12/10/092940
[snvphyl-validations]: https://github.com/apetkau/snvphyl-validations
[Microreact]: https://microreact.org
