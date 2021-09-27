Modules are independent Bicep files. They typically contain sets of resources that are deployed together. Modules can be consumed from any other Bicep template. By using modules, you can reuse your Bicep code easily, and you can make your Bicep files more readable and understandable because they're each focused on a specific job. Your main templates then compose multiple modules together.

## The benefits of modules

In your toy company, you've been provisioning cloud resources by using numerous individual Bicep files. Over time, these templates grow significantly. Eventually, you probably end up having monolithic code that is difficult to read and navigate, and even harder to maintain. Additionally, this approach forces you to duplicate parts of your code when you want to reuse it in other templates. When you change something, you need to search through multiple files and update them all.

Bicep modules help you address these challenges by splitting your code into smaller, more manageable files that can be referenced from multiple templates. Modules give you some key benefits.

### Reusability

After you've created a module, you can reuse it in multiple Bicep files, even if they're for different projects or workloads. For example, when you build out one solution, you might create separate modules for the app components, the database, and the network-related resources. Then, when you start to work on another project with similar network requirements, you can reuse the relevant module:

:::image type="content" source="../../includes/media/bicep-templates-modules.png" alt-text="Diagram showing a template referencing 3 modules - application, database, and networking. The networking module is then reused in another template." border="false":::

You can even share modules within your team, your organization, or with the Azure community. You'll learn more about sharing Bicep modules in a future Microsoft Learn module.

### Encapsulation

Modules help you to keep related resource definitions together. For example, when you define an Azure Functions app, you typically deploy the function app, a hosting plan for the app, and a storage account for the function app's metadata. These three components are defined separately, but they represent a logical grouping of resources, so it might make sense to define them as a module. Then, your main template doesn't need to be aware of the details of how a function app is deployed - that's the responsibility of the module.

### Composability

After you've created a set of modules, you can compose them together. For example, you might create a module that deploys a virtual network, and another module that deploys a virtual machine. You define parameters and outputs for each module so that you can take the important information from one and send it to another:

:::image type="content" source="../media/2-compose.png" alt-text="Diagram showing a template referencing 2 modules and passing the output from one to the parameter of another." border="false":::

> [!TIP]
> It's helpful to think of Bicep modules as building blocks, which can be combined together in different ways to support your deployments.

### Functionality

Occasionally, you might need to use modules to access certain functionality. For example, suppose you submit a subscription-scoped deployment and want to also deploy some resources to a resource group in the same deployment. You need to use a module when you define the resources that should be deployed to the resource group. Or, if you want to deploy multiple copies of a set of resources, then you can use a module loop to do this.

## Create a module

A module is a normal Bicep file, so you create it just like you do any other Bicep file.

Generally it's not a good practice to create a module for every resource you deploy. A good Bicep module typically defines multiple related resources. However, if you have a particularly complex resource with a lot of configuration, it might make sense to create a single module to encapsulate the complexity in a module. This keeps your main templates simple and uncluttered.

### Split an existing Bicep template into modules

You might build up a large Bicep template and then decide that it should be split up into modules. Sometimes it's obvious how you should split a large Bicep file. You might have a set of resources that clearly belong together in a module. Other times, it's not as straightforward to determine the resources that should be grouped into a module.

The Bicep visualizer can help you to put your whole Bicep file in perspective. The visualizer is included in the Bicep extension for Visual Studio Code. To view the visualizer, open the Visual Studio Code Explorer, then select and hold (or right-click) the Bicep file and select **Open Visualizer**. The visualizer shows a graphical representation of the resources in your Bicep file, and it includes lines between resources to show the dependencies that Bicep detects. You can use the visualizer to help you to split your files up. Consider whether the visualization illustrates any clusters of resources. These might make sense to be moved into a module together.

For example, consider this visualization for a Bicep file. There are two distinct sets of resources defined. It might make sense to group them into separate *database* and *networking* modules:

# [Visualizer](#tab/visualizer)

:::image type="content" source="../media/2-visualizer.png" alt-text="Screenshot of the Bicep visualizer.":::

# [Grouping](#tab/grouping)

:::image type="content" source="../media/2-visualizer-annotated.png" alt-text="Screenshot of the Bicep visualizer with the resources grouped into a databases module and a networking module.":::

---

### Nest modules

Modules can include other modules. By doing this, you can create some modules that deploy small sets of resources, and compose these into larger modules that define complex topologies of resources. A template then combines these pieces into a deployable artifact.

> [!TIP]
> Although it's possible to nest multiple layers of modules, it can get complex to do so. If you get an error or something else goes wrong, it's harder to work out what you need to fix when you have many layers of nesting.
>
> For complex deployments, sometimes it makes sense to use deployment pipelines to deploy multiple templates instead of creating a single template that does everything with nesting. You'll learn more about deployment pipelines in a future Microsoft Learn module.

### Filenames

Make sure you use a descriptive filename for each module. The filename effectively becomes the identifier for the module, so it's important that your colleagues can understand what the purpose of the module is just by looking at the filename.

## Use the module in a Bicep template

You use a module within a Bicep template by using the `module` keyword, like this:

```bicep
module appModule 'modules/app.bicep' = {
  name: 'myApp'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}
```

A module definition includes the following components:

- The `module` keyword.
- A symbolic name. This name is used within this Bicep file whenever you want to refer to the module. The symbolic name never appears in Azure.
- The module path. This is typically the path to a Bicep file on your local file system. In a future Microsoft Learn module, you'll learn about how you can share modules by using registries and template specs, which have their own module path formats.
  > [!TIP]
  > You can also use a JSON ARM template as a module. This can be helpful if you have a set of templates that you haven't yet migrated to Bicep.
- The `name` property, which specifies the name of the deployment. You'll learn more about deployments in the next section.
- The `params` property, where you can specify values for the parameters that the module expects. You'll learn more about module parameters in the next unit.

## How modules work

Although it's not necessary to understand how modules work in order to use them, it can help you to investigate problems with your deployments or to explain unexpected behavior.

### Deployments

In Azure, a *deployment* is a special resource that represents a deployment operation. Deployments are Azure resources that have the resource type `Microsoft.Resources/deployments`. When you submit a Bicep deployment, you create or update a deployment resource. Similarly, when you create resources in the Azure portal, the portal creates a deployment resource on your behalf. However, not all changes to Azure resources create or use deployments. For example, when you use the portal to modify an existing resource, it generally doesn't create a deployment to make the change, and when you use third-party tools like Terraform to deploy or configure your resources, they might  not create deployments.

When you deploy a Bicep file by using the Azure CLI or Azure PowerShell, you can optionally specify the name of the deployment. If you don't specify a name, the Azure CLI or Azure PowerShell automatically creates a deployment name for you from the filename of the template. For example, if you deploy a file named *main.bicep*, the default deployment name is `main`.

When you use modules, Bicep creates a separate deployment for every module. The `name` property that you specify for the module becomes the name of the deployment. This means that when you deploy a Bicep file containing a module, multiple deployment resources are created - one for the parent template, and one for each module.

For example, suppose you create a Bicep file named *main.bicep*. It defines a module named `myApp`. When you deploy the *main.bicep* file, two deployments are created. The first one is named `main`, and it creates another deployment named `app` that contains your application resources:

:::image type="content" source="../media/2-deployments.png" alt-text="Diagram that shows two Bicep files, each of which has a separate deployment name." border="false":::

You can list and view the details of deployment resources to monitor the status of your Bicep deployments, or to view history of deployments. However, when you reuse the same name for a deployment, Azure overwrites the last deployment with the same name. If you need to maintain the deployment history, ensure that you use unique names for every deployment, including every time you deploy a module. You'll see how to do this in the exercise.

### Generated JSON ARM templates

When you deploy a Bicep file, Bicep converts it to a JSON ARM template. This is also called *transpilation*. The modules it uses are embedded into the JSON file. Regardless of how many modules you include in your template, only a single JSON file will be created.

In the example discussed in the previous section, Bicep generates a single JSON file even though there were originally two Bicep files:

:::image type="content" source="../media/2-transpile.png" alt-text="Diagram that shows two Bicep files, which are transpiled into a single JSON file." border="false":::
