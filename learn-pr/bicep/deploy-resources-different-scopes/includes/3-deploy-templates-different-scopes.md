You now understand the different scopes that resources can be deployed at. In this unit, you'll learn how to start writing Bicep files that deploy at these scopes.

## Specify the target scope for a Bicep file

Bicep needs to know the scope at which a file will be deployed. This information is important because Bicep needs to ensure that the resources you're deploying are valid for the scope you're using. You use the `targetScope` keyword to do tell Bicep that the resources in the template are for a specific scope. Here's an example of a Bicep file that will be deployed at the management group scope:

:::code language="plaintext" source="code/3-mg-scope.bicep" highlight="1" :::

Notice that you are just telling Bicep that this will be deployed into a management group - you're not specifying *which* management group. When you deploy the template, you'll tell Bicep exactly which management group you want to deploy the resources into.

If you don't specify the `targetScope`, Bicep will assume the file is deploying to a resource group.

## Start the deployment

::: zone pivot="cli"

When you initiate a deployment, you need to tell Azure which scope you want to deploy it at. To deploy to a subscription, you must use the `az deployment sub create` command. For management group deployments, use the `az deployment mg` command. For tenant deployments, use `az deployment tenant create`.

::: zone-end

::: zone pivot="powershell"

When you initiate a deployment, you need to tell Azure which scope you want to deploy it at. To deploy to a subscription, you must use the `New-AzSubscriptionDeployment` cmdlet. For management group deployments, use the `New-AzManagementGroupDeployment` cmdlet. For tenant deployments, use `New-AzTenantDeployment` cmdlet.

::: zone-end

Azure stores information about each deployment. It uses two key pieces of information when storing the deployment metadata: location and name. Unlike deployments to resource groups, there are some information you need to provide when you deploy at other scopes so that Azure can store the metadata correctly.

- **Location:** The deployment metadata has to be stored in a location that you specify. When you create a deployment at one of these scopes, you need to specify the location that the deployment metadata is stored in. This doesn't mean that the resources are created in that location.
- **Name:** All deployments in Azure have a name. You can ask Azure for information about a deployment by using its name. When you use the Azure CLI or Azure PowerShell to start a deployment, you don't need to specify the name - but if you don't, the filename of the template file will be used as the deployment name.

The combination of the location and name must be unique. For example, if you create a deployment named `my-deployment` and use the East US location to store its metadata, you can't then create another deployment named `my-deployment` in West Europe.
