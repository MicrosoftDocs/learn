Templates are powerful because of their reusability. We need to write templates that can be used to deploy multiple separate environments or copies of our resources.

Our toy company will be launching new products regularly, and we need to use the Bicep templates to create the Azure resources required for each product launch. We want to avoid using fixed resource names, since resources often need unique names. We also have to deploy our resources in different locations depending on where our toys will be launched.

Here, you'll learn about parameters and variables, which are two Bicep features you can use to make your templates flexible and reusable. You'll also be introduced to _expressions_.

## Parameters and variables

A _parameter_ lets us bring values in from outside of our template. For example, if someone is manually deploying our template using the Azure CLI or PowerShell, they'll be asked to provide values for each parameter. They can also create a _parameter file_, which lists all of the parameters and values they want to use for the deployment. If the template is deployed from an automated process like a deployment pipeline, the pipeline can provide the parameter values.

A _variable_ is defined and set within our template. Variables let us store important information in one place and refer to it throughout our template without having to copy and paste it.

It's usually a good idea to use parameters for things that will change between each deployment, like:

- The names of resources that need to be unique.
- Locations to deploy our resources into.
- Settings that affect the pricing of resources, like their SKUs, pricing tiers, and instance counts.
- Credentials and information needed to access other systems that aren't defined in the template.

Variables are usually a good option when you'll use the same values for each deployment, but where you want to make a value reusable within the template, or if you want to use expressions to create a complex value. You can also use variables for the names of resources that don't need unique names.

> [!TIP]
> It's important to use good naming for parameters and variables. Good names make your templates easy to read and understand. Make sure you're using clear, descriptive names, and be consistent in how you name your parameters and variables.

## Adding a parameter

In Bicep, we can define a parameter like this:

```bicep
param appServiceAppName string
```

Let's look at how each part of this works:
- `param` tells Bicep that we're defining a parameter.
- `appServiceAppName` is the name of the parameter. If someone is deploying the template manually, they may be asked to enter a value, so it's important the name is clear and understandable. The name is also how we refer to the parameter value within the template.
- `string` is the type of the parameter. We can specify several different types for our Bicep parameters including `string` (for text), `int` (for numbers), and `bool` (for Boolean true/false values). We can also pass in more complex parameters using the `array` and `object` types.

> [!TIP]
> Try not to over-generalize your templates by using too many parameters. You should use the minimum number of parameters that you need for your business scenario. Remember you can always change templates in the future if your requirements change.

### Default values

We can optionally provide a _default value_ for a parameter. By specifying a default value, we're effectively making the parameter optional. The person deploying the template can specify a value if they want, but if they don't then Bicep will use the default value instead.

Here's how we can add a default value:

```bicep
param appServiceAppName string = 'toy-product-launch-1'
```

> [!NOTE]
> In the example above, we've declared an App Service app name with a hard-coded default value. This isn't actually a good idea, because App Service apps need unique names. We'll fix this shortly.

### Using parameter values in our template

Once we've declared a variable, we can refer to it within the rest of our template. Let's see how we can use our new parameter within our resource definition:

```bicep
resource appService 'Microsoft.Web/sites@2020-06-01' = {
    name: appServiceAppName
    location: 'eastus'
    properties: {
        serverFarmId: appServicePlan.id
        httpsOnly: true
    }
}
```

Notice that we're now using the parameter value to set the resource name for the app resource, instead of hard-coding it.

## Adding a variable

We can define a variable like this:

```bicep
var appServicePlanName = 'MyAppServicePlan'
```

Variables are defined in a similar way to parameters, but there are a few differences:

- We use the `var` keyword to tell Bicep we're declaring a variable.
- We must provide a value for a variable.
- Variables don't need types. Bicep can work out the type based on how we set its value.

## Using expressions

Often when we write templates we don't want to hard-code values, or even ask for them to be specified in a parameter. Instead, we want to determine the values automatically. For example, we probably want to deploy all of our resources into a single Azure region - and we want that to just be the region that we've created our resource group in. Or, we might want to automatically create a unique name for a resource. _Expressions_ in Bicep are a powerful feature that lets us handle all sorts of interesting scenarios. Let's take a look at a few places where we can use expressions in our template.

### Resource locations

When we write and deploy our template, we don't want to have to specify the location of every resource. Instead, we might have a simple business rule that says _by default, deploy all resources into the same location that the resource group was created in_.

In Bicep, we can create a parameter called `location` and then use an expression to set its value:

```bicep
param location string = resourceGroup().location
```

Take a look at the default value of that parameter. It uses a _function_ called `resourceGroup()`, which gives us access to information about the resource group we're deploying into. In this example, we're just taking the `location` property and using that.

If someone is deploying this template, they might choose to override the default value here and use a different location.

> [!NOTE]
> Some resources in Azure can only be deployed into certain locations. You might need to have separate parameters to set the locations of these resources.

We can now use the resource location parameter inside our template, like this:

```bicep
resource appService 'Microsoft.Web/sites@2020-06-01' = {
    name: appServiceAppName
    location: location
    properties: {
        serverFarmId: appServicePlan.id
        httpsOnly: true
    }
}
```

### Resource names

Many Azure resources need to have unique names. In our scenario, we've got two resources that need to have unique names - the storage account and the App Service app. Asking for these values to be set as parameters can make it difficult for whoever uses our template to find a unique name.

In Bicep, we have another function called `uniqueString()` that we can use when we're creating resource names. When we use this function, we need to provide a _seed value_, which should be different across different deployments, but consistent across all of our deployments of the same resources. If we choose a good seed value, then we can get the same name every time we deploy the same set of resources, but we'll get a different name whenever we deploy a different set of resources using the same template. Let's take a look at how we might use the `uniqueString()` function:

```bicep
param storageAccountName string = uniqueString(resourceGroup().id)
```

We're using the `resourceGroup()` function again here, like we did when we set the resource location. This time, though, we're getting the resource group's ID. This ID includes our Azure subscription ID and the resource group name. That's why the resource group ID is a good candidate for a seed value for resource names since:

- Every time we deploy the same resources, they'll go into the same resource group - so we'll get the same names out of the `uniqueString()` function.
- If we deploy into two different resource groups in our Azure subscription, the `resourceGroup().id` will be different since the resource group names will be different - so we'll get different names out of the `uniqueString()` function for each of our sets of resources.
- If we deploy into two different Azure subscriptions, _even if we use the same resource group name_, the `resourceGroup().id` will be different since the Azure subscription ID will be different - so we'll get different names out of the `uniqueString()` function for each of our sets of resources.

### Combining strings together

If we just use the `uniqueString()` function to set resource names, we'll probably get unique names - but they won't be meaningful. A good resource name should also be descriptive so that it's clear what the resource is for. We'll often want to create a name by combining a meaningful word or string with a unique value. This way, we'll have resources that have both meaningful and unique names.

Bicep has a feature that lets us combine strings together. This feature is called _string interpolation_. Let's see how it works:

```bicep
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
```

The default value we're setting for our `storageAccountName` parameter now has two parts to it:

- `toylaunch` is a hard-coded string that helps us understand what this storage account is for.
- `${uniqueString(resourceGroup().id)}` is a way of telling Bicep to evaluate the output of the `uniqueString(resourceGroup().id)` function, and then concatenate it into the string.
