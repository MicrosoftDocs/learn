TODO intro

## Specify the target scope

Bicep needs to know the scope at which a file will be deployed. This information is important because Bicep needs to validate that the resources you're deploying are valid for the scope you're using. You use the `targetScope` keyword to do this. Here's an example of a Bicep file that will be deployed at the management group scope:

```bicep
targetScope = 'managementGroup'

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  // ...
}
```

When you deploy the template, you'll tell Bicep exactly which management group you want to deploy this into.


- The `tenant()`, `managementGroup()`, `subscription()`, and `resourceGroup()` functions

## Deploy the template

TODO zones

When you initiate a deployment, you need to tell Azure which scope you want to deploy it atl. To deploy to a subscription, you must use the `az deployment sub create` command. For management group deployments, use the `az deployment mg` command. For tenant deployments, use `az deployment tenant create`.

When you initiate a deployment, you need to tell Azure which scope you want to deploy it atl. To deploy to a subscription, you must use the `New-AzSubscriptionDeployment` cmdlet. For management group deployments, use the `New-AzManagementGroupDeployment` cmdlet. For tenant deployments, use `New-AzTenantDeployment` cmdlet.

Azure stores information about each deployment. It uses two key pieces of information when storing the deployment metadata: location and name. Unlike normal resource group deployments, there are some requirements you need to follow when you deploy at other scopes so that Azure can store the metadata correctly.

- **Location:** The deployment metadata has to be stored in a location that you specify. When you create a deployment at one of these scopes, you need to specify the location that the deployment metadata is stored in. This doesn't mean that the resources are created in that location.
- **Name:** All deployments in Azure have a name. You can ask Azure for information about a deployment by using its name. When you use the Azure CLI or Azure PowerShell to start a deployment, you don't need to specify the name - but if you don't, the filename of the template file will be used as the deployment name.

Another difference from normal deployments is that the combined location and name must be unique. For example, if you create a deployment named `my-deployment` and use the East US location to store its metadata, you can't then create another deployment named `my-deployment` in West Europe.
