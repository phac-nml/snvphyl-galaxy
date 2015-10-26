SNVPhyl Versions
================

This describes the different release versions of SNVPhyl.

Version 0.3
===========

Released on **October 27, 2015**.

Install
-------

* Docker - `apetkau/snvphyl-galaxy:0.3`
* Virtual Machine - [snvphyl-galaxy-0.3.zip](https://irida.corefacility.ca/downloads/snvphyl-galaxy/snvphyl-galaxy-0.3.zip)
* Galaxy - revision **99463e5aef1b** - <https://irida.corefacility.ca/galaxy-shed/view/nml/suite_snvphyl/99463e5aef1b>
* Git - <https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/v0.3>

Changelog
---------

* Updated git URLs to reference new gitlab <https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy>.
* Updated FreeBayes to refer to latest version in Galaxy **freebayes_0_9_20_b040236**
* Updated `samtools sort` to use multiple threads.

Version 0.2-beta-1
==================

Released on **September 21, 2015**.

Install
-------

* Docker - `apetkau/snvphyl-galaxy:0.2-beta-1`
* Virtual Machine - [snvphyl-galaxy-0.2-beta-1.zip](https://irida.corefacility.ca/downloads/snvphyl-galaxy/snvphyl-galaxy-0.2-beta-1.zip)
* Galaxy - revision **99463e5aef1b** - <https://irida.corefacility.ca/galaxy-shed/view/nml/suite_snvphyl/99463e5aef1b>
* Git - <https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/v0.2-beta-1>

Changelog
---------

* Initial release of SNVPhyl run through Galaxy
* Includes Docker and Virtual Machine images
* Mapping/variant calling, variant merging, constructing phylogeny
* Quality checking tools for coverage, % of core used, and variants filtered
