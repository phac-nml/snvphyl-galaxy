# Benchmarking

A number of datasets have been used to benchmark the runtime, memory, and disk usage of SNVPhyl across a range of scenarios using the Docker version of SNVPhyl on a 16-core machine. The results are presented in the table below.

| Case            | # Genomes | Read size <br/> (GB) | Runtime <br/> (hrs) | Max RSS <br/> (GB) | Max Mem. <br/> (GB) | Disk Space <br/> (GB) |
|:----------------|:---------:|:--------------------:|:-------------------:|:------------------:|:-------------------:|:---------------------:|
| Docker only     | -         | -                    | -                   | 0.662              | 1.15                | 2.4                   |
| Simulated data  | 4         | 1.4                  | 0.261               | 3.04               | 9.90                | 6.8                   |
| Density filter  | 11        | 13                   | 0.439               | 4.18               | 14.1                | 9.6                   |
| *S.* Heidelberg | 59        | 40                   | 3.04                | 4.07               | 21.4                | 66.6                  |
| *S. pneumoniae* | 189       | 169                  | 8.23                | 12.4               | 21.7                | 136                   |

The **Docker only** case represents the resource useage of the `snvphyl-galaxy` Docker image alone, without any data. The next three cases are data analyzed in the [SNVPhyl manuscript][].  The **Simulated data** case was run using a set of simulated reads through SNVPhyl, based off of *E. coli* str. Sakai (NC_002695) and two plasmids (NC_002128 and NC_002127).  The **SNV density filtering** case was run using a set of 11 *Streptococcus pneumoniae* genomes through SNVPhyl. The **_Salmonella_ Heidelberg** case was run using a set of 59 *Salmonella* Heidelberg genomes.  The final case was not analyzed in the SNVPhyl manuscript, but consists of a set of 189 *Streptococcus pneumoniae* genomes analyzed in <http://www.ncbi.nlm.nih.gov/pubmed/24957517>.  Additional details on this dataset are provided below.

All datasets were run using the default SNVPhyl parameters on a 16-core Intel Xeon CPU (W5590) @ 3.33 GHz with 24 GB of RAM.  Additional details on the methods used to run SNVPhyl for each case can be found [here][methods].

## 189 *Streptococcus pneumoniae* genomes: details

In addition to running the 189 *Streptococcus pneumoniae* genomes using Docker, we also ran the dataset on a 2000-core cluster for comparison of the runtimes. We also provide a comparison of the produced phylogenetic tree to the one available from [Microreact][] for this same dataset <https://microreact.org/project/N1TRn11L> (the SNVPhyl tree is tree 1 on the left, Microreact tree is tree 2 on the right).

| Case                             | SNVs used | % core | Docker runtime <br/> (hrs) | Cluster runtime <br/> (hrs) | Phylogenetic tree comparison |
|:--------------------------------:|:---------:|:------:|:--------------------------:|:---------------------------:|:----------------------------:|
| Default <br/> (2 SNVs in 500 bp) | 1111      | 36.81  | 8.23                       | 2.33\*                        | [Comparison][1-tree-2-500]   |

We note that this try is not highly resolved when compared to the tree available on Microreact.  We suspect this is due to the default filtering criteria (removal of SNVs in any region with at least 2 SNVs in a 500 bp window). For comparison, we extracted all SNVs from the `snvTable.tsv` file (including SNVs in regions with low coverage in one or more genomes, or in repetitive regions) to construct an alignment with both polymorphic and monomorphic SNVs. This alignment was then run through [Gubbins][] (with default parameters).  This produced the following [phylogenetic tree][1-tree-gubbins] (Gubbins tree is tree 1 on the left, Microreact tree is tree 2 on the right). We note that this gives a phylogenetic tree that is a bit more resolved and a closer match to the Microreact tree.

[docker version of SNVPhyl]: ../install/docker
[SNVPhyl manuscript]: http://biorxiv.org/content/early/2016/12/10/092940
[snvphyl-validations]: https://github.com/apetkau/snvphyl-validations
[Microreact]: https://microreact.org
[Gubbins]: https://sanger-pathogens.github.io/gubbins/
[methods]: benchmarking-methods/methods.md
[1-tree-2-500]: http://phylo.io/#db3f0e933657efbab5b732f19c3b3276%23e5f863ba72a3551780bdebc610e87dd1
[1-tree-gubbins]: http://phylo.io/#009e855b17db1ec897c19791c14f4ea6%235ca06bb267033a22112c202c82e981ff
