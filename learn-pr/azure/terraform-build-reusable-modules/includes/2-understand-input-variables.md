With _input variables_, you can provide information to Terraform at deployment time. You can make a Terraform module flexible and reusable by declaring input variables within your Terraform module.

_Attributes_ provide a way to attach constraints and metadata to an input variable, which helps anyone using your Terraform modules to understand what information they need to provide.

In this unit, you'll learn about input variables and their attributes.

## Declare an input variable

In a Terraform module, you declare an input variable by using a `variable` block. You can put these declarations in any `*.tf` file within the Terraform module's working directory, although it's usually a good idea to put them in a file called `variables.tf` so they are easy to find.

Here's how you declare a input variable:

```hcl
variable "location" {
  type = string
}
```

Let's look at how each part works:

- `variable` indicates to Terraform that you're declaring an input variable.
- `location` refers to the name of the input variable. Although the parameter name can be anything, you should make the name clear and understandable for the Terraform module users. Within the same module, you can also refer to the input variable by using its name and prefixing it with the keyword `var`. Input variable names must be unique. However, they can have the same name as a local variable or a resource in the same Terraform module.

  > [!TIP]
  > Use best practice naming conventions for input variable declarations. Good naming conventions make your templates easy to read and understand. Make sure you're using clear, descriptive names, and adopt consistent naming strategy. By convention, Terraform uses snake case variable names which use underscores to separate word segments. (e.g., `resource_group_name` is used instead of Pascal case equivalent `ResourceGroupName` or camel case equivalent `resourceGroupName`.)

- `type` is the first attribute that we set on this input variable block. It specifies the data structure that is expected by this input variable.
- `string` is the value that we supply to the `type` attribute of the input variable. The other supported types are `number`, `bool`, `list`, or `map`. To find out more about all supported types, please check the official Terraform documentation.

  > [!TIP]
  > Think carefully about the input variables your Terraform module uses. Try to use input variables for settings that will potentially change between different deployments. Locals and hard-coded values can be used for settings that don't change between deployments.

## Add a default value

You can assign default values to input variables in your Terraform modules. By assigning a default value, you're making the input variable optional. If the Terraform module is deployed without a specified value for the input variable, the default value is assigned.

Here's how you add a default value:

```hcl
variable "location" {
  type    = string
  default = "westus"
}
```

The input variable `location` is assigned a default value of `westus`.

> [!TIP]
> Be mindful of the default values you use. Make sure that it'll be safe for someone to deploy the Terraform module with the default values. For example, consider using inexpensive pricing tiers and SKUs so that someone deploying the template to a test environment doesn't incur a large cost unnecessarily. 

> [!TIP]
> Consider _not_ specifying a default value if you want the users of your Terraform module to think carefully about what their desired value should be for an input variable. For example, consider not specifying a default Azure Region as it is a critical decision when making a deployment to Azure.

## Understand parameter types

When you declare an input variable, you need to tell Terraform what type of information the input variable will contain. Terraform will ensure that the value assigned to the input variable is compatible with the input variable type.

Input variables in Terraform can be one of the following types:

- `string`, which lets you enter arbitrary text.
- `number`, which lets you enter a number.
- `bool`, which represents a Boolean (true or false) value.
- `list`, which represents an indexed array of other elements of any type
- `map`, which represents a  keyed dictionary of other elements of any type
- `object`, which represent structured data with one or more attributes of its own.

### Objects

You can use object input variables to combine structured data together in one place. An object can have multiple properties of different types. You can use objects within resource definitions, within variables, or within expressions in your Terraform module. Here's an example of an object:

```hcl
param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
  capacity: 1
}
```

```hcl
variable "app_service_plan" {
  type    = object({
    name = string
    sku  = string
    os   = string
  })
  default = {
    name = "asp-contoso-toys-app"
    sku  = "F1"
    os   = "Linux"
  }
}
```

This input variable is an object with three string properties, `name`, `sku`, and `os`. Notice that we must first declare and `object()` and then define each of the properties is on its own line within curly braces `{}`.

When you reference this input variable in the Terraform module, you can select the individual properties of the object by using a dot followed by the name of the property, like in this example:

:::code language="hcl" source="code/2-plan-object.tf" highlight="10-11":::

**TODO**

> [!IMPORTANT]
> Keep in mind that you don't specify the type of each property within an object. However, when you use a property's value, its type must match what's expected. In the previous example, both the name and the tier of the App Service plan SKU must be strings.

Another example of where you might use an object parameter is for specifying resource tags. You can attach custom tag metadata to the resources that you deploy, which you can use to identify important information about a resource.

Tags are useful for scenarios like tracking which team owns a resource, or when a resource belongs to a production or non-production environment. Typically, you'll use different tags for each environment, but you'll want to reuse the same tag values on all the resources within your template. For this reason, resource tags are a good use for an object parameter, like in this example:

```bicep
param resourceTags object = {
  EnvironmentName: 'Test'
  CostCenter: '1000100'
  Team: 'Human Resources'
}
```

Whenever you define a resource in your Bicep file, you can reuse it wherever you define the `tags` property:

:::code language="bicep" source="code/2-create-resources.bicep" highlight="4,13":::

### Arrays

An array is a list of items. As an example, you might use an array of string values to declare a list of email addresses for an Azure Monitor action group. Or you might use an array of objects to represent a list of subnets for a virtual network.

> [!NOTE]
> You can't specify the type of individual items that an array needs to contain. For example, you can't specify that an array must contain strings.

Let's consider an example. Azure Cosmos DB lets you create database accounts that span multiple regions, and it automatically handles the data replication for you. When you deploy a new database account, you need to specify the list of Azure regions that you want the account to be deployed into. Often, you'll need to have a different list of locations for different environments. For example, to save money in your test environment, you might use only one or two locations. But in your production environment, you might use several locations.

You can create an array parameter that specifies a list of locations:

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
> The preceding example is an array of objects. Each object has a `locationName` property, which is what Azure Cosmos DB expects. When you work with a resource definition in Visual Studio Code, you can start by entering resource properties so that you get IntelliSense from the Bicep tooling. You can create some example values by using this approach. After you're satisfied with the configuration, move that section of Bicep code to the parameter. In this way, you can replace a hard-coded property with a parameter that can be changed during each deployment, while still ensuring that the resource is configured correctly.

When you declare your Azure Cosmos DB resource, you can now reference the array parameter:

:::code language="bicep" source="code/2-create-cosmosdb.bicep" highlight="5":::

It's then easy to use a different parameter value for your development environment by changing the value of the parameter. Soon, you'll learn how you can provide different parameter values without modifying your original template.

## Specify a list of allowed values

Sometimes you need to make sure that a parameter has certain values. For example, your team might decide that production App Service plans should be deployed by using the Premium v3 SKUs. To enforce this rule, you can use the `@allowed` parameter decorator. A _parameter decorator_ is a way of giving Bicep information about what a parameter's value needs to be. Here's how a string parameter named `appServicePlanSkuName` can be restricted so that only a few specific values can be assigned:

```bicep
@allowed([
  'P1v3'
  'P2v3'
  'P3v3'
])
param appServicePlanSkuName string
```

> [!TIP]
> Use the `@allowed` decorator sparingly. If you use this decorator too broadly, you might block valid deployments if you don't keep the list up to date. The preceding example allows for only Premium v3 SKUs in production. If you need to use the same template to deploy some cheaper non-production environments, the list of allowed values might stop you from using other SKUs that you need to use.

## Restrict parameter length and values

When you use string parameters, you often need to limit the length of the string. Let's consider the example of Azure resource naming. All Azure resource types have limits around the length of their names. It's a good practice to specify the minimum and maximum character length for parameters that control naming, to avoid errors later during deployment. You can use the `@minLength` and `@maxLength` decorators to the minimum and maximum character lengths that you want to allow for a parameter.

Here's an example that declares a string parameter named `storageAccountName`, whose length can only be between 5 and 24 characters:

```bicep
@minLength(5)
@maxLength(24)
param storageAccountName string
```

This parameter includes two decorators. You can apply multiple decorators to a parameter by putting each decorator on its own line.

> [!NOTE]
> You can also apply the `@minLength` and `@maxLength` decorators to array parameters, to control how many items are allowed to be in the array.

When you work with numeric parameters, you might need values to be in a particular range. For example, your toy company might decide that whenever anybody deploys an App Service plan, they should always deploy at least one instance, but no more than 10 instances of the plan. To meet the requirements, you can use the `@minValue` and `@maxValue` decorators to specify the minimum and maximum allowed values. The following example declares the integer parameter `appServicePlanInstanceCount` whose value can only be between 1 and 10 (inclusive):

```bicep
@minValue(1)
@maxValue(10)
param appServicePlanInstanceCount int
```

## Add descriptions to parameters

Parameters are a great way to make your templates reusable by other people. When they use your templates, they'll need to understand what each parameter does so they can provide the right values. Bicep provides the `@description` decorator so that you can document your parameters' purpose in a human-readable way.

```bicep
@description('The locations into which this Cosmos DB account should be configured. This parameter needs to be a list of objects, each of which has a locationName property.')
param cosmosDBAccountLocations array
```

It's a good practice to provide descriptions for your parameters. Try to make the descriptions helpful, and provide any important information about what the template needs the parameter values to be.

> [!NOTE]
> Bicep templates can sometimes be made available in the Azure portal for users to deploy, like when you use [template specs](/azure/azure-resource-manager/templates/template-specs). The portal uses the descriptions and other decorators on parameters to help users understand what a parameter value needs to be.
