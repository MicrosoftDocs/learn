Parameters are the most common way that your colleagues will interact with your template. When someone deploys your template, they need to specify values for the parameters. Once created, a resource's name provides important information about its purpose to anyone who looks at your Azure environment. In this unit, you learn about some key considerations when you're planning the parameters for Bicep files, and the names you give your resources.

## How understandable are the parameters?

Parameters help make Bicep files reusable and flexible. It's important that the purpose of each parameter is clear to anyone who uses it. When your colleagues work with your template, they use parameters to customize the behavior of their deployment.

For example, suppose you need to deploy a storage account by using a Bicep file. One of the required properties of the storage account is the SKU, which defines the level of data redundancy. The SKU has several properties, the most important being `name`. When creating a parameter to set the value for the storage account's SKU, use a clearly defined name like `storageAccountSkuName`. Using this value instead of a generic name like `sku` or `skuName` will help others understand the purpose of the parameter and the effects of setting its value.

Default values are an important way to make your template usable by others. It's important to use default values where they make sense. They help your template's users in two ways:

- They simplify the process of deploying your template. If your parameters have good default values that works for most of your template's users, they can omit the parameter values instead of specifying them every time they deploy the template.
- They provide an example of how you expect the parameter value to look. If the template user needs to choose a different value, the default value can provide useful hints about what their value should look like.

Bicep can also help to validate the input that the user provides through _parameter decorators_. These decorators can be used to provide a parameter description, or state what kinds of values are permitted. Bicep provides several types of parameter decorators:

- **Descriptions** provide human-readable information about the purpose of the parameter, and the effects of setting its value.
- **Value constraints** enforce limits on what the user can enter for the parameter's value. You can specify a list of specific values that are permitted by using the `@allowed()` decorator. You can use the `@minValue()` and `@maxValue()` decorators to enforce the minimum and maximum values for numeric parameters. And you can use the `@minLength()` and `@maxLength()` decorators to enforce the length of string and array parameters.
  > [!TIP]
  > Be careful when you use the `@allowed()` parameter decorator to specify SKUs. Azure services often add new SKUs, and you don't want your template to unnecessarily prohibit their use. Consider using Azure Policy to enforce the use of specific SKUs, and use the `@allowed()` decorator with SKUs only when there are functional reasons why your template's users shouldn't select a specific SKU, like if the features your template needs aren't available in that SKU. Explain this using a `@description()` decorator or comment, to make the reasons clear to anyone in future.
- **Metadata** can be used to provide extra custom metadata about the parameter, although this is not commonly used.

## How flexible should a Bicep file be?

One of the goals of defining your infrastructure as code is to make your templates reusable and flexible. You don't want to create single-purpose templates that have hard-coded configuration. On the other hand, it doesn't make sense to expose all resource properties as parameters. Create templates that work for your specific business problem or solution, not generic templates that need to work for every situation. You also don't want to have so many parameters that it takes a long time for anyone to enter the values so that they can deploy your template. This is particularly important when you configure the SKUs and instance counts of resources.

When you're planning a template, consider how you'll balance flexibility with simplicity. There are two common approaches to providing parameters in templates: providing free-form configuration options, and using predefined sets of configuration. Let's consider both examples, using an example Bicep file that deploys a storage account and an App Service plan.

### Provide free-form configuration options

Both the App Service plan and the storage account require that you specify their SKUs. You might consider creating a set of parameters to control each of the SKUs and instance counts for the resources:

:::image type="content" source="../media/3-free-form-configuration.png" alt-text="Diagram showing a user entering a parameter, which then directly influences the resource definition." border="false":::

Here's how this looks in Bicep:

::: code language="bicep" source="code/3-multiple-parameters.bicep" :::

This format provides the most flexibility, since anyone who uses the template can specify any combination of parameter values they want. However, as you add more resources, you need more parameters. As a result, your template becomes more complicated. Also, you might need to restrict certain combinations of parameters, or ensure that when a specific resource is deployed using one SKU, another resource needs to be deployed using another specific SKU. It's hard to enforce these rules when you provide so many individual parameters.

> [!TIP]
> Think about anyone who will use or work with your template. If they open it and see dozens of parameters, it could be overwhelming and might cause them to abandon using your template.
> 
> You might be able to reduce the number of parameters by grouping related parameters together in form of a parameter object, like this:
>
> ```bicep
> param appServicePlanSku object = {
>   name: 'S1'
>   capacity: 2
> }
> ```
>
> However, this reduces your ability to validate the parameter values, and it's not always easy for your template users to understand how to define the object.

### Use configuration sets

Alternatively, you could provide a _configuration set_: a single parameter, whose value is restricted list of allowed values like a list of environment types. When someone deploys your template, they only need to select a value for this one parameter. By selecting a value for the parameter, the deployment automatically inherits a set of configuration:

:::image type="content" source="../media/3-configuration-map.png" alt-text="Diagram showing a user entering a parameter, which then influences the configuration map variable. The resource definition takes its value from the configuration map." border="false":::

The parameter definition looks like this:

::: code language="bicep" source="code/3-configuration-map.bicep" range="5-9" :::

Configuration sets offer lower flexibility, since anyone who deploys your template can't specify specific sizes for individual resources. But, it means you can validate each set of configurations and ensure they fit your requirements. It reduces the need for your template's users to understand all of the different options available for each resource, and it becomes easier to support, test, and troubleshoot your templates.

When you work with configuration sets, you create a _map_ variable to define the specific properties to set on different resources based on the parameter value:

::: code language="bicep" source="code/3-configuration-map.bicep" range="13-40" :::

Your resource definitions then use the configuration map to define the resource properties:

::: code language="bicep" source="code/3-configuration-map.bicep" range="42-46" highlight="4" :::

Configuration sets can help you to make complex templates more easily accessible, and to enforce your own rules and encourage the use of pre-validated configuration values.

> [!NOTE]
> This approach is sometimes called _t-shirt sizing_. When you buy a t-shirt, you don't get lots of options for its length, width, sleeves, and so forth. You simply choose between small, medium, and large sizes, and the t-shirt designer has predefined those measurements based on that size.

## How are your resources named?

In Bicep, it's important that you give your resources meaningful names. Resources in Bicep have two names:

- **Symbolic names** are only used within the Bicep file and don't appear on your Azure resources. They help anyone who reads or modifies your template to understand the purpose of a parameter, variable, or resource definition, and they help them to make an informed decision about whether to change it.
- **Resource names** are the names of the resources that are created in Azure. Many resources have constraints on their names, and many require their names to be unique.

### Symbolic names

It's important to think about the symbolic names you apply to your resources. Imagine a colleague needs to modify the template - will they understand what each resource is for?

For example, suppose you define a storage account that will contain product manuals for users to download from your website. You could name give the resource a symbolic name of  `storageAccount`, but if it's in a Bicep file that contains lots of other resources - and maybe even other storage accounts - then that name isn't very descriptive. So you could instead give it a symbolic name that includes some information about its purpose, like `productManualStorageAccount`.

In Bicep, you typically use _camel case_ for the names of parameters, variables, and resource symbolic names. This means that you use a lowercase first letter for the first word, and then capitalize the first letter of the other words - like in `productManualStorageAccount`. You're not required to use camel case. If you choose to use a different style, it's important to agree on one standard within your team and use it consistently.

### Resource names

Every Azure resource has a name. Names make up a part of the resource's identifier. In many cases, they also are represented as the hostnames that you use to access the resource. For example, when you create an App Service app named `myapp`, the hostname you use to access the app will be `myapp.azurewebsites.net`. Resources can't be renamed once they're deployed.

It's important to consider how you name your Azure resources. Many organizations define their own resource naming convention. [The Azure Cloud Adoption framework has specific guidance](/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging?azure-portal=true) that can help you define yours. The purpose of a resource naming convention is to help everyone in your organization understand what each resource is for.

Additionally, every Azure resource has certain naming [rules and restrictions](/azure/azure-resource-manager/management/resource-name-rules?azure-portal=true). For example, there are restrictions around the length of names, the characters they can include, and whether names have to be globally unique or just unique within a resource group.

It can be complex to follow all of the naming conventions for your organization as well as the naming requirements for Azure. A well-written Bicep template should hide this complexity from its users and determine the names for resources automatically. One example of an approach to follow is:

- Add a parameter that is used to create a _uniqueness suffix_. This helps to ensure that your resources have unique names. It's a good idea to use the `uniqueString()` function to generate a default value. Someone who deploys your template can override this with a specific value if they want to have a meaningful name. Make sure you use the `@maxLength()` decorator to limit the length of this suffix so that your resource names won't exceed their maximum lengths.
  > [!TIP]
  > It's better to use uniqueness suffixes rather than prefixes. This approach makes it easier to sort and to quickly scan your resource names. Also, some Azure resources have restrictions about the first character of the name, and randomly generated names can sometimes violate these restrictions.
- Use variables to construct resource names dynamically. Your Bicep code can ensure the names it generates follow your organization's naming convention as well as Azure's requirements. Include the uniqueness suffix as part of the resource name.
  > [!NOTE]
  > Not every resource requires a globally unique name. Consider whether you include the uniqueness suffix in the names of every resource, or just those that need it.
