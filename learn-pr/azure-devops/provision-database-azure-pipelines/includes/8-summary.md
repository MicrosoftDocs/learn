Nice job! Your pipeline is developing into a very useful part of your process. You and the Tailspin team now have a pipeline that deploys your infrastructure by using an Azure Resource Manager template and a parameters file. The pipeline also builds the projects and deploys the web app. It includes consideration for database schema changes. 

In this module, you learned about what you need to consider when using a Resource Manager template to provision your infrastructure in Azure Pipelines.

You learned:

> [!div class="checklist"]
> * How to implement infrastructure as code by using Resource Manager templates.
> * How to design a Resource Manager template for Azure App Service and Azure SQL Database to use in Azure Pipelines.
> * How to use Azure Key Vault to store and retrieve secrets by using Resource Manager templates and Azure Pipelines.
> * What's needed to add a Resource Manager template to Azure Pipelines.

The team successfully designed and built a pipeline that manages the infrastructure, as well as the database changes for its deployment.

For learning purposes, in this module you provisioned a database for the website that's running in the _Dev_ environment. You can extend this configuration to deploy a unique database that's associated with other environments, such as _Test_, _Staging_, or _Production_.

## Learn more

There was quite a bit already in place at the beginning of this module. If you want to go back and get more background on what was done, check out these links:

- For discussion on approvals and triggers in Azure Pipelines, see [Create a multistage pipeline with Azure Pipelines](/learn/modules/create-multi-stage-pipeline/index?azure-portal=true).
- To understand how to manage database schema changes in Azure Pipelines, see [Manage database changes in Azure Pipelines](/learn/modules/manage-database-changes-in-azure-pipelines/?azure-portal=true).
- For information on Resource Manager templates, see [Build Azure Resource Manager templates](/learn/modules/build-azure-vm-templates/?azure-portal=true).

Here are additional resources that go into greater depth on other areas we covered in this module:

- [Quickstart template gallery](https://azure.microsoft.com/resources/templates?azure-portal=true)
- [Export the entire resource group as a template from the Azure portal](https://docs.microsoft.com/azure/azure-resource-manager/export-template-portal?azure-portal=true)
- [AzureResourceManagerTemplateDeployment@3](https://github.com/microsoft/azure-pipelines-tasks/blob/master/Tasks/AzureResourceManagerTemplateDeploymentV3/README.md?azure-portal=true)
- [AzureAppServiceSettings@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-app-service-settings?azure-portal=true)
- [AzureKeyVault@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-key-vault?azure-portal=true)
- [Best practices to use Key Vault](https://docs.microsoft.com/Azure/key-vault/key-vault-best-practices?azure-portal=true)
- [Install and run Azure CLI locally](https://docs.microsoft.com/cli/azure/install-azure-cli?azure-portal=true)
