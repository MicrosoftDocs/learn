In the past, your company's operations team was faced with the tasks of creating virtual machines for your public-facing web servers, and then manually installing and configuring the software that is necessary to create your company's web server infrastructure. In order to reduce the time that it takes to bring new virtual machines online and to reduce setup costs, your team wanted you to research how Azure could help you to improve your methodology for the installation and configuration of web server software.

In this module, you've seen some of the tools that are available on Azure to automate the creation of Linux and Windows virtual machines, with all of the required infrastructure that's necessary to host dynamic content on your web servers. Azure has helped you to simply your team's processes, and your team is more productive and efficient. Your team can deliver a great experience to your customers by guaranteeing their servers are UP and running, and configured correctly.

## Clean up resources

[!include[](../../../includes/azure-subscription-cleanup.md)]

To delete the resource group and all the resources that you created in this module, run the following command in the Cloud Shell.

```azurecli
az group delete --name my-resource-group-name
```

## Learn more

Here's where you can learn more about what you've done today:

- [Windows virtual machines in Azure](/azure/virtual-machines/windows/)
- [Tutorial – Deploy applications to a Windows virtual machine in Azure with the Custom Script Extension](/azure/virtual-machines/windows/tutorial-automate-vm-deployment)
- [Create a Linux virtual machine in Azure](/learn/modules/create-linux-virtual-machine-in-azure/)
- [Create a Windows virtual machine in Azure](/learn/modules/create-windows-virtual-machine-in-azure/)
- [Manage virtual machines with the Azure CLI](/learn/modules/manage-virtual-machines-with-azure-cli/)
- [Create, change, or delete a public IP address](/azure/virtual-network/virtual-network-public-ip-address)
- [Virtual Network documentation](/azure/virtual-network/)
- [Network security groups](/azure/virtual-network/security-overview)
- [Create and deploy highly available virtual machines with Azure PowerShell](/azure/virtual-machines/windows/tutorial-availability-sets)
- [Cloud-init Documentation](https://cloudinit.readthedocs.io/)

As an alternative to creating your virtual machines and automating the installation and configuration of your business components, you might consider creating virtual machines using Azure Resource Manager (ARM) templates. ARM templates a quick way to deploy the infrastructure that you need with a single Azure CLI or PowerShell command. You can create templates in two ways: you can create a template from an existing Azure deployment, or you can use a pre-built template from the Azure Quickstart Template gallery. For more information, see the following resources:

- [Azure Quickstart Templates gallery](https://azure.microsoft.com/resources/templates/)
- [Deploy Azure infrastructure by using JSON ARM templates](/learn/modules/create-azure-resource-manager-template-vs-code/)
- [Create a Windows virtual machine from a Resource Manager template](/azure/virtual-machines/windows/ps-template)
- [Virtual machines in an Azure Resource Manager template](/azure/virtual-machines/windows/template-description)