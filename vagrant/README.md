SNVPhyl/Galaxy Vagrant Virtual Machine
======================================

This directory contains a `Vagrantfile` which can be used by [Vagrant][] for launching a virtual machine with SNVPhyl and Galaxy installed.

Dependencies
============

These instructions assume you have the following software installed:

* [Vagrant][]
* [VirtualBox][]

On Ubuntu, these can be installed with:

```bash
apt-get install virtualbox vagrant
```

Usage
=====

To launch a virtual machine with SNVPhyl and Galaxy, please run:

```bash
git clone http://irida.corefacility.ca/gitlab/analysis-pipelines/snvphyl-tools.git
cd snvphyl-galaxy/vagrant
vagrant up
```

This will download the virtual machine, import to VirtualBox, and boot up the machine.

Once started, you can log into Galaxy by going to <http://localhost:48888>.  The user account is `admin@localhost.localdomain` with password `adminpassword`.  Once logged in, the SNVPhyl workflows are stored under **Workflow**.

To shutdown the machine, please run (from the host machine):

```bash
vagrant halt
```

To delete the machine, please run:

```
vagrant destroy
```

You can also ssh into the machine with:

```bash
vagrant ssh
```

Galaxy log files can be monitored with:

```bash
tail -f /opt/galaxy/galaxy/paster.log
```

Building a new Virtual Machine
==============================

To build a new virtual machine, please refer to the [SNVPhyl Packer][] documentation.

[Vagrant]: https://www.vagrantup.com/
[VirtualBox]: https://www.virtualbox.org/
[SNVPhyl Packer]: ../packer
