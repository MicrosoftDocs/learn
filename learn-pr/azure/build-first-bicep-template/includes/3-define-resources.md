Bicep templates are the files you author that define the Azure resources to be deployed.

Your toy company needs you to create a reusable Bicep template for product launches. The template needs to deploy an Azure storage account and Azure App Service resources, which will be used for the marketing of each new product during its launch.

In this unit, you'll learn how to define a resource in a Bicep template, how resource names work, and how you can create resources that relate to each other.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Define a resource

The main thing you'll do with Bicep templates is define your Azure resources. Here's an example of what a typical resource definition looks like in Bicep. This example creates a storage account named `toylaunchstorage`.

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
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
- Next, you give the resource a _symbolic name_. In the example, the resource's symbolic name is `storageAccount`. Symbolic names are used within Bicep to refer to the resource, but they won't ever show up in Azure.
- `Microsoft.Storage/storageAccounts@2022-09-01` is the _resource type_ and _API version_ of the resource. `Microsoft.Storage/storageAccounts` tells Bicep that you're declaring an Azure storage account. The date `2022-09-01` is the version of the Azure Storage API that Bicep uses when it creates the resource.

  > [!TIP]
  > The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) helps you find the resource types and API versions for the resources you create. If you're familiar with ARM templates, note that the API version matches the version you'd use there too.

- You have to declare a _resource name_, which is the name the storage account will be assigned in Azure. You'll set a resource name using the `name` keyword.

  > [!IMPORTANT]
  > Symbolic names are used only within the Bicep template, and don't appear in Azure. Resource names _do_ appear in Azure.

- You'll then set other details of the resource, such as its location, SKU (pricing tier), and kind. There are also properties you can define that are different for each resource type. Different API versions might introduce different properties, too. In this example, we're setting the storage account's access tier to `Hot`.

> [!TIP]
> Resource names often have rules you must follow, like maximum lengths, allowed characters, and uniqueness across all of Azure. The requirements for resource names are different for each Azure resource type. Be sure to understand the naming restrictions and requirements before you add them to your template.

## What happens when resources depend on each other?

A Bicep template usually includes several resources. Often, you need a resource to depend on another resource. You might have to extract some information from one resource to be able to define another. Or, if you're deploying a web application, you'll have to create the server infrastructure before you can add an application to it. These relationships are called _dependencies_.

You'll need to deploy an App Service app for the template that will help launch the toy product, but to create an App Service app, you first need to create an App Service plan. The App Service plan represents the server-hosting resources, and it's declared like this example:

```bicep
resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
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
resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'toy-product-launch-1'
  location: 'westus3'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
```

This template instructs Azure to host the app on the plan you created. Notice that the plan's definition includes the App Service plan's symbolic name on this line: `serverFarmId: appServicePlan.id`. This line means that Bicep will get the App Service plan's _resource ID_ using the `id` property. It's effectively saying: _this app's server-farm ID is the ID of the App Service plan defined earlier_.

> [!TIP]
> In Azure, a _resource ID_ is a unique identifier for each resource. The resource ID includes the Azure subscription ID, the resource group name, and the resource name, along with some other information.

By declaring the app resource with a property that references the symbolic name of the plan, Azure understands the _implicit dependency_ between the App Service app and the plan. When it deploys the resources, Azure will ensure it fully deploys the plan before it starts to deploy the app.
