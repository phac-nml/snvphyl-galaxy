# Installing SNVPhyl

SNVPhyl is implemented as a [Galaxy Workflow][] and so these instructions assume you have an instance of [Galaxy][] available along with the ability to install tools in this instance of Galaxy.  The install process involves installing custome tools within Galaxy and uploading the SNVPhyl workflow.  Some of these tools are maintained in the [Galaxy Toolshed][] while other tools are included in the [snvphyl-galaxy][] project and maintained in the [IRIDA Toolshed][], part of the [IRIDA][] project.  The following table lists the dependency tools required by the software.  For information on how to install these tools to a local toolshed please refer to the [Install in Local Toolshed][] documentation.

| Tool Name            | Tool Revision | Toolshed Installable Revision | Toolshed             |
|:--------------------:|:-------------:|:-----------------------------:|:--------------------:|
| **msa_datatypes**    | 70227007b991  | 0 (2014-04-22)                | [Galaxy Main Shed][] |
| **bcftools_view**    | 6572c40a8505  | 8 (2012-10-08)                | [Galaxy Main Shed][] |
| **samtools_mpileup** | 973fea5b4bdf  | 3 (2014-03-27)                | [Galaxy Main Shed][] |
| **sam_to_bam**       | c73bf16b45df  | 5 (2015-03-05)                | [Galaxy Main Shed][] |
| **core_pipeline**    | 0737c0310cab  | 0 (2014-10-07)                | [IRIDA Main Shed][]  |
| **freebayes**        | 386bc6e45b68  | 0 (2014-10-07)                | [IRIDA Main Shed][]  |
| **phyml**            | b5867c5c7674  | 0 (2014-10-07)                | [IRIDA Main Shed][]  |
| **smalt_collection** | de3e46eaf5ba  | 0 (2014-10-07)                | [IRIDA Main Shed][]  |

To install these tools, please proceed through the following steps.

## Step 1: Install Dependencies

Some of these tools require additional dependencies to be installed on the Galaxy server.  In particular, [SAMTools 0.1.18][] must be installed on the system and added to the `$PATH` in the `$GALAXY_ENV` file.  For a cluster environment please make sure these are available on all cluster nodes by installing to a shared directory.

## Step 2: Install Galaxy Tools

Please install all the Galaxy tools in the table above by logging into Galaxy, navigating to **Admin > Search and browse tool sheds**, searching for the appropriate **Tool Name** and installing the appropriate **Toolshed Installable Revision**.

The install progress can be monitored in the Galaxy log file `galaxy-dist/paster.log`.  On completion you should see a message of `Installed` next to the tool when going to **Admin > Manage installed tool shed repositories**.

## Step 3: Upload the workflow

The pipeline is implemented as a workflow in Galaxy which depends on the above tools.  Please download the [SNVPhyl Galaxy Workflow][] file and upload to Galaxy by going to **Workflow > Upload or import workflow**.

## Step 4: Testing the Workflow

Some test data has been included with this documentation to verify that all tools are installed correctly.  To test this workflow, please proceed through the following steps.

1. Upload a reference genome by going to **Analyze Data** and then clicking on the **upload files from disk** ![upload-icon][] icon in the **Tools** panel.  Select the [test/reference.fasta][] file.
2. Upload the sequence reads by going to **Analyze Data** and then clicking on the **upload files from disk**.  Select the [test/reads][] files.  Make sure to change the **Type** of each file from **Auto-detect** to **fastqsanger**.  When uploaded you should see the following in your history.

    ![upload-history][]

3. Construct a dataset collection of the paired-end reads by clicking the **Operations on multiple datasets** icon ![datasets-icon][].  Please check off all the **.fastq** files and then go to **For all selected... > Build List of dataset pairs**.  You should see a screen that looks as follows.

    ![dataset-pair-screen][]

4. This should have properly paired your data and named each sample **a**, **b**, and **c**.  Enter the name of this paired dataset collection at the bottom and click **Create list**.
5. Run the SNVPhyl workflow by clicking on **Workflow**, clicking on the name of the workflow **SNVPhyl Pipeline** and clicking **Run**.  This should auto fill in the reference file and dataset collection.  And the very bottom of the screen click **Run workflow**.
6. If everything was installed correctly, you should see each of the tools run successfully (turn green).  On completion this should look like.

    ![workflow-success][]

    If you see any tool turn red, you can click on the view details icon ![view-details-icon][] for more information.

If everything was successfull then all dependencies for this pipeline have been properly installed.

[Galaxy]: http://galaxyproject.org/
[Galaxy Workflow]: https://wiki.galaxyproject.org/Learn/AdvancedWorkflow
[snvphyl-galaxy]: https://irida.corefacility.ca/gitlab/analysis-pipelines/snvphyl-galaxy
[IRIDA]: http://irida.ca
[SNVPhyl]: https://irida.corefacility.ca/gitlab/analysis-pipelines/snvphyl-galaxy/tree/development
[Galaxy Main Shed]: http://toolshed.g2.bx.psu.edu/
[IRIDA Main Shed]: https://irida.corefacility.ca/galaxy-shed
[Galaxy Toolshed]: http://toolshed.g2.bx.psu.edu/
[IRIDA Toolshed]: https://irida.corefacility.ca/galaxy-shed
[SAMTools 0.1.18]: http://downloads.sourceforge.net/project/samtools/samtools/0.1.18/samtools-0.1.18.tar.bz2
[SNVPhyl Galaxy Workflow]: workflows/SNVPhyl/0.1/snvphyl_workflow.ga
[upload-icon]: install/test/images/upload-icon.jpg
[test/reference.fasta]: install/test/reference.fasta
[test/reads]: install/test/reads
[upload-history]: install/test/images/upload-history.jpg
[datasets-icon]: install/test/images/datasets-icon.jpg
[dataset-pair-screen]: install/test/images/dataset-pair-screen.jpg
[workflow-success]: install/test/images/workflow-success.jpg
[view-details-icon]: install/test/images/view-details-icon.jpg
