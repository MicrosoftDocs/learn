Templates are powerful because of their reusability. You can use Bicep to write templates that deploy multiple environments or copies of your resources.

Your toy company launches new products regularly, and you need to use the Bicep templates to create the Azure resources required for each product launch. You need to avoid using fixed resource names. Many types of Azure resources need unique names, so embedding names in your template means you can't reuse the template for multiple product launches. You also have to deploy the resources in different locations depending on where the toys will be launched, which means you can't embed the resource locations in your template either.

In this unit, you'll learn about _parameters_ and _variables_, which are two Bicep features that can make your templates flexible and reusable. You'll also be introduced to _expressions_.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Parameters and variables

A _parameter_ lets you bring in values from outside the template file. For example, if you're manually deploying the template by using the Azure CLI or Azure PowerShell, you'll be asked to provide values for each parameter. You can also create a _parameter file_, which lists all of the parameters and values you want to use for the deployment. If the template is deployed from an automated process like a deployment pipeline, the pipeline can provide the parameter values.

A _variable_ is defined and set within the template. Variables let you store important information in one place and refer to it throughout the template without having to copy and paste it.

It's usually a good idea to use parameters for things that will change between each deployment, like:

- Resource names that need to be unique.
- Locations into which to deploy the resources.
- Settings that affect the pricing of resources, like their SKUs, pricing tiers, and instance counts.
- Credentials and information needed to access other systems that aren't defined in the template.

Variables are usually a good option when you'll use the same values for each deployment, but you want to make a value reusable within the template, or when you want to use expressions to create a complex value. You can also use variables for resources that don't need unique names.

> [!TIP]
> It's important to use good naming for parameters and variables, so your templates are easy to read and understand. Make sure you're using clear, descriptive, and consistent names.

## Add a parameter

In Bicep, you can define a parameter like this:

```bicep
param appServiceAppName string
```

Let's look at how each part of this definition works:

- `param` tells Bicep that you're defining a parameter.
- `appServiceAppName` is the name of the parameter. If you're deploying the template manually, you might be asked to enter a value, so it's important that the name is clear and understandable. The name is also how you refer to the parameter value within the template, just like with resource symbolic names.
- `string` is the type of the parameter. You can specify several different types for Bicep parameters, including `string` for text, `int` for numbers, and `bool` for Boolean true or false values. You can also pass in more complex parameters by using the `array` and `object` types.

> [!TIP]
> Try not to over-generalize templates by using too many parameters. You should use the minimum number of parameters you need for your business scenario. Remember, you can always change templates in the future if your requirements change.

### Provide default values

You can optionally provide a _default value_ for a parameter. When you specify a default value, the parameter becomes optional. The person who's deploying the template can specify a value if they want, but if they don't, Bicep uses the default value.

Here's how you can add a default value:

```bicep
param appServiceAppName string = 'toy-product-launch-1'
```

> [!NOTE]
> In this example, the Azure App Service app name has a hard-coded default value. This isn't a good idea, because App Service apps need unique names. You'll fix this shortly.

### Use parameter values in the template

After you've declared a parameter, you can refer to it throughout the rest of the template. Let's see how you can use your new parameter within the resource definition:

:::code language="bicep" source="code/5-parameter-value.bicep" highlight="2":::

Notice that the template now uses the parameter value to set the resource name for the app resource, instead of a hard-coded value.

> [!TIP]
> The Bicep extension for Visual Studio Code shows you visual indicators to let you know when you're not following recommended practices. For example, it warns you if you define a parameter that you don't use. The _Bicep linter_ continuously runs these checks while you work.

## Add a variable

You can define a variable like this:

```bicep
var appServicePlanName = 'toy-product-launch-plan'
```

Variables are defined in a similar way to parameters, but there are a few differences:

- Use the `var` keyword to tell Bicep you're declaring a variable.
- You must provide a value for a variable.
- Variables don't need types. Bicep can determine the type based on the value that you set.

## Expressions

When you're writing templates, you often don't want to hard-code values, or even ask for them to be specified in a parameter. Instead, you want to discover values when the template runs. For example, you probably want to deploy all of the resources in a template into a single Azure region: the region where you've created the resource group. Or, you might want to automatically create a unique name for a resource based on a particular naming strategy your company uses.

_Expressions_ in Bicep are a powerful feature that helps you handle all sorts of interesting scenarios. Let's take a look at a few places where you can use expressions in a Bicep template.

### Resource locations

When you're writing and deploying a template, you often don't want to have to specify the location of every resource individually. Instead, you might have a simple business rule that says, _by default, deploy all resources into the same location in which the resource group was created_.

In Bicep, you can create a parameter called `location`, then use an expression to set its value:

```bicep
param location string = resourceGroup().location
```

Look at the default value of that parameter. It uses a _function_ called `resourceGroup()` that gives you access to information about the resource group into which the template is being deployed. In this example, the template uses the `location` property. It's common to use this approach to deploy your resources into the same Azure region as the resource group.

If someone is deploying this template, they might choose to override the default value here and use a different location.

> [!NOTE]
> Some resources in Azure can be deployed only into certain locations. You might need separate parameters to set the locations of these resources.

You can now use the resource location parameter inside the template, like this:

:::code language="bicep" source="code/5-variable-value.bicep" highlight="3":::

### Resource names

Many Azure resources need unique names. In your scenario, you have two resources that need unique names: the storage account and the App Service app. Asking for these values to be set as parameters can make it difficult for whoever uses the template, because they need to find a name that nobody else has used.

Bicep has another function called `uniqueString()` that comes in handy when you're creating resource names. When you use this function, you need to provide a _seed value_, which should be different across different deployments, but consistent across all deployments of the same resources.

If you choose a good seed value, you can get the same name every time you deploy the same set of resources, but you'll get a different name whenever you deploy a different set of resources by using the same template. Let's look at how you might use the `uniqueString()` function:

```bicep
param storageAccountName string = uniqueString(resourceGroup().id)
```

This parameter's default value uses the `resourceGroup()` function again, like you did when you set the resource location. This time, though, you're getting the ID for a resource group. Here's what a resource group ID looks like:

```Output
/subscriptions/3e57e557-826f-460b-8f1c-4ce38fd53b32/resourceGroups/MyResourceGroup
```

The resource group ID includes the Azure subscription ID (`3e57e557-826f-460b-8f1c-4ce38fd53b32`) and the resource group name (`MyResourceGroup`). The resource group ID is often a good candidate for a seed value for resource names, because:

- Every time you deploy the same resources, they'll go into the same resource group. The `uniqueString()` function will return the same value every time.
- If you deploy into two different resource groups in the Azure subscription, the `resourceGroup().id` value will be different, because the resource group names will be different. The `uniqueString()` function will give different values for each set of resources.
- If you deploy into two different Azure subscriptions, _even if you use the same resource group name_, the `resourceGroup().id` value will be different because the Azure subscription ID will be different. The `uniqueString()` function will again give different values for each set of resources.

> [!TIP]
> It's often a good idea to use template expressions to create resource names. Many Azure resource types have rules about the allowed characters and length of their names. Embedding the creation of resource names in the template means that anyone who uses the template doesn't have to remember to follow these rules themselves.

### Combined strings

If you just use the `uniqueString()` function to set resource names, you'll probably get unique names, but they won't be meaningful. A good resource name should also be descriptive, so that it's clear what the resource is for. You'll often want to create a name by combining a meaningful word or string with a unique value. This way, you'll have resources that have both meaningful _and_ unique names.

Bicep has a feature called _string interpolation_ that lets you combine strings. Let's see how it works:

```bicep
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
```

The default value for the `storageAccountName` parameter now has two parts to it:

- `toylaunch` is a hard-coded string that helps anyone who looks at the deployed resource in Azure to understand the storage account's purpose.
- `${uniqueString(resourceGroup().id)}` is a way of telling Bicep to evaluate the output of the `uniqueString(resourceGroup().id)` function, then concatenate it into the string.

> [!TIP]
> Sometimes the `uniqueString()` function will create strings that start with a number. Some Azure resources, like storage accounts, don't allow their names to start with numbers. This means it's a good idea to use string interpolation to create resource names, like in the preceding example.

### Selecting SKUs for resources

The other members of your team have been impressed with the Bicep code you've built so far. You've decided together that you'll use your template to deploy the resources to support all your new toy launches.

One of your colleagues has suggested that you create non-production environments for each product launch to help the marketing team test the sites before they're available to customers. However, you want to make sure you don't spend too much money on your non-production environments, so you decide on some policies together:

- In production environments, storage accounts will be deployed at the `Standard_GRS` (geo-redundant storage) SKU for high resiliency. App Service plans will be deployed at the `P2v3` SKU for high performance.
- In non-production environments, storage accounts will be deployed at the `Standard_LRS` (locally redundant storage) SKU. App Service plans will be deployed at the free `F1` SKU.

One way to implement these business requirements is to use parameters to specify each SKU. However, specifying every SKU as a parameter can become difficult to manage, especially when you have larger templates. Another option is to embed the business rules into the template by using a combination of parameters, variables, and expressions.

First, you can specify a parameter that indicates whether the deployment is for a production or non-production environment:

```bicep
@allowed([
  'nonprod'
  'prod'
])
param environmentType string
```

Notice that this code uses some new syntax to specify a list of _allowed values_ for the `environmentType` parameter. Bicep won't let anyone deploy the template unless they provide one of these values.

Next, you can create variables that determine the SKUs to use for the storage account and App Service plan based on the environment:

```bicep
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'
```

Notice some new syntax here, too. Let's break it down:

- `(environmentType == 'prod')` evaluates to a Boolean (true or false) value, depending on which allowed value is used for `environmentType` parameter.
- `?` is called a _ternary operator_, and it evaluates an `if/then` statement. The value after the `?` operator is used if the expression is true. If the expression evaluates to false, the value after the colon (`:`) is used.

We can translate these rules to:

- For the `storageAccountSkuName` variable, if the `environmentType` parameter is set to `prod`, then use the `Standard_GRS` SKU. Otherwise, use the `Standard_LRS` SKU.
- For the `appServicePlanSkuName` variable, if the `environmentType` parameter is set to `prod`, then use the `P2V3` SKU and the `PremiumV3` tier. Otherwise, use the `F1` SKU.

> [!TIP]
> When you create multi-part expressions like this, it's best to use variables rather than embedding the expressions directly into the resource properties. This makes your templates easier to read and understand, because it avoids cluttering your resource definitions with logic.

When you use parameters, variables, and expressions in your template, you can reuse your template and quickly deploy a new set of resources. For example, each time your marketing department asks you to deploy a new website for the next toy launch, you supply new parameter values for each environment that you deploy, and you'll be set!
