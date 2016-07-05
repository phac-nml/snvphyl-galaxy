SNVPhyl Versions
================

This describes the different release versions of SNVPhyl.

Version 1.0
===========

Released on **July 5, 2016**.

Install
-------

* Docker - `apetkau/snvphyl-galaxy-1.0`
* Virtual Machine - [snvphyl-galaxy-1.0.zip](https://irida.corefacility.ca/downloads/snvphyl-galaxy/snvphyl-galaxy-1.0.zip)
* Galaxy Tools - [suite_snvphyl_1_0_0](https://irida.corefacility.ca/galaxy-shed/view/nml/suite_snvphyl_1_0_0/4e41de612a14)
* Galaxy Workflows
    * Paired-end: [SNVPhyl Paired-End 1.0](../workflows/SNVPhyl/1.0/snvphyl-workflow-1.0.ga) and [SNVPhyl Paired-End 1.0 (invalid-positions)](../workflows/SNVPhyl/1.0/snvphyl-workflow-1.0-invalid-positions.ga)
    * Single-end: [SNVPhyl Single-End 1.0](../workflows/SNVPhyl/1.0/snvphyl-workflow-1.0-single-end.ga) and [SNVPhyl Single-End 1.0 (invalid-positions)](../workflows/SNVPhyl/1.0/snvphyl-workflow-1.0-single-end-invalid-positions.ga)
* Git - <https://github.com/phac-nml/snvphyl-galaxy/tree/v1.0>

Changelog
---------

* Additions
    * Added ability to remove high-density SNV regions by adjusting a window size and threshold of SNVs.
    * Added additional information to the `vcf2core.tsv` output file.
    * Added workflows for single-end sequence read data.
    * Re-named many internal scripts to use terminology of SNV alignment instead of pseudoalignment.
* Fixes
    * Fixed output of `filterStats.txt` to include invalid positions.
    * Additional checks to verify depth of coverage for invariant sites.
    * Fixed behaviour of of tools like bcftools to enable re-scheduling within a cluster when run through Galaxy by ignoring existing output file.
    * Fixed up issues with incorrect/missing dependencies among tools in Galaxy.

Version 0.3
===========

Released on **November 13, 2015**.

Install
-------

* Docker - `apetkau/snvphyl-galaxy-0.3`
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
