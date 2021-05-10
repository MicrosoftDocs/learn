_Parameters_ enable you to provide information to a Bicep template at deployment time. You can make a Bicep template flexible and reusable by declaring parameters within your template. _Decorators_ provide a way to attach constraints and metadata to a parameter, which helps anyone using your templates to understand what information they need to provide. In this unit, you'll learn about parameter and decorators.

## Declare a parameter

In a Bicep template, you can declare a parameter by using the `param` keyword. You can put these declarations anywhere in the template file, although it's usually a good idea to put them at the top of the file so your Bicep code is easy to read.

Here's how you declare a parameter:

```bicep
param environmentName string
```

Let's look at how each part of this works:

- `param` indicates to Bicep that you're declaring a parameter.
- `environmentName` refers to the name of the parameter. While the parameter name can be anything, you should make the name clear and understandable for the template users. Within the same template, you can also refer to the parameter using its name. Parameter names have to be unique, and they can't have the same name as a variable or a resource in the same Bicep file.

  > [!TIP]
  > It's important to use good naming for parameter declarations. Good names make your templates easy to read and understand. Make sure you're using clear, descriptive names, and be consistent in your naming.

- `string` refers to the type of the parameter.

> [!TIP]
> You should think carefully about the parameters your template uses. Try to use parameters for settings that vary between deployments. Instead of parameters, you can use variables or even hard-coded values for properties that won't change.

## Add a default value

You can optionally assign a default value for a parameter. By specifying a default value, you're effectively making the parameter optional. If the user deploying the template doesn't specify a value to use, then Bicep will use the default value you assigned.

Here's how you add a default value:

```bicep
param environmentName string = 'dev'
```

The parameter `environmentName` is assigned a default value of `dev`.

You can use expressions as default values. Here's an example of a string parameter named `location` whose default value is set to the location of the current resource group:

```bicep
param location string = resourceGroup().location
```

## Understand parameter types

You need to tell Bicep what type of information each parameter will contain. When a value is assigned to a parameter, Bicep ensures the value is compatible with the parameter's type.

Parameters in Bicep have one of the following types:

- `string`, which lets you enter arbitrary text.
- `int`, which lets you enter a number.
- `bool`, which represents a Boolean (true or false) value.
- `object` and `array`, which represent structured data and lists.

### Objects

Object parameters enable you to collect structured data together in one place. An object can have multiple properties, each of different types. You can use objects within resource definitions, or within variables or expressions in your Bicep file. Here's an example of an object:

```bicep
param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
}
```

This parameter is an object with two properties: `name` and `tier`, each of which are strings. Notice that each of the properties is on its own line.

> [!NOTE]
> You can't specify the properties that an object needs to contain.

When you refer to the parameter, you can refer just to individual properties of the object by using a dot and then the property name:

:::code language="plaintext" source="code/2-plan-sku.bicep" highlight="5-6":::

Another example of where you might use an object parameter is for specifying resource tags. Azure allows you to attach custom tag metadata to the resources that you deploy, which you can use for identifying important information about a resource. Tags are useful for scenarios like tracking which team owns a resource, and whether a resource is for a production or non-production environment. Typically you'll use different tags for each environment, but you'll want to reuse the same tag values on all the resources within your template. This means resource tags are a good use for an object parameter, like this:

```bicep
param resourceTags object = {
  EnvironmentName: 'Test'
  CostCentre: '1000100'
  Team: 'Human Resources'
}
```

Then, whenever you define a resource in your Bicep file, you can reuse it wherever you define the `tags` property:

:::code language="plaintext" source="code/2-create-resources.bicep" highlight="4,13":::

### Arrays

An array is a list of items. Each item has one of the other Bicep types. You might use an array of strings to specify a list of email addresses to configure in an Azure Monitor action group for alerts, or an array of objects to represent a list of subnets for a virtual network.

> [!NOTE]
> You can't specify the type of individual items that an array needs to contain.

Let's consider an example. Azure Cosmos DB lets you create database accounts that span multiple regions, and Cosmos DB automatically handles the data replication for you. When you deploy a new database account, you need to specify the list of Azure regions that you want the account to be deployed into. Often, you'll need to have a different list of locations for different environments. For example, to save money in your test environment you might only use one or two locations, but in your production environment you might use several. You can create an array parameter that specifies a list of locations:

```bicep
param cosmosDBAccountLocations array = [
  {
    locationName: 'australiaeast'
  }
  {
    locationName: 'southcentralus'
  }
  {
    locationName: 'westeurope'
  }
]
```

> [!TIP]
> Notice this is an array of objects, and each object has a `locationName` property. This is what Cosmos DB expects. When you're working with a resource definition in Visual Studio Code, you can start by typing in resource properties so that you get IntelliSense from the Bicep tooling. You can create some example values using this approach, and once you're satisfied with the configuration, then you can move that section of Bicep code to the parameter. This allows you to replace a hard-coded property with a parameter that can be changed during each deployment, while still ensuring that the resource is configured correctly.

When you declare your Cosmos DB resource, you can now reference the array parameter:

:::code language="plaintext" source="code/2-create-cosmosdb.bicep" highlight="5":::

It's then easy to use a different parameter value for your development environment by changing the value of the parameter. Soon, you'll see how you can provide different parameter values without modifying your original template.

## Specify a list of allowed values

Sometimes you need to make sure that a parameter has certain values. For example, your team might decide that production App Service plans should be deployed using the Premium v3 SKUs. To enforce this rule, you can use the `@allowed` parameter decorator. A *parameter decorator* is a way of giving Bicep information about what a parameter's value needs to be. Here's how a string parameter named `appServicePlanSkuName` can be restricted so that only a few specific values can be assigned:

```bicep
@allowed([
  'P1v3'
  'P2v3'
  'P3v3'
])
param appServicePlanSkuName string
```

> [!TIP]
> You should use the `@allowed` decorator sparingly. If you do this too broadly, you might block valid deployments if you don't keeping the list up to date. The above example allows for only Premium v3 SKUs in production. However, if you need to use the same template to deploy some cheaper non-production environments, the list of allowed values might stop you from using other SKUs that you need to use.

## Restrict parameter length and values

When you use string parameters, you often need to limit the length of the string. Let's consider the example of Azure resource naming. All Azure resource types have limits around the length of their names. It's a good practice to specify the minimum and maximum character length for parameters that control naming, to avoid errors later during deployment. You can use the `@minLength` and `@maxLength` decorators to the minimum and maximum character lengths that you want to allow for a parameter.

Here's an example that declares a string parameter named `storageAccountName`, whose length can only be between 5 and 24 characters:

```bicep
@minLength(5)
@maxLength(24)
param storageAccountName string
```

Notice that this parameter includes two decorators. You can apply multiple decorators to a parameter by putting each decorator on its own line.

> [!NOTE]
> You can also apply the `@minLength` and `@maxLength` decorators to array parameters.

When you work with numeric parameters, you might need values to be in a particular range. For example, your toy company might decide that whenever anybody deploys an App Service plan, they should always deploy at least one instance, but no more than 10 instances of the plan. To meet the requirements, you can use the `@minValue` and `@maxValue` decorators to specify the minimum and maximum allowed values. The following example declares an integer parameter `appServicePlanInstanceCount` whose value can only be between 1 and 10 (inclusive):

```bicep
@minValue(1)
@maxValue(10)
param appServicePlanInstanceCount int
```

## Add descriptions to parameters

Parameters are a great way to make your templates reusable by other people. When other people try to use your template, they'll need to understand what each parameter does so that they can provide the right values for their particular situation. Bicep provides the `@description` decorator so that you can provide this information:

```bicep
@description('The locations into which this Cosmos DB account should be configured. This parameter needs to be a list of objects, each of which has a locationName property.')
param cosmosDBAccountLocations array
```

It is a good practice to provide descriptions for your parameters. Try to make the descriptions helpful and provide any important information about what the template needs the parameter values to be.

> [!NOTE]
> Bicep templates can sometimes be made available in the Azure portal for users to deploy, like when you use [template specs](/azure/azure-resource-manager/templates/template-specs). The portal will use the descriptions and other decorators on parameters to help users understand what a parameter value needs to be.
