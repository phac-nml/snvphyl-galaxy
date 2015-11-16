# SNVPhyl: Whole Genome SNV Phylogenomics Pipeline

The SNVPhyl (SNV PHYLogenomics) pipeline is a pipeline for identifying Single Nucleotide Variants (SNV) within a collection of microbial genomes and constructing a phylogenetic tree.  Detailed documentation can be found at http://snvphyl.readthedocs.org/.  This repository contains the customized [Galaxy][] tools for this pipeline as well as the source for the documentation.

## Documentation

Documentation is written using [Markdown][] and can be compiled using [mkdocs][].  To install [mkdocs][] please run:

```bash
pip install mkdocs
```

To quickly generate a site for the documentation please run:

```bash
mkdocs serve
```

This will build a site under http://localhost:8000.

## Tools

The tools for this pipeline are maintained in a Galaxy toolshed at <https://irida.corefacility.ca/galaxy-shed>.  To update the Galaxy tools or transfer to a different toolshed, please use [Planemo][].  A quick way to upload all relevent tools in the correct order is the script `scripts/run_planemo_for_tools.sh`.  This can be run as:

```bash
./scripts/run_planemo_for_tools.sh shed_create --shed_target http://toolshed --shed_key KEY --message 'message'
```

This will create repositories for each tool defined in [tools/tools-to-install.txt][] within the Toolshed at http://toolshed.

In order to check for any differences with the current tools from an existing toolshed install, please run:

```
./scripts/planemo_diff_recursive.sh --shed_target http://toolshed --shed_key KEY
```

Please see the [Planemo][] documentation for more details.

[Galaxy]: http://galaxyproject.org/
[Markdown]: http://daringfireball.net/projects/markdown/syntax
[mkdocs]: http://www.mkdocs.org
[Install Tools in Local Toolshed]: InstallLocalToolshed.md
[Planemo]: http://planemo.readthedocs.org/
[tools/tools-to-install.txt]: tools/tools-to-install.txt
