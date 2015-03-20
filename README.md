SNVPhyl Whole Genome Phylogenomics Pipeline
===========================================

This is the main repository for the **SNVPhyl** pipeline used for constructing whole genome phylogenies.  This pipeline is implemented as a [Galaxy][] workflow which may be installed in any Galaxy instance.  This pipeline takes as input a set of whole genome sequence reads and a reference genome.  The reads are mapped to the reference genome, variants are called, and an alignment of phylogenetically informative sites is created.  This alignment is used to construct a whole genome phylogeny as well as a pair-wise SNV distance matrix.

Usage
-----

### Input

The input for this pipeline consists of a set of paired-end sequence reads in **fastq** format as well as a reference genome in **fasta** format.  Some example data can be found in the [test/][] directory.  The paired-end sequence reads must be grouped together in Galaxy using a dataset collection.  This can be accomplished by clicking on the **Operations on multiple datasets** icon ![datasets-icon][], selecting all of the sequence read **.fastq** files, and selecting **For all selected... > Build List of dataset pairs**.  This should bring up a screen that looks like the following.

![dataset-pair-screen][]

This can be used to pair-up each of the **.fastq** files and construct a new entry in the Galaxy **History** for this list of paired-end files.  This **dataset_pair** history item, along with the reference file can be used as input to the pipeline.

### Output

The main output from this pipeline consists of the following files.

1. A phylogenetic tree constructed from the reference genome and all the sequence reads.  This tree is provided in [newick][] format and can be displayed in Galaxy's [Phyloviz][] software or external viewers such as [FigTree][].

    ![snphyl-out][]

2. A pairwise distance SNV matrix.  This shows the pairwise distance between each sample in SNVs that were kept by the pipeline.

    ```
    strain       2010EL-1749  C6706  2010EL-1786  2012V-1001 
    2010EL-1749  0            21     4            2         
    C6706        21           0      21           21        
    2010EL-1786  4            21     0            4         
    2012V-1001   2            21     4            0         
    VC-14        3            20     3            3    
    ```

3. A table of all variants found.

    ```
    #Chromosome   Position  Status             Reference  2010EL-1749  2010EL-1796  
    2010EL-1786   13149     filtered-mpileup   A          N            A            
    2010EL-1786   17132     valid              A          A            A            
    2010EL-1786   17872     filtered-coverage  T          T            T            
    ```

### Stages

The stages this pipeline goes through are, briefly:

1. Identification of repeat regions on reference genome.
2. Reference mapping and variant calling using [SMALT][], [FreeBayes][] and [SAMtools/BCFtools][].
3. Merging and filtering variant calls.
4. Aligning SNVs into an alignment SNP table.
5. Building a Maximum Likelihood tree with [PhyML][].

The Galaxy workflow implementing all of these stages looks as follows:

![snvphyl-workflow][]

Install
-------

Please refer to the [Install Guide][] for more information on how to install this workflow.

[Galaxy]: http://galaxyproject.org/
[Install Guide]: Install.md
[test/]: test/
[datasets-icon]: test/images/datasets-icon.jpg
[dataset-pair-screen]: test/images/dataset-pair-screen.jpg
[newick]: http://en.wikipedia.org/wiki/Newick_format
[FigTree]: http://tree.bio.ed.ac.uk/software/figtree/
[Phyloviz]: https://wiki.galaxyproject.org/Learn/Visualization/PhylogeneticTree
[SMALT]: http://www.sanger.ac.uk/resources/software/smalt/
[FreeBayes]: https://github.com/ekg/freebayes
[SAMtools/BCFtools]: http://samtools.sourceforge.net/mpileup.shtml
[PhyML]: http://www.atgc-montpellier.fr/phyml/
[snvphyl-workflow]: workflows/SNVPhyl/0.1/snvphyl_workflow.png
[snphyl-out]: images/snvphyl-out.jpg
