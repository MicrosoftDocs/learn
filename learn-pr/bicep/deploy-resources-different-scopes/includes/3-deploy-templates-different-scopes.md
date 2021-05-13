You now understand the different scopes that resources can be deployed at. In this unit, you'll learn how to start writing Bicep files that deploy at these scopes.

## Specify the target scope for a Bicep file

Bicep needs to know the scope at which a file will be deployed. This information is important because Bicep needs to ensure that the resources you're deploying are valid for the scope you're using. For example, the Bicep extension for Visual Studio Code warns you if you try to deploy a resource at an unsupported scope.

Use the `targetScope` keyword to tell Bicep that the resources in the file are for a specific scope. Here's an example of a Bicep file that will be deployed at the management group scope:

:::code language="plaintext" source="code/3-mg-scope.bicep" highlight="1" :::

Notice that you're just telling Bicep that this will be deployed into a management group - you're not specifying *which* management group. When you deploy the template, you'll tell Bicep exactly which management group you want to deploy the resources into. The Azure CLI and Azure PowerShell cmdlets have command-line arguments to specify this information.

If you don't specify the `targetScope`, Bicep assumes the file will be deployed to a resource group.

## Submit a deployment

::: zone pivot="cli"

When you initiate a deployment, you need to tell Azure which scope you want to deploy it at. This means there are different commands for each deployment scope. To deploy to a subscription, you must use the `az deployment sub create` command. For management group deployments, use the `az deployment mg` command. For tenant deployments, use `az deployment tenant create`.

::: zone-end

::: zone pivot="powershell"

When you initiate a deployment, you need to tell Azure which scope you want to deploy it at. This means there are different cmdlets for each deployment scope. To deploy to a subscription, you must use the `New-AzSubscriptionDeployment` cmdlet. For management group deployments, use the `New-AzManagementGroupDeployment` cmdlet. For tenant deployments, use `New-AzTenantDeployment` cmdlet.

::: zone-end

Azure stores metadata about each deployment. Unlike deployments to resource groups, there is some information you need to provide when you deploy at other scopes so that Azure can store the metadata correctly:

- **Location:** The deployment metadata has to be stored in a location that you specify. You don't need to provide a location for resource group scope deployments because resource groups are created in a location already, and that location is used for deployment metadata too. But, when you create a deployment at the subscription, management group, or tenant scope, you need to specify the Azure region that the deployment metadata will be stored in. This doesn't mean that the resources are created in that location.
- **Name:** All deployments in Azure have a name. You can ask Azure for information about a deployment by using its name. When you use the Azure CLI or Azure PowerShell to submit a deployment, you don't need to specify the name - but if you don't, the filename of the template file will be used as the deployment name.

The combination of the location and name must be unique. For example, if you create a deployment named `my-deployment` and use the East US location to store its metadata, you can't then create another deployment named `my-deployment` in West Europe.
