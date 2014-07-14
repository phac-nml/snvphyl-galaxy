Galaxy Core Phylogenomics Pipeline
==================================

This contains the Galaxy tool definitions and workflow definitions needed to install the [Core Phylogenomis Pipeline](https://github.com/apetkau/core-phylogenomics) into Galaxy.

Authors
=======

Philip Mabon, Aaron Petkau

Install
=======

This repository contains two main sections.  A set of tools under `tools/` and a workflow implementing the core phylogenomics pipeline under `workflows/`.  These can be packaged up and uploaded into a [Galaxy Tool Shed](https://wiki.galaxyproject.org/ToolShed) and then later installed to an instance of Galaxy.  Instructions on how to install your own local Galaxy Tool Shed and Galaxy can be found at https://irida.corefacility.ca/gitlab/irida/irida-install-documentation/tree/feature/galaxy-setup/galaxy.

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

Step 5: Test out your tool in Galaxy
------------------------------------

Once you've finished installing your tool, you should be able to test it out within Galaxy.  This can be automated by running the functional tests using the commands (from https://wiki.galaxyproject.org/TestingInstalledTools):

```bash
$ export GALAXY_TOOL_DEPENDENCY_DIR=/path/to/tool-dependencies
$ for i in `find $GALAXY_TOOL_DEPENDENCY_DIR -iname 'env.sh'`; do echo $i; source $i; done # must source all environments for tool dependencies
$ sh run_functional_tests.sh -installed
```

This should generate a report in the file `run_functional_tests.html`.

Test
====

Testing tools can be performed once installed to a Tool Shed using the following steps.  This is a summary of the information found at https://wiki.galaxyproject.org/AutomatedToolTests.

Step 1: Check for Valid Tests
-----------------------------

This will check all repositories in the Tool Shed for any valid tests.  This can be performed by running:

```bash
$ python lib/tool_shed/scripts/check_repositories_for_functional_tests.py
```

This will return a report of valid tests found within the repositories and mark any valid tests as being runnable.

Step 2: Run Functional Tests
----------------------------

This step will build a clean install of Galaxy, install any tools marked as runnable from **Step 1** and attempt to run all functional tests.  This step can be run by setting the following environment variables and running the given script:

```bash
export GALAXY_INSTALL_TEST_TOOL_SHED_API_KEY=key
export GALAXY_INSTALL_TEST_TOOL_SHED_URL=http://location/to/toolshed
export GALAXY_INSTALL_TEST_TOOL_DEPENDENCY_DIR=/tmp/location/to/tmp/dir

sh install_and_test_tool_shed_repositories.sh
```

It's also possible to run with the below command, from https://wiki.galaxyproject.org/HostingALocalToolShed.

```bash
$ sh run_tool_shed_functional_tests.sh
```

Also see https://wiki.galaxyproject.org/InstallAndTestCertification.
