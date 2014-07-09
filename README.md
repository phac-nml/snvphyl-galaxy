Galaxy Core Phylogenomics Pipeline
==================================

This contains the Galaxy tool definitions and workflow definitions needed to install the [Core Phylogenomis Pipeline](https://github.com/apetkau/core-phylogenomics) into Galaxy.

Authors
=======

Philip Mabon, Aaron Petkau


Building Tool Shed Packages
---------------------------

In order to build packages that can be uploaded to a Galaxy Tool Shed please run the following command.

```bash
$ ./build_for_toolshed.sh
```

This will build a number of `.tar.gz` files within the `build/` directory that can then be uploaded into a Galaxy Tool Shed.
