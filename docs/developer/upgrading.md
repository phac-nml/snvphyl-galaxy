# SNVPhyl Release

This document describes how to update and release new versions of the SNVPhyl pipeline.  This is meant for users who wish to create a local [Galaxy Toolshed][] with all the SNVPhyl tools available.  This is not meant for users who wish to install SNVPhyl (please refer to the [Installation][] documentation if this is the case.

Releasing a new version of the SNVPhyl pipeline in a Galaxy toolshed can be accomplished, briefly, by the following steps.

1. Package SNVPhyl
    1. Update version in `tool_dependencies.xml` and `.shed.yml`.
    2. Create new repository with Planemo: `planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update to 1.5'  tools/package_snvphyl`
2. SNVPhyl Tools
    1. Update version numbers for each tool, in particular the [tools/snvphyl-tools][].
    2. Run `./scripts/run_planemo_for_tools.sh shed_update --shed_target http://localhost:9009 --shed_key KEY --message 'update'`.
3. SNVPhyl Tool Suite
    1. Update tool suite version number.
    2. Install with `planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update to 0.3'  tools/suite_snvphyl`.
4. SNVPhyl Workflow
    1. Create new directory for workflow and update version numbers for each tool.
    2. Update repository information.
5. Virtual Environments
    1. Build **VirtualBox** and **Docker** virtual machines.
6. Update Documentation
    1. Update any documentation to reflect newer workflow.

# 1. Package SNVPhyl

The [tools/package_snvphyl][] defines a dependency package within Galaxy which wraps around the scripts and other software within the [snvphyl-tools][] project.  This is linked to a specific git commit within the **snvphyl-tools** project.  Each new release must go into a separate Galaxy repository named based on the version number.  For example, version **1.5** should go under the Galaxy repository **package_snvphyl_1_5**.  This can be accomplished in the following way:

1. Modify `package_snvphyl/tool_dependencies.xml` and update the version number.

        <package name="snvphyl" version="1.5">

2. Modify `package_snvphyl/.shed.yml` and update the **name**.

        name: package_snvphyl_1_5

3. Install **package_snvphyl** to new repository in a Galaxy toolshed.

        planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update to 1.5'  tools/package_snvphyl

# 2. SNVPhyl Tools

The SNVPhyl Tools include any dependency tools within Galaxy needed to run SNVPhyl.  These are all located within the [tools/][] directory.  This includes **capsules**, exported tools from the main Galaxy toolshed, and other tools developed specifically for SNVPhyl.

## Update Versions

Any modification to these tools should also include an update of the version number within the tool.  For example:

```xml
<tool id="smalt_map" name="smalt map" version="1.0.1">
```

A particular case of version numbers are the tools under [tools/snvphyl-tools][].  Each of these tools depends on **package_snvphyl** described above and should be updated and given a version number accordingly.  For example, for the tool **find_repeats** the updates would be:

1. Update **tool_dependencies.xml** to depend on newer **package_snvphyl**.

        <package name="snvphyl" version="1.5">
            <repository  name="package_snvphyl_1_5" owner="nml"  />
        </package>

2. Update **find-repeats.xml** to depend on newer **package_snvphyl**.

        <tool id="findrepeat" name="Find Repeats" version ="1.5.0">
        ...
        <requirement type="package" version="1.5">snvphyl</requirement>

Note that the version for **package_snvphyl** `1.5` should correspond to the version for **findrepeat** `1.5.0`.  Minor updates to `findrepeat` should update the last version number (e.g. `1.5.1`).

## Install Updated Tools

Updated tools can all be installed using the `planemo shed_update` command.  A script `run_planemo_for_tools.sh` has been setup to help automate this process.  This can be run with:

```bash
./scripts/run_planemo_for_tools.sh shed_update --shed_target http://localhost:9009 --shed_key KEY --message 'update'
```

# 3. SNVPhyl Tool Suite

The SNVPhyl Tool Suite is located in [tools/suite_snvphyl][] and links together all the dependency tools for SNVPhyl into one installable package in Galaxy.  Each new version must be installed to a separate repository in a Galaxy Toolshed with the version number in the name (e.g. `suite_snvphyl_0_3_0`).  This can be accomplished by:

1. Make sure previous steps for upgrading all tools have been completed.
2. Change the **name** in the `suite_snvphyl/.shed.yml` file to reflect the new name.

        name: suite_snvphyl_0_3_0

3. Use Planemo to create a new repository.

        planemo shed_create --shed_target http://localhost:9009 --shed_key KEY -m 'update to 0.3'  tools/suite_snvphyl

This will link up all the most recent versions of the tools into the `suite_snvphyl_0_3_0` repository.  If something goes wrong, newer updates can be uploaded manully and the most recent version will be used.

# 4. SNVPhyl Workflow

The SNVPhyl workflows for each version of the pipeline are located within [docs/workflows/SNVPhyl][].  A new directory should be created for the updated version and newer `*.ga` workflow files along with the `repository_dependencies.xml` should be copied over.  For example:

```
mkdir 0.3
cp 0.2/*.ga 0.3/
cp 0.2/repository_dependencies.xml 0.3/
```

Each of the tools in the previous version of the workflow file should be updated in the `*.ga` file.  For example:

```
"tool_id": "irida.corefacility.ca/galaxy-shed/repos/nml/find_repeats/findrepeat/1.5.0"
...
"tool_version": "1.5.0"
```

If any parameters have changed then the workflow may need to be re-loaded into a Galaxy instance and re-constructed.

The constructed workflows should be, at the minimum, tested on the data under [docs/workflows/SNVPhyl/test][].

In addition, the `repository_dependencies.xml` file will need to be updated to point to the newly installed `suite_snvphyl_x_y_z`.  For example:

```xml
<repository toolshed="https://irida.corefacility.ca/galaxy-shed" name="suite_snvphyl_0_3_0" owner="nml" changeset_revision="99463e5aef1b" />
```

# 5. Virtual Environments

There are two virtual environments that are being distributed, **Virtual Box** and **Docker**.  These can be re-constructed as follows.

## Virtual Box

### Constructing a VM

The Virtual Box virtual machine is constructed using Packer in the directory [packer/][].  Before constructing the latest virtual machine, the script `packer/scripts/galaxy.sh` will need to be modified to load up the latest workflow directory.  For example:

```bash
python install-workflow-tools.py --workflows-dir workflows/SNVPhyl/0.3/ ...
```

Once this is done, the virtual machine can be constructed with:

```bash
packer build -only=virtualbox-iso snvphyl-galaxy.json
```

After construction the virtual machine should be tested out to make sure all tools within Galaxy are loaded up.

### Updating VM

Once the virtual machine is constructed, it should be copied over to `/Warehouse/Applications/irida/snvphyl-galaxy/` and the file [vagrant/Vagrantfile][] should be updated to reflect the changes.

## Docker

The Docker image is constructed using Docker within the directory [docker/][].  To build an updated Docker image, the following steps should be used:

1. Copy latest workflow files to `docker/galaxy/`

        cp ../../docs/workflows/SNVPhyl/0.3/*.ga galaxy/

2. Modify the `Dockerfile` to install the newer workflows/tools

        ADD ./galaxy/snvphyl-workflow-0.2.ga /tmp/snvphyl-workflow-0.3.ga
        ...
        RUN install-repository \
            "-r 99463e5aef1b --url https://irida.corefacility.ca/galaxy-shed/ -o nml --name suite_snvphyl_0_3_0 --panel-section-id SNVPhyl" && \
            install-workflow \
            "/tmp/snvphyl-workflow-0.3.ga" "/tmp/snvphyl-workflow-0.3-invalid-positions.ga"

3. Re-build Docker image

        sudo docker build -t apetkau/snvphyl-galaxy-0.3

Once the Docker image is build it can be pushed to <https://hub.docker.com/>.

# 6. Update Documentation

Once the workflow is updated, the documentation, under the `docs/` directory should be updated to reflect any changes.

[Galaxy Toolshed]: https://wiki.galaxyproject.org/ToolShed
[Installation]: ../install/index.md
[tools/]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/tools
[tools/snvphyl-tools]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/tools/snvphyl-tools
[tools/package_snvphyl]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/tools/package_snvphyl
[snvphyl-tools]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-tools
[tools/suite_snvphyl]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/tools/suite_snvphyl
[docs/workflows/SNVPhyl]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/docs/workflows/SNVPhyl
[docs/workflows/SNVPhyl/test]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/docs/workflows/SNVPhyl/test
[packer/]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/packer
[vagrant/Vagrantfile]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/blob/development/vagrant/Vagrantfile
[docker/]: https://irida.corefacility.ca/analysis-pipelines/snvphyl-galaxy/tree/development/docker
