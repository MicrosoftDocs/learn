Modules are separate Bicep templates, collections of resources deployed together. Modules can be consumed from any other template. They allow you to decompose a single template into several files. By using modules, you can reuse your code easily, and you can make your Bicep files more readable and understandable because they're focused on a specific job. Your main templates then compose multiple modules together.

## The benefits of modules

In your toy company, you've been provisioning cloud resources using lots of individual Bicep templates. It's common for each deployment to use a single large template, especially when you start adopting infrastructure as code. Over time, single templates can grow significantly. Eventually, you probably end up having _monolithic_ code that is difficult to read and navigate and harder to maintain. Additionally, this approach forces you to duplicate parts of your code when you want to reuse it in other templates, and then changing something requires you to search through multiple template files to find the 

Bicep modules help you address these challenges by splitting the code into smaller, more manageable files that can be referenced from multiple templates.

## Create a module

TODO

## Use the module in your Bicep template

You use a module within your main Bicep template by using the `module` keyword.

The Bicep extension for Visual Studio Code helps you to _scaffold_ the module declaration, and to enter all of the mandatory parameters that the module expects. When you add a path to your module and continue with `=` sign, a window with several options will appear. Select the **Required properties** option:

:::image type="content" source="../media/7-module-scaffold.png" alt-text="Shows an IntelliSense option to scaffold a module with required properties.":::

Visual Studio Code validates your module's parameter values. If you forget to set a mandatory parameter, it warns you:

:::image type="content" source="../media/7-module-validation.png" alt-text="Shows a validation of Bicep code section when a mandatory parameter is missing.":::

Remember you can use the outputs that a module exposes within your parent template, too. You can use module outputs in variables, properties for other resource definitions, or even expose them as outputs from your parent template. By exposing and using outputs throughout your Bicep files, you can create reusable sets of Bicep modules that can be shared with your team and reused across multiple deployments.
