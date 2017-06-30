# SNVPhyl: Whole Genome SNV Phylogenomics Pipeline

The SNVPhyl (SNV PHYLogenomics) pipeline is a pipeline for identifying Single Nucleotide Variants (SNV) within a collection of microbial genomes and constructing a phylogenetic tree.  Detailed documentation can be found at <http://snvphyl.readthedocs.io/>.  This repository contains the customized [Galaxy][] tools for this pipeline as well as the source for the documentation.

# Availability

## Command-line interface

A command-line interface for SNVPhyl is available at <https://github.com/phac-nml/snvphyl-galaxy-cli>.  This can be used to automatically prepare data and run SNVPhyl in a pre-existing Galaxy instance, or in a custom [Docker][] container.  To quickly try out SNVPhyl, the following can be run (assuming Python and Docker are installed).

```bash
git clone https://github.com/phac-nml/snvphyl-galaxy-cli.git
cd snvphyl-galaxy && pip install -r requirements.txt

# append `--with-docker-sudo` if docker command requires sudo
python bin/snvphyl.py --deploy-docker --fastq-dir example-data/fastqs --reference-file example-data/reference.fasta --min-coverage 5 --output-dir output1
```

Please see <https://github.com/phac-nml/snvphyl-galaxy-cli> for more details.

## Galaxy

The SNVPhyl pipeline is available via a Galaxy toolshed at <http://irida.corefacility.ca/galaxy-shed>.  Dependency tools are installable via the `suite_snvphyl_x_y_z` tool suite.  Workflow files are available at [docs/workflows/SNVPhyl/](docs/workflows/SNVPhyl/).

Please see <http://snvphyl.readthedocs.io/en/latest/install/galaxy/> for more details.

## Virtual Machine

A virtual machine containing the SNVPhyl workflow pipeline and Galaxy is available for download at <https://irida.corefacility.ca/downloads/snvphyl-galaxy/snvphyl-galaxy-current.zip> or, using [Vagrant][], can be launched like:

```bash
git clone https://github.com/phac-nml/snvphyl-galaxy.git
cd snvphyl-galaxy/vagrant
vagrant up
```

Galaxy and SNVPhyl can then be accessed through <http://localhost:48888> with username `admin@localhost.localdomain` and password `adminpassword`.

Please see <http://snvphyl.readthedocs.io/en/latest/install/virtualmachine/> for more details.

## Docker

A [Docker][] image of SNVPhyl and Galaxy can be launched by running:

```bash
docker run -d -p 48888:80 phacnml/snvphyl-galaxy-1.0.1
```

Galaxy and SNVPhyl can then be access through <http://localhost:48888> with username `admin@galaxy.org` and password `admin`.

Please see <http://snvphyl.readthedocs.io/en/latest/install/docker/> for more details, or <https://github.com/bgruening/docker-galaxy-stable> for details on the underlying Galaxy Docker image.

# Citation

Petkau A, Mabon P, Sieffert C, Knox N, Cabral J, Iskander M, Iskander M, Weedmark K, Zaheer R, Katz L, Nadon C, Reimer A, Taboada E, Beiko R, Hsiao W, Brinkman F, Graham M, Van Domselaar G. [SNVPhyl: a single nucleotide variant phylogenomics pipeline for microbial genomic epidemiology](http://dx.doi.org/10.1099/mgen.0.000116). 08/06/2017. *M Gen* 3(6): doi:[10.1099/mgen.0.000116](https://doi.org/10.1099/mgen.0.000116).

# Legal

Copyright 2012-2016 Government of Canada

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this work except in compliance with the License. You may obtain a copy of the
License at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.


[Galaxy]: http://galaxyproject.org/
[Vagrant]: https://www.vagrantup.com/
[Docker]: https://www.docker.com/
