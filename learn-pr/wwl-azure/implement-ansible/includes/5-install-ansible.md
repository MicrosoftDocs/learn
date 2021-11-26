To enable a machine to act as the control machine from which to run playbooks, you need to install Python and Ansible.

## Python

You can choose to install Python 2 (version 2.7) or Python 3 (versions 3.5 and later) when you install Python.

You can use pip, the Python package manager, to install Python, or you can use other installation methods.

## Ansible installation characteristics

An Ansible installation has the following characteristics:

 -  You only need to install Ansible on one machine, which could be a workstation or a laptop. You can manage an entire fleet of remote machines from that central point.
 -  No database is installed as part of the Ansible setup.
 -  No daemons are required to start or keep Ansible running.

## Ansible on Linux

You can install Ansible on many different distributions of Linux, including, but not limited to:

 -  Red Hat Enterprise Linux
 -  CentOS
 -  Debian
 -  Ubuntu
 -  Fedora

> [!NOTE]
> Fedora isn't supported as a validated Linux distribution on Azure. However, you can run it on Azure by uploading your image. All other Linux distributions are supported on Azure as recommended by Linux.

You can use the appropriate package manager software to install Ansible and Python, such as `yum`, `apt`, or `pip`. For example, to install Ansible on Ubuntu, run the following command:

```Bash
## Install pre-requisite packages
sudo apt-get update && sudo apt-get install -y libssl-dev libffi-dev python-dev python-pip
## Install Ansible and Azure SDKs via pip
sudo pip install Ansible [azure]

```

## macOS

You can also install Ansible and Python on macOS and use that environment as the control machine.

## Windows operating system

You can't install Ansible on the Windows operating system. However, you can run playbooks from Windows by using other products and services. You can install Ansible and Python on operating systems such as:

 -  Windows Subsystem for Linux. It's an Ubuntu Linux environment available as part of Windows.
 -  Azure Cloud Shell. You can use Azure Cloud Shell via a web browser on a Windows machine.
 -  Microsoft Visual Studio Code. Using Visual Studio Code, choose one of the following options:
    
     -  Run Ansible playbook in Docker.
     -  Run Ansible playbook on local Ansible.
     -  Run Ansible playbook in Azure Cloud Shell.
     -  Run Ansible playbook remotely via SSH.

## Upgrading Ansible

When Ansible manages remote machines, it doesn't leave software installed or running on them. So, there’s no real question about how to upgrade Ansible when moving to a new version.

## Managed nodes

When managing nodes, you need to communicate on the managed nodes or environments, usually using SSH by default. It uses the SSH file transfer protocol. If that’s not available, you can switch to Simple Control Protocol (SCP), which you can do in **Ansible.cfg**. For Windows machines, use Windows PowerShell.

You can find out more about installing Ansible on the [Install Ansible on Azure virtual machines](/azure/virtual-machines/linux/ansible-install-configure) page.
