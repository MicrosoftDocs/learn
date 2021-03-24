Bicep templates are the files you write. Templates define Azure resources that will be deployed.

The toy company needs you to create a reusable Bicep template for product launches. The template needs to deploy an Azure Storage account and some App Service resources, which will be used for the marketing of each new product during their launches.

In this unit, you'll learn how to define a resource in a Bicep template, how resource names work, and how you can create multiple resources that relate to each other.

## Define a resource

The main thing you do with Bicep templates is define your Azure resources. A Bicep resource definition looks like this:

```bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'mystorageaccount'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
```

Let's look closely at some key parts of this resource definition.

* The `resource` keyword at the start tells Bicep that you're about to define a resource.
* Next, you give the resource a _symbolic name_. In the example above the resource is named `storageAccount`. Symbolic names are used within Bicep to refer to the resource - but they won't ever show up in Azure.
* `Microsoft.Storage/storageAccounts@2019-06-01` is the _resource type_ and _API version_ of the resource. `Microsoft.Storage/storageAccounts` tells Bicep that you are declaring an Azure Storage account. `2019-06-01` is the version of the Azure Storage API that Bicep will use when it creates the resource.
* You have to declare a _resource name_, which is the name that the storage account will actually get assigned in Azure. You set a resource name by using the `name` keyword.
* You then set other _properties_ of the resources, such as its location, SKU (pricing tier), kind, and other properties. The properties you can define are different for each resource type.

> [!TIP]
> Resource names often have rules that you have to follow, like maximum lengths, allowed characters, and being unique across all of Azure. It's a good idea to test your Bicep template so you can see if your names are valid.

## Defining multiple resources

A Bicep template usually includes several different resources. Often, you'll need a resource to depend on another resource. This might be because you have to extract some information from one resource to be able to define another. Or, if you're deploying a web application, you have to create the physical server infrastructure before you can add an application to it. These relationships are called _dependencies_.

You need to deploy an App Service app for the toy product launch template. But in order to create an App Service app, you first need to create an App Service plan. The App Service plan represents the server hosting resources. Let's declare that:

```bicep
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'MyAppServicePlan'
  location: 'eastus'
  sku: {
    name: 'S1'
  }
}
```

This resource definition is telling Bicep that you want to deploy an App Service plan (which has the resource type `Microsoft.Web/serverFarms`) named `MyAppServicePlan` into the East US region, and use a pricing tier of S1.

Now that you've declared the App Service plan, the next step is to declare the app:

```bicep
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: 'toy-product-launch-1'
  location: 'eastus'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
```

This template instructs Azure to host the app on the plan created above. The plan includes the symbolic name of the App Service plan when referring to it, and gets its _resource ID_ using the `.id` property. This is effectively saying "this app's server farm ID is the ID of the App Service plan above".

By declaring resource like this, Azure understands there is an _implicit dependency_ between the  App Service app and plan. When it deploys the resources, Azure will make sure it deploys the plan first, and will wait for it to be deployed before it starts to deploy the app.
