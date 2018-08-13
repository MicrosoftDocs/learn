Jim manages a set of Azure Virtual Machines running on our corporate web infrastructure that includes several websites and database servers running on various platforms. 

While the Azure portal is easy to use, Jim has found that navigating through the various blades adds time to some of the tasks. 

While exploring alternatives, he discovers the Azure Command Line Interface (CLI) tool.

Working with the Azure CLI, Jim write scripts to check the status of his servers, deploy a new configuration, open a port, or connect to a virtual machine to change a setting.

Perhaps you are like Jim and are looking for a tool to help automate tasks in your cloud environment. We're going to show you how to use the Azure CLI to create, and manage virtual machines hosted in Azure. 

## Azure CLI

The Azure CLI is Microsoft's cross-platform command line tool for managing Azure resources. It's available for macOS, Linux, and Windows, or in the browser using the [Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview).

> [!IMPORTANT]
> There are two versions of the Azure CLI tool available today: Azure CLI 1.0 and Azure CLI 2.0. We'll be using Azure CLI 2.0 which is the latest version and is recommended unless you you're running legacy scripts written for 1.0. Azure CLI 1.0 is started using the `azure` command, and Azure CLI 2.0 is started with the `az` command. 

The Azure CLI can help you manage Azure resources such as virtual machines and disks from the command line or in scripts. Let's get started and see what it can do.