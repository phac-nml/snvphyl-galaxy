SNVPhyl Versions
================

This describes the different release versions of SNVPhyl.

Version 0.3
===========

Released on **November 13, 2015**.

Install
-------

* Docker - `apetkau/snvphyl-galaxy:0.3`
* Virtual Machine - [snvphyl-galaxy-0.3.zip](https://irida.corefacility.ca/downloads/snvphyl-galaxy/snvphyl-galaxy-0.3.zip)
* Galaxy Tools - [suite_snvphyl_0_3_0](https://irida.corefacility.ca/galaxy-shed/view/nml/suite_snvphyl_0_3_0/bb2e651149da)
* Galaxy Workflow - [SNVPhyl Paired-End 0.3](../workflows/SNVPhyl/0.3/snvphyl-workflow-0.3.ga) and [SNVPhyl Paired-End 0.3 (invalid-positions)](../workflows/SNVPhyl/0.3/snvphyl-workflow-0.3-invalid-positions.ga)
* Git - <https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/v0.3>

Changelog
---------

* Updated git URLs to reference new gitlab <https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy>.
* Updated FreeBayes to refer to latest version in Galaxy **freebayes_0_9_20_b040236**
* Updated `samtools sort` to use multiple threads.
* Made **Do not perform INDEL calling** the default for SAMtools mpileup.

Version 0.2-beta-1
==================

Released on **September 21, 2015**.

Install
-------

* Docker - `apetkau/snvphyl-galaxy:0.2-beta-1`
* Virtual Machine - [snvphyl-galaxy-0.2-beta-1.zip](https://irida.corefacility.ca/downloads/snvphyl-galaxy/snvphyl-galaxy-0.2-beta-1.zip)
* Galaxy Tools - [suite_snvphyl_0_2_0](https://irida.corefacility.ca/galaxy-shed/repository?repository_id=8cbe70cdff6b156a&changeset_revision=9c9c6f7e0d43)
* Galaxy Workflow - [SNVPhyl Paired-End 0.2](../workflows/SNVPhyl/0.2/snvphyl-workflow-0.2.ga) and [SNVPhyl Paired-End 0.2 (invalid-positions)](../workflows/SNVPhyl/0.2/snvphyl-workflow-0.2-invalid-positions.ga)
* Git - <https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/v0.2-beta-1>

Changelog
---------

* Initial release of SNVPhyl run through Galaxy
* Includes Docker and Virtual Machine images
* Mapping/variant calling, variant merging, constructing phylogeny
* Quality checking tools for coverage, % of core used, and variants filtered
