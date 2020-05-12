In this module, you learned to identify and understand all the main parts of an Azure Resource Manager (ARM) template. Furthermore you have written from scratch your own ARM template added parameters, variables, resources, functions, and outputs to your template.

Resource Manager templates are composable. As you build out your deployments, you can write smaller templates that each define a piece of the system and then combine them to create a complete system.  this will be covered in an upcoming learn module.

As you build your library of Resource Manager templates, you'll be able to assemble deployments much more quickly and deploy them in a single Azure CLI command.

## Clean up
When you're working in your own subscription, it's a good idea at the end of a project to identify whether you still need the resources you created. Resources left running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of resources.

If you used our sandbox environment all the resources, you deployed will be deleted shortly.

## Learn more
A great way to learn is by doing. Try writing more Resource Manager templates that automate one of your deployments.

Refer to the [ARM template documentation](https://docs.microsoft.com/azure/azure-resource-manager/templates/)  to learn more about how to create, deploy, manage, audit, and troubleshoot your templates.

Here are some resources that can help you expand on what you learned in this module.

- [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates)
- [Azure Resource Manager Visualizer](http://armviz.io/)
- [ARM Template Visual Studio Code quickstart](https://docs.microsoft.com/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=CLI)

Here are some topics that we did not discuss here, but you might be interested in as you explore and build your own templates.

- [Use condition in Azure Resource Manager templates](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-tutorial-use-conditions)
- [Integrate Azure Key Vault in Resource Manager Template deployment](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-tutorial-use-key-vault
- [Create linked Azure Resource Manager templates](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-tutorial-create-linked-templates)
- [Best Practices For Using Azure Resource Manager Templates](https://blogs.msdn.microsoft.com/mvpawardprogram/2018/05/01/azure-resource-manager)
- [Troubleshoot common Azure deployment errors with Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-common-deployment-errors)
