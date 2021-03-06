SNVPhyl Pipeline Tools
======================

This document describes how to build and install the SNVPhyl tools within a custom toolshed.  The tools are located under `tools/`.  These can be packaged up and uploaded into a [Galaxy Tool Shed][] and then later installed to an instance of Galaxy.  The list of tools is given below:

* **core-pipeline tools**

Additionality, tools available from toolshed.g2.bx.psu.edu will also be installed in a custom toolshed. The list of tools is given below:

* **freebayes by devteam at 156b60c1530f**
* **bcftools call by iuc at 0fba2c15b40d**
* **bcftools view by iuc at d1f8f55f564d**
* **bcftools mpileup by iuc at 4e1d23e5c691**
* **regex_find_replace by jjohnson at 9ea374bb0350**
* **phyml by iuc at 850e213bee26**
* **collapse_collections by nml at 49bd84e136c7**
* **smalt by nml at 51ad86498414**



### Initial requirements

* Need to have user 'admin@localhost.com' listed for parameter 'admin_users' in config/tool_shed.ini.sample
* 'admin@localhost.com' is not created yet.
* ToolShed is currently running

### One script install


```bash

./scripts/full_install.sh http://localhost:9009
```

### Step 4: Install Packages to Galaxy

Once you have uploaded the packages to a Galaxy Tool Shed, you can install to a local version of Galaxy linked up to the Tool Shed by following the below steps.

1. Go to **Admin** and from here in the left panel find **Search and browse tool sheds**.
2. Find the Tool Shed where the tool is installed and click on **Browse valid repositories**.  From here find the particular tool you installed.
3. Click on the arrow next to the tool and click on **Preview and install**.
4. Wait for Galaxy to install your tool.

[Core Phylogenomis Pipeline]: https://snvphyl.readthedocs.io/en/latest/
[Galaxy Tool Shed]: https://wiki.galaxyproject.org/ToolShed
[Production Server Setup]: https://docs.galaxyproject.org/en/latest/admin/production.html
[IRIDA Galaxy Setup]: https://irida.corefacility.ca/documentation/administrator/galaxy/
[Automated Tool Tests]: https://wiki.galaxyproject.org/AutomatedToolTests
[Hosting a Local Tool Shed]: https://galaxyproject.org/toolshed/hosting-a-local-toolshed/
[Tool Testing Enhancements]: http://dev.list.galaxyproject.org/Tool-Testing-Enhancements-td4663799.html
