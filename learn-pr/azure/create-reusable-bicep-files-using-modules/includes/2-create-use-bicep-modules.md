Modules are independent Bicep files. They typically contain sets of resources that are deployed together. Modules can be consumed from any other Bicep template. By using modules, you can reuse your Bicep code easily, and you can make your Bicep files more readable and understandable because they're each focused on a specific job. Your main templates then compose multiple modules together.

## The benefits of modules

In your toy company, you've been provisioning cloud resources by using numerous individual Bicep files. Over time, these templates grow significantly. Eventually, you probably end up having monolithic code that is difficult to read and navigate, and even harder to maintain. Additionally, this approach forces you to duplicate parts of your code when you want to reuse it in other templates. When you change something, you need to search through multiple files and update them all.

Bicep modules help you address these challenges by splitting your code into smaller, more manageable files that can be referenced from multiple templates. Modules give you some key benefits.

### Reusability

After you've created a module, you can reuse it in multiple Bicep files, even if they're for different projects or workloads. For example, when you build out one solution, you might create separate modules for the app components, the database, and the network-related resources. Then, when you start to work on another project with similar network requirements, you can reuse the relevant module:

:::image type="content" source="../../build-first-bicep-template/media/7-templates-modules.png" alt-text="TODO" border="false"::: <!-- TODO move to include file -->

### Encapsulation

Modules help you to keep related resource definitions together. For example, when you define an Azure Functions app, you typically deploy the function app, a hosting plan for the app, and a storage account for the function app's metadata. These three components are defined separately, but they represent a logical grouping of resources, so it might make sense to define them as a module. Then, your main template doesn't need to be aware of the details of how a function app is deployed - that's the responsibility of the module.

### Functionality

Occasionally, you might need to use modules to access certain functionality. For example, suppose you submit a subscription-scoped deployment and want to also deploy some resources to a resource group in the same deployment. You need to use a module when you define the resources that should be deployed to the resource group.

## Create a module

A module is a normal Bicep file, so you create it just like you do any other Bicep file.

Generally it's not a good practice to create a module for every resource you deploy. A good Bicep module typically defines multiple related resources. However, if you have a particularly complex resource with a lot of configuration, it might make sense to create a single module to encapsulate the complexity in a module.

### Split an existing Bicep template into modules

You might build up a large Bicep template and then decide that it should be split up into modules. Sometimes it's obvious how you should split a large Bicep file. You might have a set of resources that clearly belong together in a module. Other times, it's not as straightforward to determine the resources that should be grouped into a module.

The Bicep visualizer can help you to put your whole Bicep file in perspective. The visualizer is included in the Bicep extension for Visual Studio Code. To view the visualizer, open the Visual Studio Code Explorer, then select and hold (or right-click) the Bicep file and select **Open Visualizer**. The visualizer shows a graphical representation of the resources in your Bicep file, and it includes lines between resources to show the dependencies that Bicep detects:

TODO screenshot of visualizer

You can use the visualizer to help you to split your files up. Consider whether the visualization illustrates any clusters of resources. These might make sense to be moved into a module together.

### Filenames

Make sure you use a descriptive filename for each module. The filename effectively becomes the identifier for the module, so it's important that your colleagues can understand what the purpose of the module is just by looking at the filename.

## Use the module in a Bicep template

You use a module within a Bicep template by using the `module` keyword, like this:

```bicep
module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}
```

## Deployments

<!-- TODO -->
- What is a deployment?
- Each module is its own deployment
- Modules need a name, which becomes the deployment name
- Diagram might help here
