Bicep modules enable you create composable, reusable files that define a set of related resources. You then use those modules in your deployment templates. Often, you want to share your Bicep modules with others, or reuse the work that others have shared. In this unit, you'll learn what Bicep registries are, why they're useful for sharing your Bicep code, and how you can use the public Bicep registry.

## Why do you share Bicep modules?

When you work with Bicep, you often use similar resources repeatedly. Also, it's common to create combinations of resources that you deploy in multiple places. Bicep modules provide a convenient way to create reusable Bicep files. Each module typically defines a set of resources with a predefined configuration.

One of the benefits of using modules is that you can share them with others, and you can benefit from the modules that others share with you. For example, you might invest time in building and testing a Bicep file to deploy a set of resources that you often use together. When you share your file as a Bicep module, your colleagues can use the module to quickly deploy the same resources.

A Bicep *registry* is the place that modules are stored and shared. Anyone can create their own registry. Additionally, Microsoft runs a public registry that the Bicep community uses to share modules. In future, registries will support more types of Bicep content in addition to modules.

## How do registries compare to template specs?

Azure Resource Manager also enables you to save an Azure Resource Manager template (ARM template) as a *template spec*. This is a way of making your templates reusable and sharing them through your organization. Modules stored in Bicep registries and template specs are both ways of adding reusability to your deployment code, but they're optimized for different things:

- Bicep modules are intended to be combined into a larger deployment. Template specs are designed to be deployable as a complete template. You can deploy template specs by using Azure portal as well as tooling like the Azure CLI and Azure PowerShell. However, if you have created a template spec, Bicep also enables to use it as a module if you want.
- Microsoft maintains a publicly accessible Bicep registry is a publicly accessible service, and you can create your own Bicep registries within or outside of Azure. Template specs are stored in Azure as resources.
- Template specs provide access control capabilities. When you work with a private registry, you need to control the access to your modules in other ways. You'll learn more about this later in the module.

When you're deciding between template specs and Bicep modules, a good rule of thumb is: if the template is going to be deployed as is throughout your organization, template specs are probably a good fit. But if you're likely to reuse this template within multiple parent templates, Bicep modules might serve your needs better, and a registry is a good way to share modules.

## The Bicep public registry

Microsoft maintains a publicly accessible registry for all Bicep users to use. The registry contains modules for many commonly deployed Azure services, and anyone in the community can contribute a module if they think it will be useful to others. Microsoft reviews each submitted module for quality control purposes. You can also inspect each module before you use it.

TODO more info on how to find modules in MCR. Check if it's searchable through Docker Hub (https://hub.docker.com/publishers/microsoftowner)

> [!TIP]
> If you create a Bicep module that you think other people in the community might use, you can contribute it to the Bicep registry. We link to more information in the summary.

## Use a Bicep module

When you've found a module you want to use, you create a *module definition* in your Bicep file:

```bicep
module myModule 'br:mcr.microsoft.com/modulepath/modulename:moduleversion' = {
  name: 'my-module'
  params: {
    moduleParameter1: 'value'
  }
}
```

Notice that the module definition is similar to that of a local module, but with one important difference. Instead of specifying the path to a Bicep file on your file system, you instead use a special format to tell Bicep that you're referencing a module from a registry:

:::image type="content" source="../media/2-mcr-module-path.png" alt-text="Diagram showing the module path from the example above." border="false":::

The identifier contains four segments:

- **Scheme**: Bicep supports several types of module, which are called *schemes*. When you work with Bicep registries, the scheme is `br`.
- **Registry**: The name of the registry that contains the module you want to use.
- **Module identifier**: The full path to the module within the registry.
- **Tag**: Tags typically represent versions of modules, because a single module can have multiple versions published. You'll learn more about tags and versions later in this module.

After you've added a reference to the module, Visual Studio Code attempts to automatically download the module from the registry. When the module is downloaded, the Bicep extension for Visual Studio Code gives you IntelliSense and other code authoring assistance as you work.

When you're ready to deploy your Bicep file, you deploy it just like you normally do. Bicep downloads the module from the registry automatically as part of the deployment process.

> [!NOTE]
> You can also separate the module download process from the build by using the `bicep restore` command, and use the `bicep build` command with the `--no-restore` command-line switch to stop the build process from downloading the module. Generally, though, you don't need to do this - just let Bicep download the modules automatically.