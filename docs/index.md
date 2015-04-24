# SNVPhyl: Whole Genome SNV Phylogenomics Pipeline

The SNVPhyl (SNV PHYLogenomics) pipeline is a pipeline for identifying Single Nucleotide Variants (SNV) within a collection of microbial genomes and constructing a phylogenetic tree.  Input is provided in the form of a collection of whole genome sequence reads as well as an assembled reference genome.  The output for the pipeline consists of a core SNV distance matrix, a table of all variants identified in the collection, as well as a maximum liklihood phylogenetic tree.

# Overview

SNVPhyl identifies variants and generates a phylogenetic tree by mapping the input sequence reads to a reference genome followed by filtering out any invalid variant calls.  The stages are as follows:

1. Identification of repeat regions on reference genome.
2. Reference mapping and variant calling using [SMALT][], [FreeBayes][] and [SAMtools/BCFtools][].
3. Merging and filtering variant calls.
4. Aligning SNVs into an alignment SNV table.
5. Building a Maximum Likelihood tree with [PhyML][].

SNVPhyl is implemented as a [Galaxy][] workflow, with each of these stages implemented using a specific Galaxy tool.  The Galaxy workflow looks as follows.

![snvphyl-workflow][]

More information on the operation and installation of the pipeline can be found in the [Overview][] and [Installation][] sections.

[Galaxy]: http://galaxyproject.org/
[Installation]: install/index.md
[Overview]: overview/index.md
[SMALT]: http://www.sanger.ac.uk/resources/software/smalt/
[FreeBayes]: https://github.com/ekg/freebayes
[SAMtools/BCFtools]: http://samtools.sourceforge.net/mpileup.shtml
[PhyML]: http://www.atgc-montpellier.fr/phyml/
[snvphyl-workflow]: workflows/SNVPhyl/0.1/snvphyl_workflow.png
