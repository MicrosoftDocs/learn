You now understand the various scopes that resources can be deployed at. In this unit, you learn how to start writing Bicep files to deploy at these scopes.

## Specify the target scope for a Bicep file

Bicep needs to know the scope at which a file will be deployed. This information is important because Bicep needs to ensure that the resources you're deploying are valid for the scope you're using. For example, the Bicep extension for Visual Studio Code warns you if you try to define a resource at an unsupported scope.

Use the `targetScope` keyword to tell Bicep that the resources in the file are for a specific scope. Here's an example of a Bicep file that will be deployed at the management group scope:

:::code language="bicep" source="code/3-mg-scope.bicep" highlight="1" :::

Notice that you're telling Bicep that the resources will be deployed at the scope of a management group, but you're not specifying *which* management group. When you deploy the template, you tell Bicep exactly which management group you want to deploy the resources to. The Azure CLI and Azure PowerShell cmdlets provide arguments to specify this information.

You can set the `targetScope` to `resourceGroup`, `subscription`, `managementGroup`, or `tenant`. If you don't specify it, Bicep assumes that the file will be deployed to a resource group.

## Create resource groups

Now that you understand how to create deployments at various scopes, try applying this understanding to creating a resource group, which is a subscription-scoped resource:

:::code language="bicep" source="code/3-create-rg.bicep" highlight="1" :::

In this example, notice that the Bicep file has a `targetScope` of `subscription`, which means that Bicep will consider all the resources in the file to be subscription-scoped by default.

> [!NOTE]
> You'll see how to use Bicep to create Azure subscriptions and management groups later in this module.

## Submit a deployment

::: zone pivot="cli"

When you initiate a deployment, you need to tell Azure which scope you want to deploy it at. This means that you use a different Azure CLI command for each deployment scope, as shown here:

| To deploy at this scope: | Run this Azure CLI command: |
|-|-|
| Resource group | `az deployment group create` |
| Subscription | `az deployment sub create` |
| Management group | `az deployment mg create` |
| Tenant | `az deployment tenant create` |
| | |

::: zone-end

::: zone pivot="powershell"

When you initiate a deployment, you need to tell Azure which scope you want to deploy it at. This means that you use a different PowerShell cmdlet for each deployment scope, as shown here:

| To deploy at this scope: | Use this PowerShell cmdlet: |
|-|-|
| Resource group | `New-AzResourceGroupDeployment` |
| Subscription | `New-AzSubscriptionDeployment` |
| Management group | `New-AzManagementGroupDeployment` |
| Tenant | `New-AzTenantDeployment` |
| | |

::: zone-end

Azure stores metadata about each deployment. Unlike deployments at the resource group scope, there is some information you need to provide when you deploy at other scopes so that Azure can store the metadata correctly:

- **Location**: The deployment metadata has to be stored in a location that you specify. You don't specify a location for resource group scope deployments, because resource groups are created in a location already and that location is used for its deployment metadata. But when you create a deployment at the subscription, management group, or tenant scope, you need to specify the Azure region that the deployment metadata will be stored in. This doesn't mean that the resources will be created in that location though.

- **Name**: All deployments in Azure have a name. You can ask Azure for information about a deployment by using its name. When you use the Azure CLI or Azure PowerShell to submit a deployment, you don't need to specify the name, but if you don't, the filename of the template file will be used as the deployment name.

The combination of the deployment's scope, location, and name must be unique. For example, if you create a subscription deployment named `my-deployment` and use the East US location to store its metadata, you can't then create another deployment to the same subscription also named `my-deployment`, but put it in West Europe. However, you can create another deployment named `my-deployment` in East US, and it will overwrite the older deployment.
