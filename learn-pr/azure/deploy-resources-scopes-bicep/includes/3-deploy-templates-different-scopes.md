You now understand the various scopes at which you can deploy resources. In this unit, you learn how to start writing Bicep files to deploy at these scopes.

## Specify the target scope for a Bicep file

Bicep needs to know the scope at which a file is deployed. This information is important because Bicep needs to ensure that the resources you're deploying are valid for the scope you're using. For example, the Bicep extension for Visual Studio Code warns you if you try to define a resource at an unsupported scope.

Use the `targetScope` keyword to tell Bicep that the resources in the file are for a specific scope. Here's an example of a Bicep file that deploys resources at the management group scope:

:::code language="bicep" source="code/3-mg-scope.bicep" highlight="1" :::

Notice that you're telling Bicep to deploy the resources at the scope of a management group, but you're not specifying *which* management group. When you deploy the template, you tell Bicep exactly which management group you want to deploy the resources to. The Azure CLI and Azure PowerShell cmdlets provide arguments to specify this information.

You can set the `targetScope` for your file to `resourceGroup`, `subscription`, `managementGroup`, or `tenant`. If you don't specify a target scope, Bicep assumes the `resourceGroup` scope.

## Create resource groups

Now that you understand how to create deployments at various scopes, try applying this understanding to creating a resource group, which is a subscription-scoped resource:

:::code language="bicep" source="code/3-create-rg.bicep" highlight="1" :::

In this example, notice that the Bicep file has a `targetScope` of `subscription`, which means that Bicep considers all the resources in the file to be subscription-scoped by default.

> [!NOTE]
> You'll see how to use Bicep to create Azure subscriptions and management groups later in this module.

## Submit a deployment

::: zone pivot="cli"

When you initiate a deployment, you need to tell Azure at which scope you want to deploy it. This means that you use a different Azure CLI command for each deployment scope, as shown here:

| To deploy at this scope: | Run this Azure CLI command: |
|-|-|
| Resource group | `az deployment group create` |
| Subscription | `az deployment sub create` |
| Management group | `az deployment mg create` |
| Tenant | `az deployment tenant create` |
| | |

::: zone-end

::: zone pivot="powershell"

When you initiate a deployment, you need to tell Azure at which scope you want to deploy it. This means that you use a different PowerShell cmdlet for each deployment scope, as shown here:

| To deploy at this scope: | Use this PowerShell cmdlet: |
|-|-|
| Resource group | `New-AzResourceGroupDeployment` |
| Subscription | `New-AzSubscriptionDeployment` |
| Management group | `New-AzManagementGroupDeployment` |
| Tenant | `New-AzTenantDeployment` |

::: zone-end

Azure stores metadata about each deployment. Unlike deployments at the resource group scope, there's some information you need to provide when you deploy at other scopes so that Azure can store the metadata correctly:

- **Location**: The deployment metadata has to be stored in a location that you specify. You don't need to specify a location for resource group scope deployments, because the deployment metadata uses the same location as the resource group. However, when you create a deployment at the subscription, management group, or tenant scope, you need to specify the Azure region that the deployment metadata is stored in. The resources for your deployment in these scopes aren't always created in the same location that you specified for the metadata.

- **Name**: All deployments in Azure have a name. You can ask Azure for information about a deployment by using its name. When you use the Azure CLI or Azure PowerShell to submit a deployment, you don't need to specify the name. But if you don't, the template file's filename is used as the deployment name.

The combination of the deployment's scope, location, and name must be unique. For example, let's say you create a subscription deployment named `my-deployment` and use the East US location to store its metadata. You can't create another deployment to the same subscription also named `my-deployment`, even if it's in a different location like West Europe. If you do create another deployment named `my-deployment` in East US, it overwrites the existing deployment.
