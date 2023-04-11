Each module that you create should have a clear purpose. Think of a module as having a _contract_. It accepts a set of parameters, creates a set of resources, and might provide some outputs back to the parent template. Whoever uses the module shouldn't need to worry about how it works, just that it does what they expect.

When you plan a module, consider:

- What you need to know to be able to fulfill the module's purpose.
- What anyone who consumes your module will expect to provide.
- What anyone who consumes your module will expect to access as outputs.

## Module parameters

Think about the parameters that your module accepts, and whether each parameter should be optional or required.

When you create parameters for templates, it's a good practice to add default parameters where you can. In modules, it's not always as important to add default parameters, because your module will be used by a parent template that might use its own default parameters. If you have similar parameters in both files, both with default values, it can be hard for your template's users to figure out which default value will be applied and to enforce consistency. It's often better to leave the default value on the parent template and remove it from the module.

You should also think about how you manage parameters that control the SKUs for your resources and other important configuration settings. When you create a standalone Bicep template, it's common to embed business rules into your template. For example: _When I deploy a production environment, the storage account should use the GRS tier_. But modules sometimes present different concerns.

If you're building a module that needs to be reusable and flexible, remember that the business rules for each parent template might be different, so it might not make as much sense to embed business rules into generic modules. Consider defining the business rules in your parent template, then explicitly pass module configuration through parameters.

However, if you create a module that's intended to make it easy for your own organization to deploy resources that fit your specific needs, it makes sense to include business rules to simplify the parent templates.

Whatever parameters you include in your module, ensure that you add a meaningful description by using the `@description` attribute:

::: code language="bicep" source="code/3-params-outputs.bicep" range="1-2" highlight="1" :::

## Use conditions

One of the goals with deploying an infrastructure by using code like Bicep is to avoid duplicating effort, or even creating several templates for the same or similar purposes. Bicep's features give you a powerful toolbox to create reusable modules that work for various situations. You can combine features like modules, expressions, default parameter values, and conditions to build reusable code that gives you the flexibility that you need.

Suppose you're creating a module that deploys an Azure Cosmos DB account. When it's deployed to your production environment, you need to configure the account to send its logs to a Log Analytics workspace. To configure logs to be sent to Log Analytics, you'll define a _diagnosticSettings_ resource.

You could achieve your requirement by adding a condition to the resource definition and making the workspace ID parameter optional by adding a default value:

::: code language="bicep" source="code/3-cosmos-db-diagnostic-settings.bicep" highlight="1, 7" :::

When you include this module in a Bicep template, you can easily configure it to send the Azure Cosmos DB account logs to Log Analytics by setting a workspace ID. Or, if you don't need logs for the environment that you're deploying, omit the parameter. It has a default value. The module encapsulates the logic required to do the right thing for your requirements.

> [!TIP]
> Remember to test that your template is valid for both scenarios; when the `if` statement is evaluated as either `true` or `false`.

## Module outputs

Modules can define outputs. It's a good idea to create an output for the information that the parent template might need to use. For example, if your module defines a storage account, consider creating an output for the storage account's name so that the parent template can access it.

> [!WARNING]
> Don't use outputs for secret values. Outputs are logged as part of the deployment history, so they're not appropriate for secure values. You can instead consider one of the following options:
>
> - Use an output to provide the resource's name. Then the parent template can create an `existing` resource with that name and can look up the secure value dynamically.
> - Write the value to an Azure Key Vault secret. Have the parent template read the secret from the vault when it needs it.

A parent template can use module outputs in variables, can use properties for other resource definitions, or can expose variables and properties as outputs itself. By exposing and using outputs throughout your Bicep files, you can create reusable sets of Bicep modules that can be shared with your team and reused across multiple deployments. It's also a good practice to add a meaningful description to outputs by using the `@description` attribute:

::: code language="bicep" source="code/3-params-outputs.bicep" range="21-22" highlight="1" :::

> [!TIP]
> You can also use dedicated services to store, manage, and access the settings that your Bicep template creates. Key Vault is designed to store secure values. [Azure App Configuration](/azure/azure-app-configuration/overview) is designed to store other (non-secure) values.

## Chain modules together

It's common to create a parent Bicep file that composes multiple modules together. For example, imagine you're building a new Bicep template to deploy virtual machines that use dedicated virtual networks. You could create a module to define a virtual network. You could then take the virtual network's subnet resource ID as an output from that module and use it as an input to the virtual machine module:

::: code language="bicep" source="code/3-chained.bicep" highlight="9, 18" :::

In this example, symbolic names are used for the reference between the modules. This reference helps Bicep to automatically understand the relationships between the modules.

Because Bicep understands there's a dependency, it deploys the modules in sequence:

1. Bicep deploys everything in the `virtualNetwork` module.
1. If that deployment succeeds, Bicep accesses the `subnetResourceId` output value and passes it to the `virtualMachine` module as a parameter.
1. Bicep deploys everything in the `virtualMachine` module.

> [!NOTE]
> When you depend on a module, Bicep waits for the entire module deployment to finish. It's important to remember this when you plan your modules. If you create a module that defines a resource that takes a long time to deploy, any other resources that depend on that module will wait for the whole module's deployment to finish.
