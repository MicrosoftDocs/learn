All Azure resources are deployed with a specific *type*. The type identifies the kind of resource it is. A resource ID is the way Azure identifies a specific instance of a resource. It's important to understand how resource types and resource IDs are structured, because they give you important information when you're writing Bicep templates.

## Resource providers

Azure Resource Manager is designed so that many different *resource providers* can be managed through Resource Manager APIs and ARM templates. A resource provider is a logical grouping of resource types, which usually relate to one or a few Azure services. Examples of resource providers include:

- `Microsoft.Compute`, which is used for virtual machines.
- `Microsoft.Network`, which is used for networking resources like virtual networks, network security groups, and route tables.
- `Microsoft.Cache`, which is used for Azure Cache for Redis.
- `Microsoft.Sql`, which is used for Azure SQL.
- `Microsoft.Web`, which is used for Azure App Service and Azure Functions.
- `Microsoft.DocumentDB`, which is used for Azure Cosmos DB.

> [!NOTE]
> The resource provider names and resource type names occasionally don't match the names of the Azure services they are for, or they  might be old product or resource names. For example, the resource provider for Log Analytics workspaces is `Microsoft.OperationalInsights`.

The [documentation for each resource type's](/azure/templates/) ARM template syntax is organized according to resource provider.

Resource providers have to be registered for your subscription before you can use the resource types they expose. Registration is usually a one-time process. When you submit a Bicep deployment, Resource Manager automatically registers the resource providers used in the file. You can also [register a resource provider](/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider) by using the Azure portal, the Azure CLI, or Azure PowerShell.

## Resource types

A resource provider exposes multiple different types. Each resource type has its own set of properties and behaviors that define the resource and what it can do. For example, within the `Microsoft.Web` resource provider, there are several resource types, including:

- `sites`: Defines an App Service application or Azure Functions application. Properties include the environment variables that your application uses, and the supported protocols (HTTP and HTTPS) to access the application. 
- `serverFarms`: Defines an App Service plan, the infrastructure that runs your applications. Properties include the size and SKU of the servers, and the number of instances of your plan that you want to deploy.

When you define resources in Bicep, you have to specify their resource type and the version of the resource provider's API that you want Bicep to use for the resource. This information helps the Bicep tooling and the Resource Manager understand which properties should be provided with the resource definition.

> [!TIP]
> It's a good idea to use a recent API version for each resource. New features in Azure services are sometimes available only in newer API versions.

You combine the resource provider and type name to make a fully qualified resource type name. The fully qualified type name consists of the resource provider name, a slash (`/`), and the resource type. For example, a storage account’s fully qualified type name is `Microsoft.Storage/storageAccounts`. In this instance, its resource provider name is `Microsoft.Storage`, and the resource type is `storageAccounts`.

## Resource IDs

Every Azure resource has a unique resource ID. This ID includes information that helps disambiguate the resource from any other resource of the same type, or even from different resources that might share the same name. A resource ID for a storage account looks like this:

```
/subscriptions/A123b4567c-1234-1a2b-2b1a-1234abc12345/resourceGroups/ToyDevelopment/providers/Microsoft.Storage/storageAccounts/secrettoys
```

Let's look at a visual representation of the same information:

:::image type="content" source="../media/2-resource-id.png" alt-text="Resource ID for a storage account, split with key/value pair on a separate line." border="false":::

You can see that a resource ID interleaves information about the resource type and the specific resource you deployed. Let's break this example resource ID into its components:

- `subscriptions/A123b4567c-1234-1a2b-2b1a-1234abc12345` indicates that this resource is within the Azure subscription with ID. `A123b4567c-1234-1a2b-2b1a-1234abc12345`.
- `resourceGroups/ToyDevelopment` indicates that the resource is within the resource group named `ToyDevelopment`.
- `providers/Microsoft.Storage` indicates that the resource is using a type from the `Microsoft.Storage` resource provider.
- `storageAccounts` is the resource type.
- `secrettoys` is the name of the storage account.

> [!TIP]
> You can access the ID of any resource in Bicep by using the symbolic name and the `id` property. For example, if you define a storage account with the symbolic name `toyDesignDocumentsStorageAccount`, you can access its resource ID by using the expression `toyDesignDocumentsStorageAccount.id`.

Now that you understand the basics of resource types and resource IDs, let's look at child resources.
