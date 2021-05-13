As an IT administrator for an internal HR app, you need another way to remotely connect to and manage the app virtual machine (VM) without having to publicly expose the internal HR app or manage an additional VM.

Azure Bastion is a fully managed PaaS service that allows you to securely connect to your VMs over the internet without publicly exposing your VMs. After you provision Azure Bastion in your virtual network, the RDP or SSH experience is available to all your VMs in the same virtual network or peered network.

To deploy Azure Bastion, you create a subnet called AzureBastionSubnet on the virtual network and provision a public IP and the Azure Bastion resource.

You can use Azure Bastion to stream user session information to your storage account. You can also view current remote sessions and force-disconnect users from those sessions.

## Clean up

[!include[](../../../includes/azure-subscription-cleanup.md)]

## Learn more

- [Create an Azure Bastion host using Azure PowerShell](https://docs.microsoft.com/azure/bastion/bastion-create-host-powershell)
- [Create an Azure Bastion host using Azure CLI](https://docs.microsoft.com/azure/bastion/create-host-cli)