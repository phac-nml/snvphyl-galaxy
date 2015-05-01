# SNVPhyl: Whole Genome SNV Phylogenomics Pipeline

The SNVPhyl (SNV PHYLogenomics) pipeline is a pipeline for identifying Single Nucleotide Variants (SNV) within a collection of microbial genomes and constructing a phylogenetic tree.  Input is provided in the form of a collection of whole genome sequence reads as well as an assembled reference genome.  The output for the pipeline consists of: (1) a maximum liklihood phylogenetic tree, (2) a core SNV distance matrix, and (3) a table of all variants identified in the collection.

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

# Input

```
input
├── fastq
│   ├── 2010EL-1749.fastq 
│   ├── 2010EL-1796.fastq 
│   ├── 2010EL-1798.fastq 
│   ├── 2011EL-2317.fastq 
│   ├── 2012V-1001.fastq 
│   ├── 3554-08.fastq 
│   ├── C6706.fastq 
│   ├── VC-10.fastq 
│   ├── VC-14.fastq 
│   ├── VC-15.fastq 
│   ├── VC-18.fastq 
│   ├── VC-19.fastq 
│   ├── VC-1.fastq 
│   ├── VC-25.fastq 
│   ├── VC-26.fastq 
│   └── VC-6.fastq 
└── reference
    └── 2010EL-1786.fasta
```

# Output

| 1. Phylogeny                   |
|:-------------------------------|
| ![snvphyl-out][]               |

| 2. SNV Matrix                  |
|:-------------------------------|
| ![snvphyl-screenshot-matrix][] |

| 3. Variant Table               |
|:-------------------------------|
| ![snvphyl-variant-table][]     |


[Galaxy]: http://galaxyproject.org/
[Installation]: install/manual.md
[Overview]: user-guide/index.md
[SMALT]: http://www.sanger.ac.uk/resources/software/smalt/
[FreeBayes]: https://github.com/ekg/freebayes
[SAMtools/BCFtools]: http://samtools.sourceforge.net/mpileup.shtml
[PhyML]: http://www.atgc-montpellier.fr/phyml/
[snvphyl-workflow]: workflows/SNVPhyl/0.1/snvphyl_workflow.png
[snvphyl-out]: images/snvphyl-out.png
[snvphyl-screenshot-matrix]: images/snvphyl-screenshot-matrix.png
[snvphyl-variant-table]: images/snvphyl-variant-table.png
