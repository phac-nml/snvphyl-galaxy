SNVPhyl Tools
=============

This directory contains the necessary dependency tools for SNVPhyl.  These must be uploaded to a [Galaxy Toolshed][] to be used to install in different Galaxy instances.  Installing these tools to a separate toolshed can be accomplished by the following steps.

1.  Create necessary categories in a toolshed.  The categories to use can be found with:

    ```
    find tools/ -iname '.shed.yml' | xargs grep -h categories|sort -u                               
    categories: []
    categories: [Sequence Analysis]
    categories: [Text Manipulation]
    categories: [Tool Dependency Packages]
    categories: [Variant Analysis]    
    ```

    In addition to these, please add the cateogry `SAM`.

2.  Upload all tool capsules in [capsules][].  These were exported from the [Main Galaxy Toolshed][].

3.  Upload all custom tools for SNVPhyl.  This can be accomplished using [Planemo][] by running:

    ```
    ./scripts/run_planemo_for_tools.sh shed_create --shed_target http://localhost:9010 --shed_key 30c7ca4b73669666178b2aee378a2b99 -m 'commit'
    ```

    Where `run_planemo_for_tools.sh` runs the passed parameters using planemo on all tools defined in [tools-to-install][].

4.  To, later, update, please run:

    ```
    ./scripts/run_planemo_for_tools.sh shed_update --shed_target http://localhost:9010 --shed_key 30c7ca4b73669666178b2aee378a2b99 -m 'commit'
    ```

[Galaxy Toolshed]: https://wiki.galaxyproject.org/ToolShed
[capsules]: capsules/
[Main Galaxy Toolshed]: https://toolshed.g2.bx.psu.edu/
[Planemo]: https://planemo.readthedocs.org/en/latest/
[tools-to-install]: tools-to-install.txt
