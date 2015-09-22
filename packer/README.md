---
layout: default
---

Building VMs with packer
========================

This guide describes how to set up your workstation to build VM images of Galaxy and SNVPhyl with [packer](https://packer.io).

General Requirements
--------------------

You're required to install a few different pieces of software on your machine before you can get started:

1. [packer](https://packer.io) (install guide: <https://packer.io/docs/installation.html>)
2. [VirtualBox](https://www.virtualbox.org) (install guide: <https://www.virtualbox.org/wiki/Linux_Downloads>)
3. [qemu](http://wiki.qemu.org/Main_Page).

Building the VM
---------------

You can build the VM once you've got the prerequisites installed.

You **cannot** build qemu and VirtualBox images in parallel, both qemu and VirtualBox want to use the same virtualization features of the processor and qemu clobbers VirtualBox. So you must run, from the `packer/` directory:

    packer build -parallel=false snvphyl-galaxy.json

If you want to run *only* one or the other, you can run something like:

    packer build -only=qemu snvphyl-galaxy.json

Or, for VirtualBox:

    packer build -only=virtualbox-iso snvphyl-galaxy.json

This will (for both VirtualBox and qemu):

1. Download a CentOS 7.1 ISO,
2. Run an automated CentOS kickstart script in VirtualBox (VirtualBox should pop up on your screen),
3. Install the VirtualBox tools,
4. Run the customization script, `galaxy.sh`, which will install the SNVPhyl dependency tools and load the SNVPhyl workflow in Galaxy,
5. Package the customized VirtualBox image as a VirtualBox appliance (found in `packer/output-virtualbox-iso`), and a qemu disk image (found in `packer/output-qemu`).

Using the VM
------------

You can import the `.ovf` file in `packer/output-virtualbox-iso` into VirtualBox by double clicking it, or running something like:

```bash
cd output-virtualbox-iso
xdg-open packer-virtualbox-iso*.ovf
```

### Ports

By default, the appliance is set up using NAT for networking. The appliance is configured to do port forwarding via `localhost` such that you can access Galaxy by navigating to <http://localhost:48888/>.  The default user account created in Galaxy is `admin@localhost.localdomain` with password `adminpassword`.

You can SSH into the virtual machine with:

```bash
ssh -p 42222 vagrant@localhost
```

The default password is `vagrant`.

### Galaxy Install Directory

Galaxy will be configured to run as the user `galaxy`, and is installed under `/home/galaxy/galaxy`.  You may view the Galaxy log file by running:

```bash
sudo tailf /home/galaxy/galaxy/paster.log
```
