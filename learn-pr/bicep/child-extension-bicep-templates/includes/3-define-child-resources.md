Some resources only make sense to deploy within the context of their parent. These are called _child resources_. There are many different child resources in Azure. Here are a few examples:

| Name                       | Resource type                                                   |
|----------------------------|-----------------------------------------------------------------|
| Virtual network subnets    | `Microsoft.Network/virtualNetworks/subnets`                     |
| App Service configuration  | `Microsoft.Web/sites/config`                                    |
| SQL databases              | `Microsoft.Sql/servers/databases`                               |
| Virtual machine extensions | `Microsoft.Compute/virtualMachines/extensions`                  |
| Storage blob containers    | `Microsoft.Storage/storageAccounts/blobServices/containers`     |
| Cosmos DB containers       | `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers` |

For example, let's consider a storage blob container. A blob container must be deployed into a storage account, and it doesn't make sense for a container to exist outside of a storage account.

Child resource types have longer names with multiple parts to them. A storage blob container has this fully qualified type name: `Microsoft.Storage/storageAccounts/blobServices/containers`. The resource ID for a blob container will include the name of the storage account that contains the container, and the container's name.

> [!NOTE]
> Some child resources might have the same name as other child resource types from different parents. For example, `containers` is a child type of both storage accounts and Cosmos DB databases. The names are the same, but they represent different resources.

## How are child resources defined?

Bicep enables you to declare child resources in several different ways. They all have different advantages, and some are suitable for some situations and not for others. Let's look at each approach.

> [!TIP]
> All of these approaches result in the same deployment activities in Azure. You can choose the approach that best fits your needs, but you don't need to worry that you will break something. Similarly, you can update your template and change the approach you're using, if you want to.

### Nested resources

One approach to defining a child resource is to _nest_ the child resource inside the parent. Here's an example of a Bicep template that deploys a virtual machine and a virtual machine extension. A virtual machine extension is a child resource that provides extra behavior for a virtual machine - in this case, it runs a custom script on the virtual machine after it's deployed.

:::code language="plaintext" source="code/3-nested.bicep" highlight="8-14":::

Notice that the nested resource has a simpler resource type than normal. Even though the fully qualified type name is `Microsoft.Compute/virtualMachines/extensions`, the nested resource automatically inherits the parent's resource type, so you only need to specify the child resource type - `extensions`. Also, notice that there's no API version specified for the nested resource. Bicep assumes that you want to use the same API version as the parent resource, although you can override the API version if you want to.

You can refer to a nested resource by using the `::` operator. For example, you could create an output that will return the full resource ID of the extension:

```bicep
output childResourceId string = vm::installCustomScriptExtension.id
```

Nesting resources is a simple way to declare a child resource. Nesting resources also makes the parent/child relationship obvious to anyone reading the template. However, if you have lots of nested resources, or multiple layers of nesting, templates can become harder to read. You can also only nest resources up to five layers deep.

### Parent property

A second approach is to declare the child resource without any nesting, and then to tell Bicep about the parent-child relationship by using the `parent` property:

:::code language="plaintext" source="code/3-parent-keyword.bicep" highlight="10":::

Notice that the child resource uses the `parent` property to refer to the symbolic name of its parent.

Referencing the parent like this gives you another easy way to declare a child resource. Bicep understands the relationship between the parent and child resources, so you don't need to specify the fully qualified resource name or set up a dependency between the resources. It also avoids your template having too much nesting, which can become difficult to read. However, you need to explicitly specify the full resource type and API version each time you define a child resource using the `parent` property.

To refer to a child resource declared with the `parent` property, you just use its symbolic name like a normal parent resource:

```bicep
output childResourceId string = installCustomScriptExtension.id
```

### Construct the resource name

There are some circumstances where you can't use nested resources or the `parent` keyword. These include declaring child resources within a `for` loop, and when you need to use complex expressions to dynamically select a parent resource for a child. In these situations, you can deploy a child resource by manually constructing the child resource's name so that it includes its parent resource's name:

:::code language="plaintext" source="code/3-manual-resource-type.bicep" highlight="10":::

Notice this example uses string interpolation to append the virtual machine resource's `name` property to the child resource's name. Bicep understands that there's a dependency between our child and parent resource. You could declare the child resource name by using the `vmName` variable instead, but if you did that, Bicep wouldn't understand that the parent resource needs to be deployed before the child resource, and deployments could sometimes fail. You could manually tell Bicep about the dependency by using the `dependsOn` keyword:

:::code language="plaintext" source="code/3-manual-resource-type-dependson.bicep" highlight="11-13":::

> [!TIP]
> Generally it's best to avoid using constructing resource names, because you lose a lot of the benefits that Bicep can provide when it understands the relationships between your resources. Only use this option when you can't use one of the other approaches for declaring child resources.

## Child resource IDs

Child resource IDs start by including their parent's resource ID, then append the child resource type and name. For example, let's consider a Cosmos DB account named `toyrnd`. Cosmos DB's resource provider exposes a type called `databaseAccounts`, which is the parent resource you deploy:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment/providers/Microsoft.DocumentDB/databaseAccounts/toyrnd
```

Here's a visual depiction of the same resource ID:

:::image type="content" source="../media/3-parent-resource-id.png" alt-text="Resource ID for a Cosmos DB account, split with key/value pair on a separate line." border="false":::

If we add a database to this account, we'll use the `sqlDatabases` child resource type. Let's add a database named `FlightTests` to our Cosmos DB account and take a look at the child resource's ID:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment/providers/Microsoft.DocumentDB/databaseAccounts/toyrnd/sqlDatabases/FlightTests
```

Here's a visual representation:

:::image type="content" source="../media/3-child-resource-id.png" alt-text="Child resource ID for a Cosmos DB database, split with key/value pair on a separate line." border="false":::

You can have multiple levels of child resources. Here's an example resource ID showing a storage account with two levels of children:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment/providers/Microsoft.Storage/storageAccounts/secrettoys/blobServices/default/containers/glitterspecs
```

Here's a visual representation of the same resource ID:

:::image type="content" source="../media/3-storage-child-resource-id.png" alt-text="Child resource ID for a storage account with blob container, split with key/value pair on a separate line." border="false":::

This resource ID has several components to it:

- Everything up to `secrettoys` is the parent resource's ID.
- `blobServices` indicates that the resource is within a child resource type called `blobServices`.
  > [!NOTE]
  > You don't have to create `blobServices` resources yourself. The `Microsoft.Storage` resource provider automatically creates this resource for you when you create a storage account. This is sometimes called an _implicit resource_. While these are fairly uncommon, you will find them throughout Azure.
- `default` is the name of the `blobServices` child resource.
  > [!NOTE]
  > Sometimes, only a single instance of a child resource is allowed. These are called _singleton_ resources, and they are often given the name `default`.
- `containers` indicates that the resource is within a child resource type called `containers`.
- `glitterspecs` is the name of the blob container.

When you work with child resources, resource IDs can get long and look complicated. However, if you break down a resource ID into parts, it's easier to understand how the resource is structured. A resource ID can also give you important clues about how the resource behaves.
