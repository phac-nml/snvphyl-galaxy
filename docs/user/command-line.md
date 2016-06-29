# SNVPhyl Command-line Interface

A command-line interface to the SNVPhyl pipeline is provided by the [SNVPhyl Galaxy CLI][] project.  This automates the process of uploading data to Galaxy, setting parameters, running a workflow, and compiling results.

# Installation

The SNVPhyl CLI requires [Python][] along with some dependency modules to be installed.  To install these please run:

```bash
git clone https://github.com/phac-nml/snvphyl-galaxy-cli.git
pip install -r snvphyl-galaxy-cli/requirements.txt
```

# Usage

The SNVPhyl CLI can be run using two separate methods.  The first connects to an existing Galaxy instance and executes the SNVPhyl pipeline.  The second method will start a Galaxy instance using [Docker][], and then run the SNVPhyl pipeline, cleaning up the Docker instance after completion.  For example input data please see the provided **example-data/** directory.

## Galaxy

To execute SNVPhyl within an existing Galaxy installation, please run:

```bash
bin/snvphyl.py --galaxy-url http://galaxy --galaxy-api-key 1234 --fastq-dir fastqs/ --reference-file reference.fasta --output-dir output
```

This assumes your Galaxy instance has all the SNVPhyl dependency tools and workflows pre-installed.  If this is not the case, an alternative is to use the Docker method.

## Docker

Assuming you have Docker installed and configured to run without `sudo`, then the SNVPhyl pipeline can be run without an existing Galaxy installation with:

```bash
bin/snvphyl.py --deploy-docker --fastq-dir fastqs/ --reference-file reference.fasta --output-dir output1
```

Please see the [SNVPhyl Galaxy CLI][] project for additional details.

[SNVPhyl Galaxy CLI]: https://github.com/phac-nml/snvphyl-galaxy-cli
[Python]: https://www.python.org/
[Docker]: https://www.docker.com/
