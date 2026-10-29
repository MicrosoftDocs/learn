Your company needs to launch new toys regularly to stay competitive. The shorter the time to market, the better.

You've created a file that deploys a website and storage resources. This file is reusable for future product launches, which means you've significantly cut the time it takes to launch a new product.

You created a Bicep file to deploy a basic storage account, an Azure App Service plan, and an application. You parameterized the file to make it useful for future products. You then refactored it into modules to make the file more reusable and easier to understand and work with. Finally, you added an output to send information from a file deployment back to the person or tool executing the deployment.

Imagine how much work it would be to deploy these resources for each new product launch. You'd have to manually provision the resources and remember to configure them correctly each time.

Bicep makes it easy to describe your Azure resources and create reusable files. You can parameterize the files and use modules to separate your files into different components that you can reuse and work on individually.

Now, when you want to prepare your resources for the next product launch, you can use the Bicep file you created with parameter values unique to the product launch. Your company can quickly and easily provision its Azure resources.

> [!TIP]
> In this module, you've only scratched the surface of Bicep's capabilities. Keep following the Fundamentals of Bicep learning path and our other Bicep learning paths to progress your understanding. You'll find the link in More info.

<!-- -->

> [!IMPORTANT]
> If you completed the optional exercises, you created resources by using your own Azure subscription. Clean up these resources so that you won't continue to be charged for them.
>
> Clean up resources from both the initial and parameterized exercises. If you created a resource group exclusively for this module and no longer need anything in it, delete that group. If you used an existing group, delete only the resources created for this exercise after checking their dependencies; don't delete unrelated resources.

## More info

Use these resources to review the module's concepts and explore the sources cited in the technical review.

### Tools and setup

Set up your subscription and tools, then access your Azure resources:

- [Azure trial subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep)
- [Install Azure CLI](/cli/azure/install-azure-cli)
- [Install Azure PowerShell](/powershell/azure/install-az-ps)
- [Install Bicep tools](/azure/azure-resource-manager/bicep/install), including [Bicep installation for Azure PowerShell](/azure/azure-resource-manager/bicep/install#azure-powershell)
- [Azure portal](https://portal.azure.com?azure-portal=true)

### Bicep language

Learn more about the language features used in this module:

- [Bicep documentation](/azure/azure-resource-manager/bicep)
- [Resource declarations](/azure/azure-resource-manager/bicep/resource-declaration) and [implicit resource dependencies](/azure/azure-resource-manager/bicep/resource-dependencies#implicit-dependency)
- [Parameter defaults and allowed values](/azure/azure-resource-manager/bicep/parameters) and [variables](/azure/azure-resource-manager/bicep/variables)
- [Bicep functions](/azure/azure-resource-manager/bicep/bicep-functions), [resource-ID functions](/azure/azure-resource-manager/bicep/bicep-functions-resource), and [`uniqueString()`](/azure/azure-resource-manager/bicep/bicep-functions-string#uniquestring)
- [Bicep modules](/azure/azure-resource-manager/bicep/modules#define-modules) and [local module paths](/azure/azure-resource-manager/bicep/modules#local-file)
- [Bicep outputs](/azure/azure-resource-manager/bicep/outputs), [defining outputs](/azure/azure-resource-manager/bicep/outputs#define-outputs), and [secure outputs](/azure/azure-resource-manager/bicep/outputs#secure-outputs)
- [Bicep 0.34.1 release notes](https://github.com/Azure/bicep/releases/tag/v0.34.1)

### Deployment and resource management

Review deployment behavior, resource naming, and configuration:

- [Azure CLI deployment guidance](/azure/azure-resource-manager/bicep/deploy-cli), [deploying a local Bicep file](/azure/azure-resource-manager/bicep/deploy-cli#deploy-local-bicep-file), and [deployment-name behavior](/azure/azure-resource-manager/bicep/deploy-cli#deployment-name)
- [Azure PowerShell deployment guidance](/azure/azure-resource-manager/bicep/deploy-powershell) and [inline parameters](/azure/azure-resource-manager/bicep/deploy-powershell#inline-parameters)
- [Deployment modes](/azure/azure-resource-manager/templates/deployment-modes) and [incremental deployment behavior](/azure/azure-resource-manager/templates/deployment-modes#incremental-mode)
- [Resource groups and their locations](/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group)
- [Manage resource groups with the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal) and [manage resource groups with Azure CLI](/azure/azure-resource-manager/management/manage-resource-groups-cli)
- [Resource naming rules](/azure/azure-resource-manager/management/resource-name-rules#microsoftweb)
- [Storage account types](/azure/storage/common/storage-account-overview#types-of-storage-accounts) and [storage account names](/azure/storage/common/storage-account-overview#storage-account-name)
- [Minimum TLS configuration for storage accounts](/azure/storage/common/transport-layer-security-configure-minimum-version)

### App Service and API references

Consult these references for hosting plans and resource schemas:

- [App Service hosting plans and pricing tiers](/azure/app-service/overview-hosting-plans#pricing-tiers)
- [PremiumV3 prerequisites](/azure/app-service/app-service-configure-premium-v3-tier) and [PremiumV3 redeployment guidance](/azure/app-service/app-service-configure-premium-v3-tier#scale-up-from-an-unsupported-resource-group-and-region-combination)
- [Windows App Service ARM template quickstart](/azure/app-service/quickstart-arm-template)
- [Template reference for each Azure resource type](/azure/templates/)
- [Storage account schema, API 2023-05-01](/azure/templates/microsoft.storage/2023-05-01/storageaccounts) and [storage account create contract](/rest/api/storagerp/storage-accounts/create?view=rest-storagerp-2023-05-01)
- [App Service plan schema, API 2023-12-01](/azure/templates/microsoft.web/2023-12-01/serverfarms) and [App Service app schema, API 2023-12-01](/azure/templates/microsoft.web/2023-12-01/sites)
- [App Service plan schema, API 2024-04-01](/azure/templates/microsoft.web/2024-04-01/serverfarms) and [App Service app schema, API 2024-04-01](/azure/templates/microsoft.web/2024-04-01/sites)

### Further learning

Continue learning or revisit the exercises and production guidance:

- [Fundamentals of Bicep learning path](xref:learn.bicep-deploy-manage)
- [Published exercise: Define resources in a Bicep file](/training/modules/build-first-bicep-file/4-exercise-define-resources-bicep-file)
- [Selecting SKUs for resources](/training/modules/build-first-bicep-file/5-add-flexibility-parameters-variables#selecting-skus-for-resources)
