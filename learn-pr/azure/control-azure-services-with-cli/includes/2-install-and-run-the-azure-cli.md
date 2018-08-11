## Motivation
Suppose your company has chosen Azure CLI as your command-line solution for managing Azure resources. Your administrators and developers prefer to run their commands and scripts locally rather than through a browser. The team uses machines that run Linux, macOS, and Windows. You need to get Azure CLI working on all their devices.

## What is the Azure CLI?
The Azure CLI (Command Line Interface) is a command-line program to connect to Azure and execute administrative commands on Azure resources. For example, to restart a Virtual Machine (VM), you would use a command like the following:

 ```bash
 az vm restart -g MyResourceGroup -n MyVm
 ```

The Azure CLI provides cross-platform command line tools for managing Azure resources, and can be installed locally on Linux, Mac, or Windows computers; the Azure CLI can also be used from a browser through the Azure Cloud Shell. In both cases, it can be used interactively or scripted. For interactive use, you first launch a shell such as cmd.exe on Windows or Bash on Linux or macOS and then issue the command at the shell prompt. To automate repetitive tasks, you assemble the CLI commands into a shell script using the script syntax of your chosen shell and then execute the script.

## How to install Azure CLI
On both Linux and macOS, you use a package manager to install PowerShell Core. The recommended package manager differs by OS and distribution:
- Linux: **apt-get** on Ubuntu, **yum** on Red Hat, and **zypper** on OpenSUSE
- Mac: **Homebrew**

Azure CLI is available in the Microsoft repository, so you'll first need to add that repository to your package manager.

On Windows, you install Azure CLI by downloading and running an MSI file.

## Using the Azure CLI in scripts
If you want to use Azure CLI commands in scripts, you need to be aware of any issues around the "shell" or environment used for running the script. For example, in a bash shell, the following syntax is used when setting variables:

 ```bash
 variable="string"
 variable=integer
 ```

If you use a PowerShell environment for running Azure CLI scripts, you'll need to use this syntax for variables:

 ```powershell
 $variable="string"
 $variable=integer
 ```

## Summary
The Azure CLI must be installed before it can be used to manage Azure resources from a local computer. THe installation steps vary for Windows, Linux and macOS, but once installed, the commands are common across platforms. In the next unit, you will go through the detailed installation steps for some common platforms.
