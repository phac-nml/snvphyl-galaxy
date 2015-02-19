SNVPhyl Whole Genome Phylogenomics Pipeline
===========================================

This is the main repository for the **SNVPhyl** pipeilne used for constructing whole genome phylogenies.  This pipeline is implemented as a [Galaxy][] workflow which may be installed in any Galaxy instance.  The installation steps are, briefly:

1. Install the Galaxy Dependency Tools
2. Upload the Workflow to an Instance of Galaxy

Some of these tools are maintained by the [IRIDA][] group and are included in this repository under the `tools/` directory.  For instructions on how to upload these tools to a custom [Galaxy Toolshed][] please see the [Install to Local Toolshed][] documentation.  Please note that if you install the tools to a local toolshed you will need to modify the workflow to reflect the new location and version number of these tools.

Install the Galaxy Dependency Tools
------------------------------------

The dependency tools for this pipeline are listed below.  These may be installed in Galaxy by navigating to **Admin > Search and browse tool sheds**, searching for the appropriate **Tool Name** and installing the appropriate **Tool Revision**.

| Tool Name          | Tool Revision | Toolshed             |
|:------------------:|:-------------:|:--------------------:|
| `msa_datatypes`    | 70227007b991  | [Galaxy Main Shed][] |
| `bcftools_view`    | 6572c40a8505  | [Galaxy Main Shed][] |
| `samtools_mpileup` | 973fea5b4bdf  | [Galaxy Main Shed][] |
| `sam_to_bam`       | 8176b2575aa1  | [Galaxy Main Shed][] |
| `core_pipeline`    | 0737c0310cab  | [IRIDA Main Shed][]  |
| `freebayes`        | 386bc6e45b68  | [IRIDA Main Shed][]  |
| `phyml`            | b5867c5c7674  | [IRIDA Main Shed][]  |
| `smalt_collection` | de3e46eaf5ba  | [IRIDA Main Shed][]  |

Upload the Galaxy Workflow
--------------------------

The workflow file is located within `workflows/SNVPhyl/0.1/irida_workflow_structure.ga`.  Please upload this file as a workflow within Galaxy once all the tools are installed.

[IRIDA]: http://irida.ca
[Galaxy]: http://galaxyproject.org/
[Install to Local Toolshed]: InstallLocalToolshed.md
[Galaxy Toolshed]: https://wiki.galaxyproject.org/ToolShed
[Galaxy Main Shed]: http://toolshed.g2.bx.psu.edu/
[IRIDA Main Shed]: https://irida.corefacility.ca/galaxy-shed
