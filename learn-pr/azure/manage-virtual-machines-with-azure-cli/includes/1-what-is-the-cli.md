It's quite common for IT departments to manage a large set of Azure resources, ranging from Azure Virtual Machines to managed websites.

While the Azure portal is easy to use for one-off tasks, navigating through the various panes adds time when you have to create, change, or delete multiple things. This is where the command line shines; you can issue commands quickly and efficiently, or even use scripts to run repetitive tasks. With Azure, you have two different command-line tools you can work with: Azure PowerShell and the Azure CLI.

With either of these tools, you can write scripts to check the cloud-server status, deploy new configurations, open ports in the firewall, or connect to a virtual machine to change a setting. Windows admins tend to prefer Azure PowerShell, while developers and Linux admins often use the Azure CLI.

This module focuses on using the Azure CLI to create and manage virtual machines hosted in Azure. If you'd like to get an overview of the Azure CLI, how to install it, and how to work with your Azure subscriptions, make sure to check out the [Control Azure services with the CLI](/training/modules/control-azure-services-with-cli/) training module.

## What is the Azure CLI?

The Azure CLI is Microsoft's cross-platform command-line tool for managing Azure resources. It's available for macOS, Linux, and Windows, or in the browser using [Azure Cloud Shell](/azure/cloud-shell/overview).

The Azure CLI can help you manage Azure resources such as virtual machines and disks from the command line or in scripts. Let's get started and see what it can do with Azure Virtual Machines.

## Learning objectives

In this module, you will:

- Create a virtual machine with the Azure CLI.
- Resize virtual machines with the Azure CLI.
- Perform basic management tasks using the Azure CLI.
- Connect to a running VM with SSH and the Azure CLI.

## Prerequisites

- Basic understanding of the Azure CLI tool from the [Control Azure services with the CLI](/training/modules/control-azure-services-with-cli/) module.
