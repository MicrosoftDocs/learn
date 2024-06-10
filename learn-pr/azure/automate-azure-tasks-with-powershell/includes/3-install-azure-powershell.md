<!-- markdownlint-disable MD041 -->

In this scenario, your administrators prefer executing scripts locally on their computers rather
than using Azure Cloud Shell. Since your team uses a mixture of Windows, Linux, and macOS, your task
is to ensure Azure PowerShell works seamlessly across all these devices. This empowers your
administrators to manage and automate the Azure infrastructure for your organization from their
preferred operating system on their local computers.

## What must be installed?

We'll review detailed installation instructions for some common platforms in the next unit, but
first, let's look at the two key components required for Azure PowerShell:

- **The PowerShell language**: The PowerShell language is available in two variants:
  - **PowerShell version 7**: This version can be installed on Windows, Linux, and macOS.
  - **Windows PowerShell 5.1**: This version is preinstalled and only runs on Windows.
- **The Az PowerShell module**: This module must be installed to add the Azure-specific commands to
  PowerShell.

> [!TIP] The latest stable version of PowerShell 7 is recommended for use with the **Az** PowerShell
> module on all platforms.

After installing the appropriate version of PowerShell, you can then install the **Az** PowerShell
module to start managing Azure resources.

## How to install PowerShell

To install PowerShell on all platforms, use a package manager. The recommended package manager
varies by operating system and distribution.

### Windows

On Windows, use the **Windows Package Manager (Winget)** to install the latest stable version of
PowerShell 7.

```powershell
winget install --id Microsoft.Powershell --source winget
```

### Linux

The package manager on Linux differs based on the distribution. PowerShell is available in the
Microsoft repository, which you must add to your package manager.

|          Distribution           |                Package manager                |
| ------------------------------- | --------------------------------------------- |
| Debian, Ubuntu                  | `apt-get`                                     |
| Red Hat Enterprise Linux (RHEL) | `dnf` or `yum` depending on your RHEL version |

To install PowerShell on supported versions of Ubuntu Linux, use the Advanced Packaging Tool (apt)
and the Bash command line:

```bash
sudo apt-get install -y powershell
```

### macOS

On macOS, use `Homebrew` to install PowerShell.

```powershell
brew install powershell/tap/powershell
```

## The Az PowerShell module

Azure PowerShell is the product name for the official Microsoft PowerShell module containing
commands for managing Azure resources.

The current iteration of the Azure PowerShell module for managing Azure resources is named **Az**.
It's the recommended PowerShell module for interacting with, managing, and automating Azure
resources with PowerShell. It includes thousands of commands to control almost every aspect of
Azure, such as resource groups, storage, virtual machines, containers, and machine learning. The
**Az** PowerShell module is open-source and cross-platform.

You might find examples on the internet that use the **AzureRM** PowerShell module, which is the
previous generation of Azure PowerShell. It's deprecated, no longer maintained or supported, and not
recommended. Commands in the **AzureRM** PowerShell module use the `*-AzureRM*` format.

You might also encounter an Azure PowerShell module named **Azure**, which is for managing legacy
Azure resources that use Azure Service Manager (ASM) APIs. The **Azure** PowerShell module isn't
recommended when creating new resources since ASM is scheduled to retire soon.

### How to install the Az PowerShell module

Install the **Az** PowerShell module from the PowerShell Gallery.

```powershell
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery
```

This process enables you to use the full range of Azure-specific cmdlets available in the **Az**
PowerShell module.
