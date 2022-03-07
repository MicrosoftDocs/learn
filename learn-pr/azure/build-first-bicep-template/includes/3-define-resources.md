Bicep templates are the files you author. They define the Azure resources to be deployed.

Your toy company needs you to create a reusable Bicep template for product launches. The template needs to deploy an Azure storage account and Azure App Service resources, which will be used for the marketing of each new product during its launch.

In this unit, you'll learn how to define a resource in a Bicep template, how resource names work, and how you can create resources that relate to each other.

## Define a resource

The main thing you'll do with Bicep templates is define your Azure resources. Here's an example of what a typical resource definition looks like in Bicep. This example creates a storage account named `toylaunchstorage`.

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
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

* The `resource` keyword at the start tells Bicep that you're about to define a resource.
* Next, you give the resource a _symbolic name_. In the example, the resource's symbolic name is `storageAccount`. Symbolic names are used within Bicep to refer to the resource, but they won't ever show up in Azure.
* `Microsoft.Storage/storageAccounts@2021-08-01` is the *resource type* and *API version* of the resource. `Microsoft.Storage/storageAccounts` tells Bicep that you're declaring an Azure storage account. `2021-08-01` is the version of the Azure Storage API that Bicep will use when it creates the resource.
  > [!TIP]
  > The [Visual Studio Code extension for Bicep](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) helps you find the resource types and API versions for the resources you create. If you're familiar with ARM templates, note that the API version matches the version you'd use there too.
* You have to declare a *resource name*, which is the name the storage account will be assigned in Azure. You'll set a resource name using the `name` keyword.
  > [!IMPORTANT]
  > Symbolic names are used only within the Bicep template, and don't appear in Azure. Resource names *do* appear in Azure.
* You'll then set other details of the resource, such as its location, SKU (pricing tier), and kind. There are also properties you can define that are different for each resource type. Different API versions might introduce different properties, too. In this example, we're setting the storage account's access tier to `Hot`.

> [!TIP]
> Resource names often have rules you must follow, like maximum lengths, allowed characters, and uniqueness across all of Azure. The requirements for resource names are different for each Azure resource type. Be sure to understand the naming restrictions and requirements before you add them to your template.

## What happens when resources depend on each other?

A Bicep template usually includes several resources. Often, you need a resource to depend on another resource. You might have to extract some information from one resource to be able to define another. Or, if you're deploying a web application, you'll have to create the server infrastructure before you can add an application to it. These relationships are called *dependencies*.

You'll need to deploy an App Service app for the template that will help launch the toy product. But to create an App Service app, you first need to create an App Service plan. The App Service plan represents the server-hosting resources, and it's declared like this example:

```bicep
resource appServicePlan 'Microsoft.Web/serverFarms@2021-03-01' = {
  name: 'toy-product-launch-plan'
  location: 'westus3'
  sku: {
    name: 'F1'
  }
}
```

This resource definition is telling Bicep you want to deploy an App Service plan that has the resource type `Microsoft.Web/serverFarms`. The plan resource is named `toy-product-launch-plan`, and it's deployed into the West US 3 region. It uses a pricing SKU of F1, which is the free tier of App Service.

Now that you've declared the App Service plan, the next step is to declare the app:

```bicep
resource appServiceApp 'Microsoft.Web/sites@2021-03-01' = {
  name: 'toy-product-launch-1'
  location: 'westus3'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
```

This template instructs Azure to host the app on the plan you created. Notice that the definition of the plan includes the symbolic name of the App Service plan on this line: `serverFarmId: appServicePlan.id`. This line means that Bicep will get the plan's *resource ID* using the `.id` property. It's effectively saying, "This app's server farm ID is the ID of the App Service plan defined earlier."

> [!TIP]
> In Azure, a *resource ID* is a unique identifier for each resource. The resource ID includes the Azure subscription ID, the resource group name, and the resource name, along with some other information.

By declaring the app resource with a property that references the symbolic name of the plan, Azure understands the *implicit dependency* between the App Service app and the plan. When it deploys the resources, Azure will make sure it fully deploys the plan before it starts to deploy the app.
