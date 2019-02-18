You can configure and manage Azure using a broad range of tools and platforms. There are tools available for the command line, language-specific Software Development Kits (SDKs), developer tools, tools for migration, and many others. 

Tools that are commonly used for day-to-day management and interaction include: 

- **Azure portal** for interacting with Azure via a Graphical User Interface (GUI)
- **Azure PowerShell** and **Azure Command-Line Interface** (CLI) for command line and automation-based interactions with Azure
- **Azure Cloud Shell** for a web-based command-line interface

Creating administration scripts and using automation tools is a powerful way to optimize your workflow. You can automate repetitive tasks, and once a script has been verified, it will run consistently, thereby reducing errors.

## Azure portal

The Azure portal is a website that you can access with a web browser, by going to the URL [https://portal.azure.com](https://portal.azure.com). From here, you can interact manually with all the Azure services. You can identify a service you're looking for, get links for help and more learning on particular topics, and deploy, manage, and delete resources. It also guides you through complex administrative tasks using wizards and tooltips.

The dashboard view provides high-level details about your Azure environment. You can customize the portal look as necessary by moving and resizing tiles, displaying particular services of interest, accessing links for help and support, and providing feedback.

The portal does not provide any way to automate repetitive tasks. For example, to set up multiple VMs, you would need to create them one at a time by completing the wizard for each VM. This makes the portal approach time-consuming and error-prone for complex tasks.
 
 ## Azure PowerShell

Azure PowerShell is a module that you add to Windows PowerShell or PowerShell Core that enables you to connect to your Azure subscription and manage resources. Azure PowerShell requires Windows PowerShell to function. PowerShell provides services such as the shell window and command parsing. Azure PowerShell then adds the Azure-specific commands.

For example, Azure PowerShell provides the `New-AzureRmVM` command that creates a virtual machine for you inside your Azure subscription. To use it, you would launch PowerShell, sign in to your Azure account using the command `Connect-AzureRMAccount`, and then issue a command such as:

```powershell
New-AzureRmVm `
    -ResourceGroupName "MyResourceGroup" `
    -Name "TestVm" `
    -Image "UbuntuLTS"
    ...
```
> [!NOTE]
> PowerShell Core is a cross-platform version of PowerShell that runs on Windows, Linux or macOS.

## Azure CLI

Azure CLI is a cross-platform command-line program that connects to Azure and executes administrative commands on Azure resources. *Cross-platform* means that it can be run on Windows, Linux, or macOS. For example, to create a VM, you would open a command prompt window, sign in to Azure using the command `az login`, create a resource group, then use a command such as:

```azurecli
az vm create \
  --resource-group MyResourceGroup \
  --name TestVm \
  --image UbuntuLTS
  --generate-ssh-keys
  ...
```

## Azure Cloud Shell

Azure Cloud Shell is a browser-based scripting environment in your portal. It provides the flexibility of choosing the shell experience that best suits the way you work. Linux users can opt for a Bash experience, while Windows users can opt for PowerShell.

An Azure storage account is required to use the cloud shell, and you will be prompted to create one when accessing the Azure cloud shell.

In Microsoft Learn, we will use the Cloud Shell for many of the interactive exercises you will use to try out Azure features.

> [!NOTE] 
> You can access Azure Cloud Shell by going to [https://shell.azure.com/](https://shell.azure.com/).

## Other options

There are also Azure SDKs for a range of languages and frameworks, as well as REST APIs that you can use to manage and control Azure resources programmatically. For a full list of tools available, see the [Downloads](https://azure.microsoft.com/en-us/downloads/) page.

When starting with Azure, you will most often use the Azure portal. Let's take a closer look at the portal approach.