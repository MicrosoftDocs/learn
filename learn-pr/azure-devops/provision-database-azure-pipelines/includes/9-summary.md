Nice job! Your pipeline is developing into a very useful part of your process. You and the Tailspin team now have a pipeline that deploys your infrastructure using an Azure Resource Manager template and a parameters file in addition to building the projects and deploying the webapp. It also includes consideration for database schema changes. 

In this module, you learned about what you need to consider when using an Azure Resource Manager template to provision your infrastructure in Azure Pipelines.

You learned:

> [!div class="checklist"]
> * How to implement Infrastructure as Code using Azure Resource Manager templates
> * How to design an Azure Resource Manager template for an Azure App Service and Azure SQL Database to use in Azure Pipelines.
> * How to use Azure Key Vault to store and retrieve secrets using Azure Resource Manager templates and Azure Pipelines.
> * What is needed to add an Azure Resource Manager template to Azure Pipelines.

The team successfully designed and built a pipeline that manages the infrastructure as well as the database changes of their webapp deployment.

## Learn more

There was quite a bit already in place at the beginning of this module. If you want to go back and get more background on what was done, check out these links:

For discussion on approvals and triggers in Azure Pipelines see [Create a multi-stage pipeline with Azure Pipelines](https://docs.microsoft.com/learn/modules/create-multi-stage-pipeline/index?azure-portal=true).

To understand managing the database schema changes in Azure Pipelines see [Manage database changes in Azure Pipelines](/learn/modules/manage-database-changes-in-azure-pipelines/azure-pipelines=true)

For information on Azure Resource Manager templates see [Build Azure Resource Manager templates](https://docs.microsoft.com/learn/modules/build-azure-vm-templates/?azure-portal=true).

Some other resources mentioned in the module:

- [Quickstart template gallery](https://azure.microsoft.com/resources/templates?azure-portal=true)
- [Export the entire resource group as a template from the Azure portal](https://docs.microsoft.com/azure/azure-resource-manager/export-template-portal?azure-portal=true)
- [AzureResourceManagerTemplateDeployment@3](https://github.com/microsoft/azure-pipelines-tasks/blob/master/Tasks/AzureResourceManagerTemplateDeploymentV3/README.md?azire-pipelines=true)
- [AzureAppServiceSettings@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-app-service-settings?view=azure-devops&azure-portal=true)
- [AzureKeyVault@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-key-vault?view=azure-devops&azure-poral=true)
- [Install and run Azure CLI locally](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true)
