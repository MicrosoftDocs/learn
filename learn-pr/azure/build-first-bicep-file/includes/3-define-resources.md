Bicep files are the files you author that define the Azure resources to be deployed.

Your toy company needs you to create a reusable Bicep file for product launches. The file needs to deploy an Azure storage account and Azure App Service resources, which will be used for the marketing of each new product during its launch.

In this unit, you'll learn how to define a resource in a Bicep file, how resource names work, and how you can create resources that relate to each other.

> [!NOTE]
> The commands in this unit are shown to illustrate concepts. Don't run the commands yet. You'll practice what you learn here soon.

## Define a resource

The main thing you'll do with Bicep files is define your Azure resources. Here's an example of what a typical resource definition looks like in Bicep. This example creates a storage account named `toylaunchstorage`.

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'toylaunchstorage'
  location: 'westus3'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
```

Let's look closely at some key parts of this resource definition:

- The `resource` keyword at the start tells Bicep that you're about to define a resource.
- Next, you give the resource a _symbolic name_. In this example, that name is `storageAccount`. Use it in Bicep expressions to refer to the resource. It's distinct from the Azure resource name assigned through the `name` property.
- `Microsoft.Storage/storageAccounts@2023-05-01` specifies the _resource type_ and _API version_. `Microsoft.Storage/storageAccounts` declares an Azure storage account. `2023-05-01` selects the resource provider's management API version used for that resource deployment.

  > [!TIP]
  > The Bicep extension for Visual Studio Code helps you find the resource types and API versions for the resources you create. If you're familiar with ARM templates, note that the API version matches the version you'd use there too.

- You have to declare a _resource name_, which is the name the storage account will be assigned in Azure. You'll set a resource name using the `name` keyword.

  > [!IMPORTANT]
  > A symbolic name identifies a resource within the template. The resource's `name` property sets its Azure name. Changing only a symbolic name doesn't rename the deployed Azure resource.

- You'll then set other details of the resource, such as its location, SKU (pricing tier), and kind. There are also properties you can define that are different for each resource type. Different API versions might introduce different properties, too. In this example, we're setting the storage account's access tier to `Hot`.

> [!TIP]
> Resource names often have rules you must follow, like maximum lengths, allowed characters, and uniqueness across all of Azure. The requirements for resource names are different for each Azure resource type. Be sure to understand the naming restrictions and requirements before you add them to your Bicep file.

## What happens when resources depend on each other?

A Bicep file usually includes several resources. Often, you need a resource to depend on another resource. You might have to extract some information from one resource to be able to define another. If you're deploying a web application, you'll have to create the server infrastructure before you can add an application to it. These relationships are called _dependencies_.

You'll need to deploy an App Service app for the Bicep file that'll help launch the toy product, but to create an App Service app, you first need to create an App Service plan. The App Service plan represents the server-hosting resources, and it's declared like this example:

```bicep
resource appServicePlan 'Microsoft.Web/serverFarms@2023-12-01' = {
  name: 'toy-product-launch-plan'
  location: 'westus3'
  sku: {
    name: 'F1'
  }
}
```

This resource definition is telling Bicep you want to deploy an App Service plan that has the resource type `Microsoft.Web/serverFarms`. The plan resource is named `toy-product-launch-plan`, and it's deployed into the West US 3 region. It uses a pricing SKU of F1, which is App Service's free tier.

Now that you've declared the App Service plan, the next step is to declare the app:

```bicep
resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = {
  name: 'toy-product-launch-1'
  location: 'westus3'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
```

This Bicep file instructs Azure to host the app on the plan you created. In the app's definition, `serverFarmId: appServicePlan.id` sets the app's `properties.serverFarmId` property to the resource ID of the App Service plan. The expression uses the plan's symbolic name, `appServicePlan`, to access its `id` property.

> [!TIP]
> An Azure resource ID identifies a resource and its scope. For the resource-group-scoped resources in this module, the ID includes the subscription ID, resource-group name, resource provider namespace, resource type, and resource name. Resources at other scopes use different ID formats. Reference a resource's `id` property, such as `appServicePlan.id`, rather than constructing its ID yourself. For more information, see Bicep resource-ID functions in the More info section of the Summary unit.

By declaring the app resource with a property that references the plan's symbolic name, Azure understands the _implicit dependency_ between the App Service app and the plan. When it deploys the resources, Azure ensures it fully deploys the plan before it starts to deploy the app.
