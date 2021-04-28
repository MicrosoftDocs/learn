_Parameters_ lets you bring values in from outside of the template file. For example, if a user is manually deploying the template using the Azure CLI or PowerShell, the user will be asked to provide values for each parameter. You can make a Bicep template flexible and reusable by declaring parameters within your template.

_Decorators_ provide a way to attach constrains and metadata to a parameter. Place decorators above the parameters that you want to modify.

The HR department at your toy company is migrating an on-premises web application to Azure. The application will handle information about all of the employees of the toy company, so security is important. You need to deploy this infrastructure across three environments. By using parameter declarations and decorators, you make your Bicep template flexible and reusable. Decorators allow you to control the input parameters and even protect sensitive parameters.

In this unit, you'll learn about parameter and decorators. You can apply the learning from this unit to make your templates flexible and reusable.

## Parameter declarations

In a Bicep template, you can declare a parameter by using the `param` keyword. You can make these declarations anywhere in the template file. They can be mixed with any other valid declarations in any order and they do not have to appear at the top of the file.

> [!TIP]
> It's important to use good naming for parameter declarations. Good names make your templates easy to read and understand. Make sure you're using clear, descriptive names, and be consistent in your naming.

> [!NOTE]
> A parameter cannot have the same name as a variable, resource, or another parameter.

Here's how you can declare a parameter:

```bicep
param environmentName string
```

Let's look at how each part of this works:

- `param` indicates to Bicep that you're declaring a parameter.
- `environmentName` refers to the name of the parameter. While the parameter name can be anything, you should make the name clear and understandable for the template users. Within the same template, you can also refer to the parameter using its name.
- `string` refers to the type of the parameter.

> [!TIP]
> You should think carefully about the parameters your template uses. You should reserve the use of parameters for only settings that vary according to the environment, like SKU, size, or capacity. Instead of parameters, you can use variables or literal values for properties that don't need to be specified during each deployment.

## Default values

You can optionally assign a default value for a parameter. By specifying a default value, you're effectively making the parameter optional. During a deployment, users can specify a value if they want. Bicep will use the default value if the parameter value isn't provided.

Here's how you add a default value:

```bicep
param environmentName string = 'dev'
```

The parameter `environmentName` is assigned a default string value `dev`.

You may use expressions with the default value. Here is an example of a string parameter `location` whose default value is set to the location of the current resource group:

```bicep
param location string = resourceGroup().location
```

## Types

Bicep parameters must be assigned a type. When a value is assigned to a parameter, Bicep compares the value against its type. If the types are not compatible, Bicep outputs warnings or errors.

Parameters in Bicep have one of the following types:

### Simple types

| Name | Description |
|:-|:-|
| `string` | Represents arbitrary text. |
| `int` | Represents a number. |
| `bool` | Represents a boolean `true`/`false` value. |

### Objects

Object parameters allow you to collect structured data in a single construct. An object can have multiple properties, each of different types. You can use objects within resource definitions, or within variables or expressions in your Bicep file.

One example of where you might use an object parameter is for specifying resource tags. Azure allows us to attach custom tag metadata to the resources that we deploy, which we can use for identifying important information about a resource like what team owns it and whether it's a production or non-production resource. Typically we'll want to use different tags for each environment, but we want to reuse the same tag values on all the resources within our template.

We can specify an object parameter like this:

```bicep
param resourceTags object = {
  EnvironmentName: 'Test'
  CostCentre: '1000100'
  Team: 'Human Resources'
}
```

Then, whenever we define a resource in our Bicep file, we can reference it:

:::code language="plaintext" source="code/2-create-resources.bicep" highlight="2-4,11-13":::

### Arrays

An array is a list of items. You might use an array to collect a list of subnets for a virtual network, or a set of property values to set against a resource.

Let's consider an example. Azure Cosmos DB lets you create database accounts that span multiple regions, and Cosmos DB automatically handles the data replication for you. When you deploy a new database account you need to specify the list of locations (Azure regions) that you want the account to be deployed into. Often, you will need to have a different list of locations for different environments. For example, to save money in your test environment you might only use one location, but in your production environment you might use several. We can create an array parameter that lets us specify a list of locations:

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
> Notice this is an array of objects, and each object has a `locationName` property. This is what Cosmos DB expects. In Visual Studio Code, you can start by typing in resource properties so that you get IntelliSense from the tooling. Once you're satisfied with the configuration, then you can move that section of Bicep code to the parameter. This allows you to substitute a hard-coded property for a parameter that can be changed during each deployment, while still ensuring that the resource is configured correctly.

When we declare our Cosmos DB resource, we can now reference the array parameter:

:::code language="plaintext" source="code/2-create-cosmosdb.bicep" highlight="5":::

## Allowed values

You may want to limit values that can be assigned to a parameter. For example, your team has decided that production App Service plans should be deployed using the Premium v3 SKUs. To enforce this rule, you may declare a parameter with a `@allowed` decorator.

Here is how a string parameter `appServicePlanSkuName` whose allowed only P1V3, P2V3, and P3V3 value to be assigned:

```bicep
@allowed([
  'P1V3'
  'P2V3'
  'P3V3'
])
param appServicePlanSkuName string
```

> [!TIP]
> You should use the `@allowed` decorator sparingly. If you do this too broadly, you might block valid deployments if you don't keeping the list up to date. The above example allows for only Premium v3 SKUs in production. However, you need to use the same template to deploy across other environments. You may want to use cheaper SKU in non-production environments, but the list of allowed values will stop you from doing so.

## Length and value constraints

All Azure resources have naming rules and restrictions, including character length. It's a good practice to specify minimum and maximum characters length for a parameter to avoid errors later during deployment. In some cases, a business may want to apply its own naming policy. Your company requires that all resources are given names between 5 and 50 characters long. You may use `@minLength` decorator to specify a minimum character length and `@maxLength` for a maximum character length.

Here is an example that declares a string parameter `resourceName` whose length can only be between 5 and 50 characters (inclusive):

```bicep
@minLength(5)
@maxLength(50)
param resourceName string
```

> [!NOTE]
> Only parameters of type string and array can have length constraints.

When you work with numeric parameters, you may need to restrict the values that can be assigned. For example, your toy company has decided that whenever anybody deploys an App Service plan, they should always deploy at least two instances, but no more than ten instances of the plan. To meet the requirements, you can use decorator `@minValue(n)` to specify a minimum value and `@maxValue(n)` for a maximum value.

The following example declares an integer parameter `appServicePlanInstanceCount` whose value can only be 2 and 10 (inclusive).

```bicep
@minValue(2)
@maxValue(10)
param appServicePlanInstanceCount  int
```

> [!NOTE]
> Only parameters of type `integer` can have value constraints.

> [!IMPORTANT]
> Both value and length constraints are evaluated when the template is deployed. This means that if you provide a value that under or above the constraint, an error will not occur until you try to deploy the template.

## Descriptions

It is a good practice to provide descriptions for your parameters, to help users of your template understand what the parameters are for and what values they need to provide.  Bicep templates can sometimes be made available in the Azure portal for users to deploy. When descriptions and other decorators are added to parameters, the portal can show this to users who are deploying the template. You can use the `@description` decorator to associate a description with a parameter.

Here is how to associate a description with a parameter using `@description`:

```bicep
@description('SKU Name of App Service Plan.')
param appServicePlanSkuName string
```

> [!TIP]
> It's good practice to add a description for every parameter.

## Combined decorators

Now that you just learnt six different parameter decorators: `@allowed`, `@minLength`, `@maxLength`, `@minValue`, `@maxValue`, and `@description`. Bicep allows these decorators to be combined together under a single parameter declaration.

Here is an example showing combined decorators:

```bicep
@minValue(2)
@maxValue(10)
@description('Number of App Service Plan Instance to run at all times.')
param appServicePlanInstanceCount int
```