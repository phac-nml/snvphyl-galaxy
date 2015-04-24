# SNVPhyl: Whole Genome SNV Phylogenomics Pipeline

The SNVPhyl (SNV PHYLogenomics) pipeline is a pipeline for identifying Single Nucleotide Variants (SNV) within a collection of microbial genomes and constructing a phylogenetic tree.  Detailed documentation can be found at http://snvphyl.readthedocs.org/.  This repository contains the customized [Galaxy][] tools for this pipeline as well as the source for the documentation.

## Documentation

Documentation is written using [Markdown][] and can be compiled using [mkdocs][].  To install [mkdocs][] please run:

```bash
pip install mkdocs
```

To quickly generate a site for the documentation please run:

```
mkdocs serve
```

This will build a site under http://localhost:8000.

## Tools

The tools for this pipeline are maintained in a Galaxy toolshed at http://irida.corefacility.ca/galaxy-shed.  To build these tools for export to a local Galaxy toolshed please run:

```
./scripts/build_for_toolshed.sh
```

This will generate **.tar.gz** files in the directory `build/` which can be uploaded to a toolshed.  More details of this process can be found in the [Install Tools in Local Toolshed][]

[Galaxy]: http://galaxyproject.org/
[Markdown]: http://daringfireball.net/projects/markdown/syntax
[mkdocs]: http://www.mkdocs.org
[Install Tools in Local Toolshed]: InstallLocalToolshed.md
