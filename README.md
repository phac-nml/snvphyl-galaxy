Galaxy Core Phylogenomics Pipeline
==================================

This contains the Galaxy tool definitions and workflow definitions needed to install the [Core Phylogenomis Pipeline][] into Galaxy.  This repository contains two main sections.  A set of tools under `tools/` and a workflow implementing the core phylogenomics pipeline under `workflows/`.  These can be packaged up and uploaded into a [Galaxy Tool Shed][] and then later installed to an instance of Galaxy.  Instructions on how to install your own local Galaxy Tool Shed and Galaxy can be found at [IRIDA Galaxy Setup][].

One small point when setting up Galaxy is that for the pipeline to work properly the default **SQLite** database cannot be used.  Instructions on setting up a better database for Galaxy can be found at the [Production Server Setup][] documentation.

Authors
=======

Philip Mabon, Aaron Petkau

Installing the Tools
====================

The Core Phylogenomics Pipeline makes use of a mixture of local (installed in a local Galaxy Tool Shed) tools as well as tools in the main [Galaxy Tool Shed][].  To install these dependency tools please follow the steps in both sections below.

Installing Local Tools
----------------------

The local tools are meant to be installed in a local Galaxy Tool Shed.  These are located under the `tools/` directory and include the following:

* **phyml**
* **smalt_collection**
* **freebayes**
* **core-pipeline tools**

These can be installed to a Galaxy Tool Shed and then to Galaxy using the following steps.

### Step 1: Building Tool Shed Packages

In order to build packages that can be uploaded to a Galaxy Tool Shed please run the following command.

```bash
./build_for_toolshed.sh
```

This will build a number of `.tar.gz` files within the `build/` directory that can then be uploaded into a Galaxy Tool Shed.


### Step 2: Creating Repositories for Tool Shed Packages

In order to install tools into your own local instance of a Galaxy Tool Shed, you first need to create empty repositories.  This can be accomplished by:

1. Log into your Galaxy Tool Shed.  On the left panel please find and click on the **Create new repository** link.
2. Fill out the name of the repository, for example for `core_phylogenomics_pipeline.tar.gz` you can fill out **core_phylogenomics_pipeline** (please make sure to name the repository the same name as the tarball minus `.tar.gz`).  Fill out any other information.
3. Click on **Save**.
4. Repeat for any other files under `build/`.

### Step 3: Upload Tool Shed Packages

1. Find and click on one of your new empty repositories.
2. In the upper right click on **Upload files to repostory**.
3. From here **Browse** to one of the tool shed packages under `build/` and upload this package.
4. In the upper right corner under **Repository Actions** click on **Reset all repository metadata**.  You should now see a screen listing the tools and dependencies of this repository.

### Step 4: Install Packages to Galaxy

Once you have uploaded the packages to a Galaxy Tool Shed, you can install to a local version of Galaxy linked up to the Tool Shed by following the below steps.

1. Go to **Admin** and from here in the left panel find **Search and browse tool sheds**.
2. Find the Tool Shed where the tool is installed and click on **Browse valid repositories**.  From here find the particular tool you installed.
3. Click on the arrow next to the tool and click on **Preview and install**.
4. Wait for Galaxy to install your tool.

Installing External Tools
-------------------------

Once the above local dependency packages have been installed to the Tool Shed, we can begin to install the external dependencies into Galaxy.  The list of packages that need to be installed includes.

* http://toolshed.g2.bx.psu.edu/repos/devteam/sam_to_bam/sam_to_bam/1.1.4
* http://toolshed.g2.bx.psu.edu/repos/devteam/samtools_mpileup/samtools_mpileup/0.0.3
* http://toolshed.g2.bx.psu.edu/repos/gregory-minevich/bcftools_view/bcftools_view/0.0.1
* http://toolshed.g2.bx.psu.edu/view/iuc/msa_datatypes 

This can be accomplished with the following steps from within your running Galaxy instance.

1. Go to **Admin** and then **Search and browse tool sheds**.
2. Find the **Galaxy main tool shed** and click on **Browse valid repositories**.
3. Do a search for each one of the packages.  This should give you a page to install the package.
4. Install the package into Galaxy.
5. Repeat for each of the packages listed above.

Testing Tools in Galaxy
-----------------------

Once you've finished installing both your local and external tools, you should be able to test it out within Galaxy.  This can be automated by running the functional tests using the commands.  This method of running functional tests will start up a new instance of Galaxy and execute the tools via the API and compare the results to expected output files.  This is adapted from the [Testing Installed Tools][] document and also from [Tool Testing Enhancements][] post.

```bash
export GALAXY_TEST_DB_TEMPLATE=https://github.com/jmchilton/galaxy-downloads/raw/master/db_gx_rev_0117.sqlite # speeds up database construction
export GALAXY_TOOL_DEPENDENCY_DIR=/path/to/tool-dependencies
export GALAXY_TEST_DEFAULT_INTERACTOR=api
export GALAXY_TEST_NO_CLEANUP=true # tests only work if this variable is set
for i in `find $GALAXY_TOOL_DEPENDENCY_DIR -iname 'env.sh'`; do echo $i; source $i; done # must source all environments for tool dependencies
sh run_functional_tests.sh -installed
```

This should generate a report in the file `run_functional_tests.html`.

Installing the Workflow
=======================

Once the tools are installed the workflow under `workflows/` can be installed.  This can be accomplished using the following.

Generating a Galaxy workflow file
---------------------------------

The core snp pipeline workflow is stored as a Galaxy workflow, which contains references to all tools used + tool sheds used to install these tools.  For example freebayes is refered to as `galaxy-shed.corefacility.ca/repos/phil/freebayes/freebayes/0.0.4`.  If you have installed any of the local tools in a differently named tool shed, than this full path will not work.  To work around this issue, a template file is included for the workflow `workflows/core_phylogenomics_pipeline_workflow/Galaxy-Workflow-Core_SNP_Pipeline.ga.tt`.  We can generate the Galaxy-usable workflow file from this template file by using a command similar to:

```bash
perl generate_galaxy_workflow.pl --local-toolshed localhost:9009/repos/aaron workflows/core_phylogenomics_pipeline_workflow/Galaxy-Workflow-Core_SNP_Pipeline.ga.tt > workflows/core_phylogenomics_pipeline_workflow/Galaxy-Workflow-Core_SNP_Pipeline.ga
```

Please replace `localhost:9009/repos/aaron` with the location and user of the tools under your local toolshed.  Once this Galaxy workflow file has been generated we can directly upload the workflow to Galaxy instance using the below steps.

Upload Workflow Directly to a Galaxy Instance
---------------------------------------------

To upload the workflow directly to a running Galaxy instance the following steps can be performed.

1. Log into Galaxy and in the top menu click on **Workflow**.
2. Click on the button to **Upload or import workflow**.
3. Find and browse for the workflow file `Galaxy-Workflow-Core_SNP_Pipeline.ga`.
4. Upload this workflow into Galaxy.

Testing the Workflow
--------------------

Some example test data for the workflow is provided in `workflows/core_phylogenomics_pipeline_workflow/test-data/1`.  To test the workflow please upload the data under `input` and run the workflow.  Please make sure to set all fastq files to type `fastqsanger` and construct a list of paired datasets for each of the input files.  An example file of the expected results is found in `output`.

Updating Workflow
-----------------

If you wish to update the workflow, the template file can be generated with a command like:

```bash
perl -pe 's/"[^"]+?core_pipeline\//"[% LOCAL_REPOSITORY %]\/core_pipeline\//; s/"[^"]+?smalt_collection\//"[% LOCAL_REPOSITORY %]\/smalt_collection\//; s/"[^"]+?phyml\//"[% LOCAL_REPOSITORY %]\/phyml\//; s/"[^"]+?freebayes\//"[% LOCAL_REPOSITORY %]\/freebayes\//' path/to/Galaxy-Workflow-Core_SNP_Pipeline.ga > workflows/core_phylogenomics_pipeline_workflow/Galaxy-Workflow-Core_SNP_Pipeline.ga.tt
```

[Core Phylogenomis Pipeline]: https://github.com/apetkau/core-phylogenomics
[Galaxy Tool Shed]: https://wiki.galaxyproject.org/ToolShed
[Production Server Setup]: https://wiki.galaxyproject.org/Admin/Config/Performance/ProductionServer
[Testing Installed Tools]: https://wiki.galaxyproject.org/TestingInstalledTools
[IRIDA Galaxy Setup]: https://irida.corefacility.ca/gitlab/irida/irida-install-documentation/tree/master/galaxy
[Automated Tool Tests]: https://wiki.galaxyproject.org/AutomatedToolTests
[Hosting a Local Tool Shed]: https://wiki.galaxyproject.org/HostingALocalToolShed
[Install and Test Certification]: https://wiki.galaxyproject.org/InstallAndTestCertification
[Tool Testing Enhancements]: http://dev.list.galaxyproject.org/Tool-Testing-Enhancements-td4663799.html
