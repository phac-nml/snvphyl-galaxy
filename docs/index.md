# SNVPhyl: Whole Genome SNV Phylogenomics Pipeline

The SNVPhyl (Single Nucleotide Variant PHYLogenomics) pipeline is a pipeline for identifying Single Nucleotide Variants (SNV) within a collection of microbial genomes and constructing a phylogenetic tree.  [Input][] is provided in the form of a collection of whole genome sequence reads as well as an assembled reference genome.  The [output][] for the pipeline consists of a whole genome phylogenetic tree constructed from the detected SNVs, as well as a list of all detected SNVs and other information.  The pipeline is implemented using the [Galaxy][] bioinformatics analysis platform.

[![snv-tree][]][snv-tree]

# Quick Usage

To quickly get started with SNVPhyl, a [command-line interface][] is provided to interact with Galaxy.  This can be configured to deploy a [Docker][] image which includes all the SNVPhyl tools and an instance of Galaxy.

```bash
git clone -b master https://github.com/phac-nml/snvphyl-galaxy-cli.git
cd snvphyl-galaxy && pip install -r requirements.txt

python bin/snvphyl.py --deploy-docker --fastq-dir example-data/fastqs --reference-file example-data/reference.fasta --min-coverage 5 --output-dir output1
```

This assumes that both Python and [Docker][] are installed.  If Docker requires **sudo** to run, please append `--with-docker-sudo` to the above command.

Alternatively, the Docker instance can be launched directly with:

```bash
docker run -d -p 48888:80 phacnml/snvphyl-galaxy-1.0.1
```

Once running, SNVPhyl/Galaxy can be accessed from <http://localhost:48888> with username `admin@galaxy.org` and password `admin`.  Please see [Usage][] and [Installation][] for more details.

## Nextflow

A version of SNVPhyl developed for [Nextflow](https://www.nextflow.io/) by *Jill Hagey* is available at <https://github.com/DHQP/SNVPhyl_Nextflow>.

# Operation

SNVPhyl identifies variants and generates a phylogenetic tree by mapping the input sequence reads to a reference genome followed by filtering out any invalid variant calls.  The stages are as follows:

[![snvphyl-overview][]][snvphyl-overview]

1. Preparing input files including:
    1. A set of sequence reads (`fastq` format).
    2. A reference genome (`fasta` format).
    3. An optional file of regions to mask on the reference genome (a special [tsv formatted file][]).
2. Identification of repeat regions on the reference genome using [MUMMer][].
3. Reference mapping and variant calling to identify high-quality SNVs (hqSNVs) using [SMALT][], [FreeBayes][] and [SAMtools/BCFtools][].
4. Merging the identified hqSNVs to construct a multiple sequence alignment.
5. Building a maximum likelihood tree with [PhyML][] and generating other output files.

SNVPhyl is implemented as a [Galaxy][] workflow, with each of these stages implemented using a specific Galaxy tool.

[![snvphyl-overview-galaxy][]][snvphyl-overview-galaxy]

More information on the operation and installation of the pipeline can be found in the [Usage][] and [Installation][] sections.

Code is available on GitHub under the <https://github.com/phac-nml/snvphyl-galaxy>, <https://github.com/phac-nml/snvphyl-tools>, and <https://github.com/phac-nml/snvphyl-galaxy-cli> projects.

[Galaxy]: http://galaxyproject.org/
[Installation]: install/index.md
[command-line interface]: https://github.com/phac-nml/snvphyl-galaxy-cli
[Docker]: https://www.docker.com/
[tsv formatted file]: user/input/#invalid-positions-masking-file
[Overview]: user/index.md
[SMALT]: http://www.sanger.ac.uk/science/tools/smalt-0
[MUMMer]: http://mummer.sourceforge.net/
[FreeBayes]: https://github.com/ekg/freebayes
[SAMtools/BCFtools]: http://www.htslib.org/
[PhyML]: http://www.atgc-montpellier.fr/phyml/
[Usage]: user/usage.md
[snvphyl-overview]: images/snvphyl-overview.png
[snvphyl-overview-galaxy]: images/snvphyl-overview-galaxy.png
[snv-tree]: images/snvphyl-out.png
[output]: user/output.md
[Input]: user/input.md
[parameters]: user/parameters.md
