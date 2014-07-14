Galaxy Core Phylogenomics Pipeline
==================================

This contains the Galaxy tool definitions and workflow definitions needed to install the [Core Phylogenomis Pipeline][] into Galaxy.  This repository contains two main sections.  A set of tools under `tools/` and a workflow implementing the core phylogenomics pipeline under `workflows/`.  These can be packaged up and uploaded into a [Galaxy Tool Shed][] and then later installed to an instance of Galaxy.  Instructions on how to install your own local Galaxy Tool Shed and Galaxy can be found at [IRIDA Galaxy Setup][].

Authors
=======

Philip Mabon, Aaron Petkau

Installing the Tools
====================

The tools under the `tools/` directory can be installed to a Galaxy Tool Shed and then to Galaxy using the following steps.

Step 1: Building Tool Shed Packages
-----------------------------------

In order to build packages that can be uploaded to a Galaxy Tool Shed please run the following command.

```bash
$ ./build_for_toolshed.sh
```

This will build a number of `.tar.gz` files within the `build/` directory that can then be uploaded into a Galaxy Tool Shed.


Step 2: Creating Repositories for Tool Shed Packages
----------------------------------------------------

In order to install tools into your own local instance of a Galaxy Tool Shed, you first need to create empty repositories.  This can be accomplished by:

1. Log into your Galaxy Tool Shed.  On the left panel please find and click on the **Create new repository** link.
2. Fill out the name of the repository, for example for `core_phylogenomics_pipeline.tar.gz` you can fill out **core_phylogenomics_pipeline**.  Fill out any other information.
3. Click on **Save**.
4. Repeat for any other files under `build/`.

Step 3: Upload Tool Shed Packages
---------------------------------

1. Find and click on one of your new empty repositories.
2. In the upper right click on **Upload files to repostory**.
3. From here **Browse** to one of the tool shed packages under `build/` and upload this package.
4. In the upper right corner under **Repository Actions** click on **Reset all repository metadata**.  You should now see a screen listing the tools and dependencies of this repository.

Step 4: Install Packages to Galaxy
----------------------------------

Once you have uploaded the packages to a Galaxy Tool Shed, you can install to a local version of Galaxy linked up to the Tool Shed by following the below steps.

1. Go to **Admin** and from here in the left panel find **Search and browse tool sheds**.
2. Find the Tool Shed where the tool is installed and click on **Browse valid repositories**.  From here find the particular tool you installed.
3. Click on the arrow next to the tool and click on **Preview and install**.
4. Wait for Galaxy to install your tool.

Step 5: Install Additional Dependencies
---------------------------------------

The following additional dependency packages included in this repository need to be installed to the Galaxy Tool Shed, and then into Galaxy.  These are located under `tools/`.  The full list of dependencies is:

* phyml

In order to install the dependencies, use the following steps.

1. Build dependencies using `build_for_toolshed.sh`.
2. Log into a Galaxy Tool Shed and create repositories for each dependency.
3. Upload tarball packages for each dependency.
4. Log into Galaxy and install dependency packages.

Step 6: Install Dependency Packages to Galaxy
---------------------------------------------

Some dependency packages need to be installed separately to Galaxy.  This can be accomplished with the following steps from within your running Galaxy instance.

1. Go to **Admin** and then **Search and browse tool sheds**.
2. Find the **Galaxy main tool shed** and click on **Browse valid repositories**.
3. Do a search for `msa_datatypes`.  This should give a package with a collection of datatypes for multiple sequence alignments.
4. Install this package to Galaxy.  The particular data type we are looking for is the `phylip` datatype.

Step 7: Test out your tool in Galaxy
------------------------------------

Once you've finished installing your tool, you should be able to test it out within Galaxy.  This can be automated by running the functional tests using the commands.  This is adapted from the [Testing Installed Tools][] document.

```bash
$ export GALAXY_TOOL_DEPENDENCY_DIR=/path/to/tool-dependencies
$ for i in `find $GALAXY_TOOL_DEPENDENCY_DIR -iname 'env.sh'`; do echo $i; source $i; done # must source all environments for tool dependencies
$ sh run_functional_tests.sh -installed
```

This should generate a report in the file `run_functional_tests.html`.

Installing the Workflow
=======================

Once the tools are installed the workflow under `workflows/` can be installed.  This can be accomplished using the following steps.

Step 1: Upload Workflow to Tool Shed
------------------------------------

The workflow can be uploaded to a Galaxy Tool Shed  using the following commands.

1. Run the script `build_for_toolshed.sh`.  This will generate a file `build/core_phylogenomics_pipeline_workflow.tar.gz` containing the workflow.
2. In the Galaxy Tool Shed, create a new repository to contain your workflow.
3. From the button at the top right that says **Upload files to repository** please upload the file containing the workflow `build/core_phylogenomics_pipeline_workflow.tar.gz`.

Step 2: Install Workflow from Tool Shed to Galaxy
-------------------------------------------------

To install a workflow from the Tool Shed into a running Galaxy instance please use the following steps.

1. From the Galaxy instance go to **Admin** and then to **Search and browse tool sheds**.
2. Find the particular tool shed containing your workflow and then find the workflow repository you just uploaded.
3. Install this workflow into Galaxy.

[Core Phylogenomis Pipeline]: https://github.com/apetkau/core-phylogenomics
[Galaxy Tool Shed]: https://wiki.galaxyproject.org/ToolShed
[Testing Installed Tools]: https://wiki.galaxyproject.org/TestingInstalledTools
[IRIDA Galaxy Setup]: https://irida.corefacility.ca/gitlab/irida/irida-install-documentation/tree/master/galaxy
[Automated Tool Tests]: https://wiki.galaxyproject.org/AutomatedToolTests
[Hosting a Local Tool Shed]: https://wiki.galaxyproject.org/HostingALocalToolShed
[Install and Test Certification]: https://wiki.galaxyproject.org/InstallAndTestCertification
