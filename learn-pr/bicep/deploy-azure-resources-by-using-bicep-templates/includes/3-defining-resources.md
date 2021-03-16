Bicep templates are used to define Azure resources that will be deployed.

In our toy company example, we'll need to create a Bicep template that we can reuse for product launches. The template needs to deploy an Azure Storage account and some App Service resources.

Here, you will learn how to define a resource in a Bicep template, how resource names work, and how we can create multiple resources that relate to each other.

## Define a resource

The main thing we do with Bicep templates is define our Azure resources. A Bicep resource definition looks like this:

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

* The `resource` keyword at the start tells Bicep that we're about to define a resource.
* Next, we give our resource a _symbolic name_. In the example above we've called our resource `storageAccount`. Symbolic names are used within Bicep to refer to the resource - but they won't ever show up in Azure.
* `Microsoft.Storage/storageAccounts@2019-06-01` is the _resource type_ and _API version_ of our resource. `Microsoft.Storage/storageAccounts` means we are declaring an Azure Storage account. `2019-06-01` is the version of the Azure Storage API that Bicep will use when it creates the resource on our behalf.
* We have to declare a _resource name_, which is the name that our storage account will actually get assigned in Azure. We set a resource name by using the `name` keyword.
* We then set other _properties_ of the resources, such as its location, SKU (pricing tier), kind, and other properties. The properties we can define are different for each resource type.

> [!TIP]
> Resource names often have rules that you have to follow, like maximum lengths, allowed characters, and being unique across all of Azure. It's a good idea to test your Bicep template so you can see if your names are valid.

## Defining multiple resources

A Bicep template usually includes several different resources. Often, you'll need a resource to depend on another resource. This might be because you have to extract some information from one resource to be able to define another. Or, if you're deploying a web application, you have to create the physical server infrastructure before you can add an application to it. We call these relationships _dependencies_.

Let's look at an example. We need to deploy an App Service app for our product launch template. But in order to create an App Service app, we first need to create an App Service plan. The App Service plan represents our server hosting resources. Let's declare that:

```bicep
resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
    name: 'MyAppServicePlan'
    location: 'eastus'
    sku: {
        name: 'S1'
    }
}
```

This resource definition is telling Bicep that we want to deploy an App Service plan (which has the resource type `Microsoft.Web/serverFarms`) named `MyAppServicePlan` into the East US region, and use a pricing tier of S1.

Now that we've declared our plan, we can define our app:

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

We're instructing our deployment to host the app on the plan we created above. We use the symbolic name of the App Service plan to refer to it, and then we access its `id` property to get its _resource ID_. We're effectively saying "this app's server farm ID is the ID of the App Service plan above".

By declaring our resource like this, Azure understands there is an _implicit dependency_ between our App Service app and plan. When it deploys our resources, it will make sure it deploys the plan first, and will wait for it to be deployed before it starts to deploy the app.
