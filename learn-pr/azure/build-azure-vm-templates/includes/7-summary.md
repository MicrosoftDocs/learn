In this module, you defined what Azure Resource Manager means and what's in a Resource Manager template.

Resource Manager templates are _declarative_, meaning that you define _what_ resources you need and let Resource Manager handle the deployment details.

You used an existing Azure Quickstart template to deploy a VM. Quickstart templates are a great way to jump-start your deployments. They also demonstrate recommended practices you can learn from as you author your own templates.

You also extended your Quickstart template to configure web server software on your VM. Extending an existing template is a great way to get something running quickly and understand how the pieces fit together.

Resource Manager templates are also _composable_. As you build out your deployments, you can write smaller templates that each define a piece of the system and then combine them to create a complete system.

Think about the analysts you support at your financial services company. As you build your library of Resource Manager templates, you'll be able to assemble deployments for each analyst much more quickly. After each financial model completes, you need to run only a single Azure CLI command to tear down the deployment.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

A great way to learn is by doing. Try writing a Resource Manager template that automates one of your deployments.

Refer to the [Resource Manager on Azure documentation](https://docs.microsoft.com/azure/azure-resource-manager?azure-portal=true) to learn more about how to create, deploy, manage, audit, and troubleshoot your templates.

Here are some resources that go into more detail on what you learned in this module.

* [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates?azure-portal=true)
* [Azure Resource Manager Visualizer](http://armviz.io?azure-portal=true)
* [Deploy a simple Windows VM](https://azure.microsoft.com/resources/templates/101-vm-simple-windows?azure-portal=true)
* [Deploy a simple Ubuntu Linux VM](https://azure.microsoft.com/resources/templates/101-vm-simple-linux?azure-portal=true)

Here are some topics that we did not discuss here, but you might be interested in as you explore and build your own templates.

* [Manage access using RBAC and Azure Resource Manager templates](https://docs.microsoft.com/azure/role-based-access-control/role-assignments-template?azure-portal=true)
* [Use condition in Azure Resource Manager templates](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-tutorial-use-conditions?azure-portal=true)
* [Integrate Azure Key Vault in Resource Manager Template deployment](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-tutorial-use-key-vault?azure-portal=true)
* [Create linked Azure Resource Manager templates](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-tutorial-create-linked-templates?azure-portal=true)
* [Best Practices For Using Azure Resource Manager Templates](https://blogs.msdn.microsoft.com/mvpawardprogram/2018/05/01/azure-resource-manager?azure-portal=true)
* [Troubleshoot common Azure deployment errors with Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-common-deployment-errors?azure-portal=true)

