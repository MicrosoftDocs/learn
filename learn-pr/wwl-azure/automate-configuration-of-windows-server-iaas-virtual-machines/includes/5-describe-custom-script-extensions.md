

Custom Script Extension is primarily used for post deployment configuration and software installation. With it, you can download and run scripts in Azure VMs. The scripts can be run using Resource Manager templates, Azure Command-Line Interface (Azure CLI), REST API, PowerShell, or the Azure portal. You can download script files from Azure storage or GitHub, or you can provide the scripts to the Azure portal at run time.

> [!NOTE]
> You can also run the Bash script in Linux machines.

The scripts are primarily useful for post deployment configuration, software installation, and other configuration or management tasks.

> [!TIP]
> To use Custom Script Extension on a VM, you must add the extension to that VM. You can do that from the **Extensions** blade of the appropriate VM.

## Requirements

To use custom script extensions for Windows, you must be running one of the supported Windows operating systems:

- Windows Server 2008 R2
- Windows Server 2012
- Windows Server 2012 R2
- Windows 10
- Windows Server 2016
- Windows Server 2016 Core
- Windows Server 2019
- Windows Server 2019 Core

## Script location

You can configure Custom Script Extension to use your Azure Blob storage credentials to access Azure Blob storage. You can store the script anywhere (for example, GitHub or an internal file server), providing the VM can access that end point.

## Internet connectivity

If you store a script for download externally (for example, in GitHub or Azure Storage), then you must open additional firewall and Network Security Group (NSG) ports. For example, if you store your script in Azure Storage, you can allow access by using Azure NSG Service Tags for Storage.

> [!NOTE]
> Even if your script is on a local server, you might still need to open additional firewall and NSG ports.

## Additional reading

To learn more, review the following documents:

- [Custom Script Extension for Windows](https://aka.ms/custom-script-windows?azure-portal=true).
- [Tutorial - Deploy applications to a Windows virtual machine in Azure with the Custom Script Extension](https://aka.ms/tutorial-automate-vm-deployment?azure-portal=true).
