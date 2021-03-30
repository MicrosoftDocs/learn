Templates are powerful because of their reusability. You can use Bicep to write templates that deploy multiple separate environments or copies of your resources.

Your toy company will be launching new products regularly, and you need to use the Bicep templates to create the Azure resources required for each product launch. You need to avoid using fixed resource names. Many types of Azure resources need unique names, so embedding names in your template mean you can't reuse the template for multiple different product launches. You also have to deploy the resources in different locations depending on where the toys will be launched, which means you can't embed the resource locations in your template either.

In this unit, you'll learn about _parameters_ and _variables_, which are two Bicep features you can use to make your templates flexible and reusable. You'll also be introduced to _expressions_.

## Parameters and variables

A _parameter_ lets you bring values in from outside of the template file. For example, if someone is manually deploying the template using the Azure CLI or PowerShell, they'll be asked to provide values for each parameter. They can also create a _parameter file_, which lists all of the parameters and values they want to use for the deployment. If the template is deployed from an automated process like a deployment pipeline, the pipeline can provide the parameter values.

A _variable_ is defined and set within the template. Variables let you store important information in one place and refer to it throughout the template without having to copy and paste it.

It's usually a good idea to use parameters for things that will change between each deployment, like:

- The names of resources that need to be unique.
- Locations to deploy the resources into.
- Settings that affect the pricing of resources, like their SKUs, pricing tiers, and instance counts.
- Credentials and information needed to access other systems that aren't defined in the template.

Variables are usually a good option when you'll use the same values for each deployment, but where you want to make a value reusable within the template, or if you want to use expressions to create a complex value. You can also use variables for the names of resources that don't need unique names.

> [!TIP]
> It's important to use good naming for parameters and variables. Good names make your templates easy to read and understand. Make sure you're using clear, descriptive names, and be consistent in how you name your parameters and variables.

## Add a parameter

In Bicep, you can define a parameter like this:

```bicep
param appServiceAppName string
```

Let's look at how each part of this works:
- `param` tells Bicep that we're defining a parameter.
- `appServiceAppName` is the name of the parameter. If someone is deploying the template manually, they may be asked to enter a value, so it's important the name is clear and understandable. The name is also how you refer to the parameter value within the template, just like with resource symbolic names.
- `string` is the type of the parameter. You can specify several different types for Bicep parameters including `string` (for text), `int` (for numbers), and `bool` (for Boolean true/false values). You can also pass in more complex parameters using the `array` and `object` types.

> [!TIP]
> Try not to over-generalize templates by using too many parameters. You should use the minimum number of parameters that you need for your business scenario. Remember you can always change templates in the future if your requirements change.

### Default values

You can optionally provide a _default value_ for a parameter. By specifying a default value, we're effectively making the parameter optional. The person deploying the template can specify a value if they want, but if they don't then Bicep will use the default value instead.

Here's how you can add a default value:

```bicep
param appServiceAppName string = 'toy-product-launch-1'
```

> [!NOTE]
> In the example above, we've declared an App Service app name with a hard-coded default value. This isn't actually a good idea, because App Service apps need unique names. We'll fix this shortly.

### Use parameter values in the template

Once you've declared a variable, you can refer to it within the rest of the template. Let's see how you can use your new parameter within the resource definition:

:::code language="csharp" source="code/5-parameter-value.bicep" highlight="2":::

Notice that the template now uses the parameter value to set the resource name for the app resource, instead of hard-coding it.

## Add a variable

You can define a variable like this:

```bicep
var appServicePlanName = 'ToyLaunchPlan'
```

Variables are defined in a similar way to parameters, but there are a few differences:

- Use the `var` keyword to tell Bicep we're declaring a variable.
- You must provide a value for a variable.
- Variables don't need types. Bicep can work out the type based on the value you set.

## Expressions

Often when writing templates you don't want to hard-code values, or even ask for them to be specified in a parameter. Instead, you want to determine the values automatically. For example, you probably want to deploy all of of the resources in a template into a single Azure region - and you want that to just be the region that we've created the resource group in. Or, you might want to automatically create a unique name for a resource based on a particular naming strategy your company uses. _Expressions_ in Bicep are a powerful feature that lets you handle all sorts of interesting scenarios. Let's take a look at a few places where you can use expressions in Bicep template.

### Resource locations

When writing and deploying a template, you often don't want to have to specify the location of every resource individually. Instead, you might have a simple business rule that says "_by default, deploy all resources into the same location that the resource group was created in_".

In Bicep, you can create a parameter called `location` and then use an expression to set its value:

```bicep
param location string = resourceGroup().location
```

Take a look at the default value of that parameter. It uses a _function_ called `resourceGroup()`, which gives you access to information about the resource group the template is being deployed into. In this example, we're just taking the `location` property and using that.

If someone is deploying this template, they might choose to override the default value here and use a different location.

> [!NOTE]
> Some resources in Azure can only be deployed into certain locations. You might need to have separate parameters to set the locations of these resources.

You can now use the resource location parameter inside the template, like this:

:::code language="csharp" source="code/5-variable-value.bicep" highlight="3":::

### Resource names

Many Azure resources need to have unique names. In your scenario, you've got two resources that need to have unique names - the storage account and the App Service app. Asking for these values to be set as parameters can make it difficult for whoever uses the template since they need to find a name that nobody else has used.

Bicep has another function called `uniqueString()` that you comes in handy when you're creating resource names. When you use this function, you need to provide a _seed value_, which should be different across different deployments but consistent across all of the deployments of the same resources. If you choose a good seed value, then you can get the same name every time you deploy the same set of resources, but you'll get a different name whenever you deploy a different set of resources using the same template. Let's take a look at how you might use the `uniqueString()` function:

```bicep
param storageAccountName string = uniqueString(resourceGroup().id)
```

We're using the `resourceGroup()` function again here, like you did when you set the resource location. This time, though, we're getting the resource group's ID. Here's what a resource group ID looks like:

```
/subscriptions/3e57e557-826f-460b-8f1c-4ce38fd53b32/resourceGroups/MyResourceGroup
```

As you can see, the resource group ID includes the Azure subscription ID (`3e57e557-826f-460b-8f1c-4ce38fd53b32`) and the resource group name (`MyResourceGroup`). This means that the resource group ID is often a good candidate for a seed value for resource names, since:

- Every time you deploy the same resources, they'll go into the same resource group. Bicep will give the same values from the `uniqueString()` function.
- If you deploy into two different resource groups in the Azure subscription, the `resourceGroup().id` will be different since the resource group names will be different. Bicep will give different values from the `uniqueString()` function for each of the sets of resources.
- If you deploy into two different Azure subscriptions, _even if you use the same resource group name_, the `resourceGroup().id` will be different since the Azure subscription ID will be different. Bicep will give different values from the `uniqueString()` function for each of the sets of resources.

> [!TIP]
> It's often a good idea to use template expressions to create resource names. Many Azure resource types have rules about the allowed characters and length of their names. Embedding the creation of resource names in the template means that anyone using the template doesn't have to remember to follow these rules themselves.

### Combine strings together

If you just use the `uniqueString()` function to set resource names, we'll probably get unique names - but they won't be meaningful. A good resource name should also be descriptive so that it's clear what the resource is for. We'll often want to create a name by combining a meaningful word or string with a unique value. This way, we'll have resources that have both meaningful _and_ unique names.

Bicep has a feature called _string interpolation_ that lets you combine strings together. Let's see how it works:

```bicep
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
```

The default value for the `storageAccountName` parameter now has two parts to it:

- `toylaunch` is a hard-coded string that helps to understand what this storage account is for.
- `${uniqueString(resourceGroup().id)}` is a way of telling Bicep to evaluate the output of the `uniqueString(resourceGroup().id)` function, and then concatenate it into the string.

### Select SKUs for resources

Your toy company has decided they will use your templates to deploy the resources for the launches all of their new toys. They also want to make sure they follow best practices and create non-production environments for each product launch, as well as their production environments. However, to save money, they want you to follow these business rules:

- In production environments, storage accounts must be deployed at the `Standard_GRS` (geo-redundant storage) SKU for higher resiliency, and App Service plans must be deployed using the `P2_v3` SKU for higher performance.
- In non-production environments, storage accounts must be deployed at the `Standard_LRS` (locally redundant storage) SKU, and App Service plans must be deployed using the free `F1` SKU.

One way to implement these business requirements would be to use parameters to specify each SKU. However, this can become difficult to maintain when you have larger templates - if you have to specify every single SKU as a parameter then it can get difficult to manage. Another option is to embed the business rules into the template by using a combination of parameters, variables, and expressions.

First, you can specify a parameter that indicates whether the deployment is for a production or non-production environment:

```bicep
@allowed([
    'nonprod'
    'prod'
])
param environmentType string
```

Notice we're using some new syntax to specify a list of _allowed values_ for the `environmentName` parameter. Bicep won't let anyone execute the template unless they provide one of these values.

Next, you can create variables that determine the SKUs to use for the storage account and App Service plan based on the environment:

```bicep
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'
var appServicePlanTierName = (environmentType == 'prod') ? 'PremiumV3' : 'Free'
```

Notice we're also using some new syntax here. Let's break it down:

- `(environmentType == 'prod')` will evaluate to a Boolean (true/false) value depending on what the `environmentType` parameter has been set to.
- `?` is called the _ternary operator_, and it evaluates an _if/then_ statement. The part after the `?` is what is used if the expression is true. If the expression evaluates to false, then the value after the `:` is used.

So these rules can be translated to:

- For the `storageAccountSkuName` variable, if the `environmentType` parameter is set to **prod** then use the _Standard_GRS_ SKU, else use the _Standard_LRS_ SKU.
- For the `appServicePlanSkuName` variable, if the `environmentType` parameter is set to **prod** then use the _P2_v3_ SKU and the _PremiumV3_ tier, else use the _F1_ SKU.

> [!TIP]
> When you create multi-part expressions like this, it's best to use variables rather than embedding the expressions directly into the resource properties. This makes your templates easier to read and understand, since it avoids cluttering your resource definitions with logic.

Now that you have parameters, variables, and expressions in your template, every time your marketing department asks you to deploy a new website for the next toy launch you can just reuse your template and quickly deploy a new set of resources. Just supply some new parameter values for each environment you deploy, and you'll be set!
