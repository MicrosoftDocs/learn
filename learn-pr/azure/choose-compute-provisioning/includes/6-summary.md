Your organization needed to move several applications to Azure virtual machines. The company needed to be able to scale out to many virtual machines. Their manual process was time consuming and error prone. They wanted to automate the scale-out process to improve operational abilities. They were unsure of what tools were available on Azure to provision compute resource, and where each tool would fit into the overall provisioning process.

In this module, we looked at native Azure solutions, such as the virtual machine extensions (custom script and DSC extensions) and their purposes. We've also looked at non-native Azure solutions for provisioning and configuration. We learned how they can help us to automate manual processes and post deployment tasks. We identified the tools available for automation. We've learned how to decide between provisioning tools for specific scenarios. Each tool has its own advantages and disadvantages, and some tools can and should be used together. We used an Azure Resource Manager template together with a Desired State Configuration to deploy a webserver.

Without the provisioning tools, we wouldn't be able to automate provisioning. We wouldn't be able to easily configure an environment and deploy it with minimal effort. We also wouldn't be able to provision a webserver and automatically enforce a state on it.

With the help of the provisioning tools on Azure, we are able to improve the provisioning of compute resources for the organization. As a result, the organization can become more productive because repetitive tasks and mistakes are minimized. And the organization can become more cost-effective because it can more accurately provision resources.

## Learn more

- [Understand the structure and syntax of Azure Resource Manager templates](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-authoring-templates)
- [Introduction to the Azure Desired State Configuration extension handler](https://docs.microsoft.com/azure/virtual-machines/extensions/dsc-overview)
- [Chef Software on Azure documentation](https://docs.microsoft.com/azure/chef/)
- [Terraform on Azure documentation](https://docs.microsoft.com/azure/terraform/)

## Clean up resources

[!include[](../../../includes/azure-sandbox-cleanup.md)]
