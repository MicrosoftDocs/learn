<!-- markdownlint-disable MD041 -->

In our scenario, your administrators prefer executing scripts locally on their computers rather
than using Azure Cloud Shell. Since your team uses a mixture of Windows, Linux, and macOS, your task
is to ensure Azure CLI works across all these devices. Using a script empowers your
administrators to manage and automate the Azure infrastructure for your organization from their
preferred operating system on their local computers.

## What must be installed

The Azure CLI is made up of two types of reference command groups: core and extension.

* **Core:** Azure CLI references that are published as a permanent part of the CLI are called **core references**. All core references install with the Azure CLI and you can't choose a subset of references. If you run the CLI through Azure Cloud Shell, core references are always up to date.

* **Extensions:** Extensions aren't shipped as part of the CLI but run as CLI commands. Some extensions are a permanent part of the Azure CLI, but often, an extension gives you access to preview and experimental commands. A single reference group, such as `az iot`, can have both core and extension commands.

To execute Azure CLI commands, you need to install **core** references on your local computer, or run Azure Cloud Shell which has core references preinstalled. You're prompted to install extension references the first time you try to use an extension command.

## Where to install Azure CLI

The Azure CLI can be installed in several locations:

* Windows
* Linux
* macOS

The Azure CLI can also be run inside a Docker container.

You don't need to install the Azure CLI in Azure Cloud Shell because Core Azure CLI references are preinstalled.

## How to install Azure CLI

### Windows

There are four ways to install the Azure CLI in Windows:

* Microsoft Installer (MSI)
* Microsoft Installer (MSI) in PowerShell
* Windows package manager
* ZIP package

### Linux

Use a Linux distribution's package manager when installing Azure CLI in Linux.

* apt (Ubuntu, Debian)
* dnf (RHEL, CenOS Stream)
* tdnf (Azure Linux)
* zypper (open SUSE, SLES)

### macOS

On macOS, use `Homebrew` to install Azure CLI. If the **brew** command is unavailable, you might need to install the Homebrew package manager. For details, see the [Homebrew website](https://brew.sh/).

## How to run the Azure CLI

You can execute Azure CLI in your environment of choice.

* Linux Bash shell
* PowerShell 7
* Windows PowerShell
* Windows Cmd shell
* Azure Cloud Shell

It's important to be aware of environment syntax differences when deciding what environment to use. An Azure CLI script tested in PowerShell 7 might not execute in Windows PowerShell or Bash due to one or more of the following scripting differences:

* Line continuation characters
* Variables
* Random identifiers
* Quoting

As you onboard with Azure CLI, the [Learn Azure CLI syntax differences in Bash, PowerShell, and Cmd](/cli/azure/get-started-tutorial-2-environment-syntax?tabs=Bash) tutorial step can help you learn more.
