Jim manages a set of Azure Virtual Machines running our corporate web infrastructure that includes several websites and database servers running on various platforms. 

While the Azure portal is easy to use, Jim has found that it slows him down having to navigate through the various blades to do tasks. While exploring alternatives, Jim ran across the Azure Command Line Interface (CLI) tool.

Jim quickly realized that the CLI was exactly what he needed to save time with repetitive tasks. With the Azure CLI, Jim could use scripts to check the status of his servers, try a new configuration, or connect to a virtual machine to change a setting.

Perhaps you are like Jim and using a CLI is exactly what you are looking for. We're going to show you in this module how you can use the Azure CLI to create and manage a virtual machine. 

## Azure CLI

The Azure CLI is Microsoft's cross-platform command line tool for managing Azure resources. It's available for macOS, Linux, and Windows, or in the browser using the [Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview).

> [!IMPORTANT]
> There are two versions of the Azure CLI tool available today. Azure CLI 1.0 is run using the `azure` command, and Azure CLI 2.0 with the `az` command. This module only covers the Azure 2.0 tool which is the latest version available.

With the Azure CLI, you can easily manage Azure resources such as virtual machines and disks from the command line or in scripts. Let's dive in and check out what it can do.