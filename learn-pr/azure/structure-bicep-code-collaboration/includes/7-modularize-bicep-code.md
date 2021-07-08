Modules are separate Bicep templates, collections of resources deployed together. Modules can be consumed from any other template. They allow you to decompose a single template into several files. By using modules, you can reuse your code easily, and you can make your Bicep files more readable and understandable because they're focused on a specific job. Your main templates then compose multiple modules together. In this unit, you learn about some best practices to consider when you work with large Bicep files and want to consider creating modules.

## The benefits of modules

In your toy company, you've been provisioning cloud resources using lots of individual Bicep templates. It's common for each deployment to use a single large template, especially when you start adopting infrastructure as code. Over time, single templates can grow significantly. Eventually, you probably end up having _monolithic_ code that is difficult to read and navigate and harder to maintain. Additionally, this approach forces you to duplicate parts of your code when you want to reuse it in other templates, and then changing something requires you to search through multiple template files to find the 

Bicep modules help you address these challenges by splitting the code into smaller, more manageable files that can be referenced from multiple templates.

## How do you define a module?

Each module you create should have a clear purpose. Think of a module as having a _contract_ - it accepts a set of parameters, creates a set of resources, and might provide some outputs back to the parent template. Whoever deploys the template shouldn't need to worry about _how_ your module works - just that it does what they expect. So, when you plan a module, consider both what you need to know to be able to fulfill the module's purpose, and what anyone who consumes your module will expect to provide and see as outputs.

Generally it's not a good practice to create a module for every resource in your Bicep file. Normally a good Bicep module would define multiple related resources. However, if you have a particularly complex resource with a lot of configuration, it might make sense to create a single module to encapsulate the complexity.

## How do you identify the resources to split out?

Sometimes it's obvious how you should split a large Bicep file - you might have a set of resources that clearly belong together in a module. Other times, it's not as straightforward to determine the resources that should be grouped into a module.

The Bicep visualizer can help you to put your whole Bicep file in perspective. The visualizer is included in the Bicep extension for Visual Studio Code. To view the visualizer, open the Visual Studio Code **Explorer**, then select and hold (or right-click) the Bicep file and select **Open Visualizer**. The visualizer shows a graphical representation of the resources in your Bicep file, and it includes lines between resources to show the dependencies that Bicep detects:

:::image type="content" source="../media/7-visualize-template.png" alt-text="A diagram showing all resources from the Bicep template and their dependencies.":::

Consider whether the visualization illustrates any clusters of resources.

## Extract your resources and other elements to a module

Once you've decided on the resources to extract, move them into a new Bicep file. Make sure you move or copy any parameters, variables, and outputs as well.

> [!TIP]
> Once you've copied your Bicep code into a module, it's a good practice to review the new module file to confirm it still fits with your chosen template style, and that it has a clear set of parameters and outputs.

## Module parameters

Think about the parameters your module accepts, and whether each parameter should be optional or required.

When you create parameters for templates, it's a good practice to add default parameters where you can. In modules, it's not always as important to do this since your module will be used by a parent template, which might have its own default parameters it uses. If you have similar parameters in both locations, both with default values, it can be hard for your template's users to reason about which default value will be applied, and to enforce consistency. It's often better to leave the default value on the parent template and remove it from the module.

Similarly, think about how you manage parameters that control the SKUs for your resources and other important configuration. You learned in a previous unit about how a _configuration map_ can help you to embed business rules into your template and simplify your parameter list. Modules present different concerns, though. If a module is reused across multiple deployments, the business rules for each parent template might be different. So, it often doesn't make as much sense to embed configuration maps into modules. Consider using configuration maps in your parent template, and then explicitly pass module configuration through parameters.

## Filenames

Make sure you use a descriptive filename for each module. The filename effectively becomes the identifier for the module, so it's important that your colleagues can understand what the purpose of the module is just by looking at the filename.

## Use the module in your Bicep template

You use a module within your main Bicep template by using the `module` keyword.

The Bicep extension for Visual Studio Code helps you to _scaffold_ the module declaration, and to enter all of the mandatory parameters that the module expects. When you add a path to your module and continue with `=` sign, a window with several options will appear. Select the **Required properties** option:

:::image type="content" source="../media/7-module-scaffold.png" alt-text="Shows an IntelliSense option to scaffold a module with required properties.":::

Visual Studio Code validates your module's parameter values. If you forget to set a mandatory parameter, it will warn you:

:::image type="content" source="../media/7-module-validation.png" alt-text="Shows a validation of Bicep code section when a mandatory parameter is missing.":::

Remember you can use the outputs that a module exposes within your parent template, too. You can use module outputs in variables, properties for other resource definitions, or even expose them as outputs from your parent template. By exposing and using outputs throughout your Bicep files, you can create reusable sets of Bicep modules that can be shared with your team and reused across multiple deployments.

## Add conditions to modules

One of our goals with deploying our infrastructure using code like Bicep is to avoid duplicating effort, or even creating several templates for the same or very similar purposes. Bicep's features give us a powerful toolbox to create reusable modules that work for a variety of situations. We can combine features like modules, expressions, default parameter values, and conditions together to build reusable code that gives us the flexibility we need.

Consider an example: you're creating a module that deploys a Cosmos DB account, and when it's deployed to your production environment, you need to configure the Cosmos DB account to send its logs to a Log Analytics workspace. To configure logs to be sent to Log Analytics, you deploy a *diagnosticSettings* resource. You could achieve your requirement by adding a condition to the resource definition, and make the workspace ID parameter optional by adding a default value:

::: code language="bicep" source="code/7-cosmos-db-diagnostic-settings.bicep" highlight="1, 7" :::

When you include this module in a Bicep template, you can easily configure it to send the Cosmos DB account logs to Log Analytics by setting a workspace ID. Or, if you don't need logs for the environment you're deploying, simply omit the parameter. The module encapsulates the logic required to do the right thing for your requirements.

> [!NOTE]
> Remember to make sure your template is valid for both scenarios - when the `if` statement is evaluated as either `true` or `false`.
