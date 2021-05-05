All Azure resources are deployed with a specific type. The type identifies the kind of resource it is. A resource ID is the way Azure identifies a specific instance of a resource. It's important to understand how resource types and resource IDs are structured, because resource types and IDs give you important information for when you're writing Bicep templates.

## Resource providers

Azure Resource Manager is designed so that many different _resource providers_ can be managed through Resource Manager APIs and ARM templates. A resource provider is a logical grouping of resource types, which usually relate to one or a small number of Azure services. Examples of resource providers include:

- `Microsoft.Compute`, which is used for virtual machines.
- `Microsoft.Network`, which is used for networking resources like virtual networks, network security groups, and route tables.
- `Microsoft.Cache`, which is used for Azure Cache for Redis.
- `Microsoft.Sql`, which is used for Azure SQL.
- `Microsoft.Web`, which is used for Azure App Service and Azure Functions.
- `Microsoft.DocumentDB`, which is used for Azure Cosmos DB.

> [!NOTE]
> Sometimes the resource provider names and resource type names don't match the names of the Azure services they are for, or they might use old product or resource names. For example, the resource provider for Log Analytics workspaces is `Microsoft.OperationalInsights`.

The [documentation for each resource type's](/azure/templates/) ARM template syntax is organized by resource provider.

> [!TIP]
> Resource providers have to be registered for your subscription before you can use the resource types they expose. This is typically a one-time process. You can [register a resource provider](/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider) using the Azure portal, Azure CLI, or Azure PowerShell.

## Resource types

A resource provider exposes multiple different types. Each resource type has its own set of properties and behaviors that define the resource and what it can do. For example, within the `Microsoft.Web` resource provider, there are several resource types including:

- `sites`, which defines an App Service application or Azure Functions application. Properties include the environment variables that your application uses, and the supported protocols to access the application (HTTP and HTTPS). 
- `serverFarms`, which defines an App Service plan - the infrastructure that runs your applications. Properties include the size and SKU of the servers, and the number of instances of your plan that you want to deploy.

When you define resources in Bicep, you have to specify their resource type and the version of the resource provider's API that you want Bicep to use for the resource. This information helps the Bicep tooling and Resource Manager itself to understand which properties should be provided with the resource's definition.

> [!NOTE]
> It's a good idea to use recent API versions for each resource. Sometimes, new features in Azure services are only available in newer API versions.

When you combine the resource provider and type name together, this makes a fully qualified resource type name. The fully qualified type name consists of the resource provider name, followed by a slash (`/`), and then the resource type. For example, a storage account’s fully qualified type name is `Microsoft.Storage/storageAccounts`. This means that its resource provider name is `Microsoft.Storage`, and the resource type is `storageAccounts`.

## Resource IDs

Every Azure resource has a unique resource ID. This ID includes information to help to disambiguate any resource from any other resource of the same type, or even different resources that might share the same name. A resource ID for a storage account looks like this:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment/providers/Microsoft.Storage/storageAccounts/secrettoys
```

Let's look at a visual representation of the same information:

:::image type="content" source="../media/2-resource-id.png" alt-text="Resource ID for a storage account, split with key/value pair on a separate line." border="false":::

You can see that a resource ID interleaves information about the resource type and the specific resource you've deployed. Let's break this example resource ID into its components:

- `subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c` indicates that this resource is within the Azure subscription with ID `f0750bbe-ea75-4ae5-b24d-a92ca601da2c`.
- `resourceGroups/ToyDevelopment` indicates that this resource is within the resource group named `ToyDevelopment`.
- `providers/Microsoft.Storage` indicates the resource is using a type from the `Microsoft.Storage` resource provider.
- `storageAccounts` is the resource's type.
- `secrettoys` is the name of the storage account.

> [!TIP]
> You can access the ID of any resource in Bicep by using the symbolic name and the `id` property. For example, if you define a storage account with the symbolic name `toyDesignDocumentsStorageAccount`, you can access its resource ID by using the expression `toyDesignDocumentsStorageAccount.id`.

Now that you understand the basics of resource types and resource IDs, let's look at child resources.
