## Module parameters

Think about the parameters your module accepts, and whether each parameter should be optional or required.

When you create parameters for templates, it's a good practice to add default parameters where you can. In modules, it's not always as important to do this since your module will be used by a parent template, which might have its own default parameters it uses. If you have similar parameters in both locations, both with default values, it can be hard for your template's users to reason about which default value will be applied, and to enforce consistency. It's often better to leave the default value on the parent template and remove it from the module.

Similarly, think about how you manage parameters that control the SKUs for your resources and other important configuration. You learned in a previous unit about how a _configuration map_ can help you to embed business rules into your template and simplify your parameter list. Modules present different concerns, though. If a module is reused across multiple deployments, the business rules for each parent template might be different. So, it often doesn't make as much sense to embed configuration maps into modules. Consider using configuration maps in your parent template, and then explicitly pass module configuration through parameters.

## Add conditions to modules

One of our goals with deploying our infrastructure using code like Bicep is to avoid duplicating effort, or even creating several templates for the same or very similar purposes. Bicep's features give us a powerful toolbox to create reusable modules that work for a variety of situations. We can combine features like modules, expressions, default parameter values, and conditions together to build reusable code that gives us the flexibility we need.

Consider an example: you're creating a module that deploys a Cosmos DB account, and when it's deployed to your production environment, you need to configure the Cosmos DB account to send its logs to a Log Analytics workspace. To configure logs to be sent to Log Analytics, you deploy a *diagnosticSettings* resource. You could achieve your requirement by adding a condition to the resource definition, and make the workspace ID parameter optional by adding a default value:

::: code language="bicep" source="code/7-cosmos-db-diagnostic-settings.bicep" highlight="1, 7" :::

When you include this module in a Bicep template, you can easily configure it to send the Cosmos DB account logs to Log Analytics by setting a workspace ID. Or, if you don't need logs for the environment you're deploying, simply omit the parameter. The module encapsulates the logic required to do the right thing for your requirements.

> [!NOTE]
> Remember to make sure your template is valid for both scenarios - when the `if` statement is evaluated as either `true` or `false`.
