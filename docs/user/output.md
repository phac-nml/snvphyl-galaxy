# Output

This describes the main output files of SNVPhyl.  This includes the phylogenetic tree, distance matrix, along with additional quality, filtering, and mapping information.

# Phylogeny

The file `phylogeneticTree.newick` is the maximum liklihood phylogeny generated from an alignment of SNVs extracted from the whole genomes of each input file in [Newick][] format.

![snv-tree][]

# SNV/SNP Table

The file `snpTable.tsv` represents a table of all detected variant sites.  The position of each site is given by a combination of **Chromsome** (contig/sequence name) and **Position** on the reference genome.  The **Status** column represents whether this position was kept for constructing a phylogeny/distance matrix, **valid**, or filtered out.  The posible status values are:

   * **filtered-invalid**: Represents a position that was removed due to either being present on a repeat region, or within a region passed in the `invalid_positions` file.
   * **filtered-coverage**: Represents a position where at least one genome did not meet the minimum coverage critera.  The value inserted in the table in this case is a `-`.
   * **filtered-mpileup**: Represents a position where there was a mismatch in variant calls between **FreeBayes** and **SAMtools/mpileup/BCFtools**.  This often occurs in positions which met the **min_coverage** criteria, but did not meet the other criteria for calling a variant with FreeBayes, such as the minimum alternative allele ratio, or mapping quality scores. The value inserted in the table in this case is an `N`.

![snv-table-galaxy][]

# Filter Stats

A summary of the number of SNVs filtered within in the SNV Table.

![filter-stats][]

# SNV/SNP Matrix

The file `snpMatrix.tsv` represents a pair-wise distance matrix of SNVs that passed all filtering criteria (had status **valid** in the `snpTable.txt`).

![snv-matrix-galaxy][]

# Core Positions Evaluated

The file `vcf2core.tsv` is a table of the evaluated core positions in each reference fasta sequence.

![core-positions-table][]

The columns are as follows:

   * **Reference**:  The reference fasta sequence name.  The value of **all** represents the sum of all sequences.
   * **total length**:   The total length of the fasta sequence.
   * **total invalid pos**:  The total number of invalid positions removed from analysis.
   * **total valid pos**:  The total number of valid positions to be evaluated.
   * **total core**:  The total number of positions within the core genome on this fasta sequence.  That is, the total positions with enough coverage to be evaluated.
   * **Percentage in core**:  The percent of core positions evaluated out of the valid positions.  That is `100*(total core)/(total valid pos)`.

# SNV/SNP Alignment

An alignment of SNVs used to generate the phylogenetic tree.

![snv-alignment][]

# Mapping Quality

The file `mappingQuality.txt` describes how well the given reads mapped to the reference genome.  This can help to evaluate if one genome has either too little data to be included in the analysis, or if the reference genome is very distantly related, or other potential issues.

![mapping-quality][]

The tool to generate this file takes two parameters, **min coverage** and **min percent covered** which represents the minimum percentage of the reference genome with reads over the minimum coverage mapped.  The output is a list of all input genomes which did not meet the critera as well as the percent of coverage over the reference genome.

[Newick]: https://en.wikipedia.org/wiki/Newick_format
[snv-tree]: images/snv-tree.png
[snv-matrix-galaxy]: images/snv-matrix-galaxy.png
[snv-table-galaxy]: images/snv-table-galaxy.png
[core-positions-table]: images/core-positions-table.png
[snv-alignment]: images/snv-alignment.png
[filter-stats]: images/filter-stats.png
[mapping-quality]: images/mapping-quality.png
