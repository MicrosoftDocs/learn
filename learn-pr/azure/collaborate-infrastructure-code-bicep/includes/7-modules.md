Modules are separate Bicep templates, collections of resources deployed together. Modules can be consumed from any other template. They allow you to decompose a single template into several files. By using modules, you can reuse your code easily, and you can make your Bicep files more readable and understandable because they're focused on a specific job. Your main templates then compose multiple modules together. In this unit, you learn about some best practices to consider when you work with large Bicep files and want to consider creating modules.

## The benefits of modules

In your toy company, you've been provisioning cloud resources using lots of individual Bicep templates. It's common for each deployment to use a single large template, especially when you start adopting infrastructure as code. Over time, single templates can grow significantly. Eventually, you probably end up having _monolithic_ code that is difficult to read and navigate and harder to maintain. Additionally, this approach forces you to duplicate parts of your code when you want to reuse it in other templates, and then changing something requires you to search through multiple template files to find the 

Bicep modules help you address these challenges by splitting the code into smaller, more manageable files that can be referenced from multiple templates.

## How do you define a module?

TODO
Module should have a clear purpose/job
Contract - parameters and outputs

Overkill to create a module for every resource, but sometimes a complex resource config might justify a module
More common to create a module that has multiple resources

## How do you identify the resources to split out?



--- TODO below

## Visualize your template

It's a recommended practice to design your modules by grouping resources that are tightly coupled. But how can you get a complete picture covering all resources and their dependencies?

You can use **Bicep Visualizer** to get such an overview. It's a integral part of Bicep extension and it uses Dependency graph to plot diagrams.

1. Open your template in Visual Studio Code,
2. Right-click on the template in the Explorer, and
3. Select 'Open Visualizer' from the drop-down menu.

You should get a similar view when you open our existing template:

:::image type="content" source="../media/3-visualize-template.png" alt-text="A diagram showing all resources from the Bicep template and their dependencies.":::

## Identify clusters of resources

Do you see any resources that belong together and where it would make sense to put them into separate modules?

The template could be divided into two main parts:

- a _web frontend_ with Azure Web App and related components hosting your application
- a _database backend_ with Azure SQL components, where you store your relational data

:::image type="content" source="../media/3-visualize-parts.png" alt-text="A diagram showing two clusters of resources in Bicep Visualizer.":::

## Create the backend module

As you know, there's no specific syntax or a structure for creating a module. Any bicep template can be a module. Modules expose parameters and outputs as a **contract** to other Bicep files. The contract allows you to abstract away implementation details like resource declaration from consumers of your module. They only need to "honor" the module contract when referencing modules in templates.

> [!TIP]
> Find a balance between having single-resource modules and creating complex modules with many resources.

Let's say we want to create a module for our _backend_ and include three resources in it. We create a new file, call it for example `azSQLBackend.bicep` and **move** (extract) the following code section to this module:

::: code language="bicep" source="code/2-template.bicep" range="34-62" :::

It's a good start but our module won't work yet. Thanks to IntelliSense in VS Code, we can immediately see our module is missing several parameters and variables. As a quick fix, we can copy all highlighted parameters and variables from the snippet below to our module:

::: code language="plaintext" source="code/TODO-params-vars.bicep" highlight="1,21,23-24,31-32" :::

The module now declares its contract with three input parameters. Two of them are mandatory, as they don't have any default value.

## Consume the module in your template

When you want to consume this module, create a new code block in your main template (anywhere you like) with the following structure:

```bicep
module backend 'azSQLBackend.bicep' = {
  name: 'sqlBackendDeployment'
  params: {
    location: location
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
  }
}
```

The **Bicep extension supports scaffolding** of code and getting all required properties from a module to the template. When you add a path to your module and continue with `=` sign, a window with several options will appear. Choose "Required properties" option and see what happens.

:::image type="content" source="../media/3-module-scaffold.png" alt-text="Shows an IntelliSense option to scaffold a module with required properties.":::

If you decide to write that piece of code manually, the extension will validate, if you have all required properties in the `params` section. It will warn you, if something is missing:

:::image type="content" source="../media/3-module-validation.png" alt-text="Shows a validation of Bicep code section when a mandatory parameter is missing.":::

  > [!TIP]
  > it's possible to deploy resources from the module across [multiple scopes](https://github.com/Azure/bicep/blob/main/docs/tutorial/06-creating-modules.md#deploying-modules-to-a-different-scope) using the `scope` keyword. For example, if you want to deploy your _backend resources_ to a different Resource Group, you could use: `scope: resourceGroup('someOtherRg')` syntax.

Another benefit of modules is a possibility to declare **outputs** and then reference them in the main template by using `{module_symbolic_name}.outputs.{output_name}` syntax.

If we for example declare `output connString string = sqlserver.properties.fullyQualifiedDomainName` in our backend module, we can reference it in the main template either:

- as a new variable (`var fqdn = backend.outputs.connString`), or
- as an output (`output sqlFqdn string = backend.outputs.connString`)

## Use advanced controls with modules

One of our goals is having a dynamic infrastructure code and avoiding duplicate code or even creating several templates for the same purpose. That's where **conditions and loops** become an important part of your toolbox. You can use these controls both with `resources` and `modules`.

In our previous example, we used a module to deploy a "firewall rule" for Azure SQL, effectively opening the network access from any source IP address. If we want to make this part **optional**, we could:

- introduce a new parameter in the main template: `parameter sqlAnywhereAccess bool = false`,
- modify the template like this:

  ```bicep
  param sqlAnywhereAccess bool = false

  module backend 'azSQLBackend.bicep' = {
    name: 'sqlBackendDeployment'
    params: {
      location: location
      sqlAdministratorLogin: sqlAdministratorLogin
      sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
      firewallRule = sqlAnywhereAccess
    }
  }
  ```

- update the **module file** to add a condition:

  ```bicep
  param firewallRule bool = false

  ...

  resource sqlserverName_AllowAllIps 'Microsoft.Sql/servers/firewallRules@2014-04-01' = if (firewallRule) {
    name: '${sqlserver.name}/AllowAzureIps'
    properties: {
      endIpAddress: '0.0.0.0'
      startIpAddress: '0.0.0.0'
    }
  }
  ```

> [!CAUTION]
> Remember to make sure your template is valid for both scenarios when the `if` statement is evaluated as `true` or `false`.

<!-- TODO make sure to mention the following:

- Conditional deployment - as part of 'known configuration', I was thinking we could have App Insights deployed only for Prod, but not non-Prod config. Since we planned to have this resource in a module (frontend), we could show how 'module contract' can influence conditional deployment within the module. Another example could be 'diagnostics settings' for PaaS resources for Prod environments. It does get complicated with regards to existing vs. new AzMon workspace though
- Ensure unique names for nested deployments (modules) - have a param with utc/utcNow() function and use it as a suffix in all nested deployment names. Also mention how deployment history gets overwritten, if the nested deployment name is "constant"

-->



--- TODO not used

You were asked to review an existing Bicep template and identify opportunities to break the code down into more manageable parts.

This diagram shows what the template deploys:

:::image type="content" source="../media/2-environment-diagram.png" alt-text="Architecture diagram that shows a resource group containing several Azure resources." border="false":::
