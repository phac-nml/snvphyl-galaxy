VirtualBox
==========

A [VirtualBox][] virtual machine is provided for running SNVPhyl along with Galaxy.  This machine requires at least **4 GB** of memory and **4 CPUs** to properly run.  The machine can be quickly launched using [Vagrant][] with the following commands.

```bash
git clone https://irida.corefacility.ca/gitlab/analysis-pipelines/snvphyl-galaxy
cd snvphyl-galaxy/vagrant
vagrant up
```

Running `vagrant up` will download and launch the virtual machine.  Galaxy can be accessed by navigating to <http://localhost:48888>.  The default username and passwords are:

* **User:** *admin@localhost.localdomain*
* **Password:** *adminpassword*

Once logged in, the workflows for SNVPhyl can be accessed by clicking on **Workflow** at the top.

Accessing the Virtual Machine
-----------------------------

SSH access to the machine is provided by running:

```
vagrant ssh
```

Or, alternatively, by running:

```
ssh -p 2222 vagrant@localhost
```

The **vagrant** user has a password of **vagrant** and is configured for `sudo` access.  The Galaxy installation directory is **/opt/galaxy** and log files can be monitored by running `tail -f /opt/galaxy/galaxy/paster.log`.

Managing the Virtual Machine
----------------------------

The virtual machine can be shutdown by running (from the host machine):

```
vagrant halt
```

The virtual machine instance can be deleted by running:

```
vagrant destroy
```

VirtualBox Import
-----------------

As an alternative to [Vagrant][], a [VirtualBox][] image can be downloaded and imported from <https://irida.corefacility.ca/downloads/snvphyl-galaxy/snvphyl-galaxy.zip>.

Building Custom Virtual Machines
--------------------------------

The SNVPhyl Galaxy VM is built using [Packer][].  This can be customized or re-built by following the instructions at <https://irida.corefacility.ca/gitlab/analysis-pipelines/snvphyl-galaxy/tree/feature/packer-vm/packer>.

[VirtualBox]: https://www.virtualbox.org/
[Vagrant]:  https://www.vagrantup.com/
[Packer]: https://packer.io/
