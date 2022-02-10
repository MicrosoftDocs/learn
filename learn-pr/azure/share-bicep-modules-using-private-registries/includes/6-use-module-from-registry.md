TODO intro para

## Use a Bicep module

When you've found a module you want to use, you create a *module definition* in your Bicep file:

```bicep
module myModule 'br:myregistry.azurecr.io/modulepath/modulename:moduleversion' = {
  name: 'my-module'
  params: {
    moduleParameter1: 'value'
  }
}
```

Notice that the module definition is similar to that of a local module, but with one important difference. Instead of specifying the path to a Bicep file on your file system, you instead use a special format to tell Bicep that you're referencing a module from a registry:

:::image type="content" source="../media/6-private-module-path.png" alt-text="Diagram showing the module path from the example above." border="false":::

The identifier contains four segments:

- **Scheme**: Bicep supports several types of module, which are called *schemes*. When you work with Bicep registries, the scheme is `br`.
- **Registry**: The name of the registry that contains the module you want to use.
- **Module identifier**: The full path to the module within the registry.
- **Tag**: Tags typically represent versions of modules, because a single module can have multiple versions published. You'll learn more about tags and versions later in this module.

After you've added a reference to the module, Visual Studio Code attempts to automatically download the module from the registry. When the module is downloaded, the Bicep extension for Visual Studio Code gives you IntelliSense and other code authoring assistance as you work.

When you're ready to deploy your Bicep file, you deploy it just like you normally do. Bicep downloads the module from the registry automatically as part of the deployment process.

> [!NOTE]
> You can also separate the module download process from the build by using the `bicep restore` command, and use the `bicep build` command with the `--no-restore` command-line switch to stop the build process from downloading the module. Generally, though, you don't need to do this - just let Bicep download the modules automatically.

## Aliases 

You can use a *registry alias* to simplify your module definitions. Instead of specifying the registry name every time you define a module, you use its alias.

To define an alias, you need to create a *bicepconfig.json* file in the same folder as your Bicep file. Within the *bicepconfig.json* file, you define aliases as in this example:

::: code language="json" source="code/4-bicepconfig-aliases.json" range="1-5, 10-13" :::

When you define a module in a Bicep file, you include the alias in the module path:

```bicep
module myModule 'br/MyRegistry:bicep/my-module:v1' = {
  // ...
}
```

An alias can also include the path to your modules within the registry. This is helpful if you use a common prefix for your modules:

::: code language="json" source="code/4-bicepconfig-aliases.json" range="1-3, 7-13" :::

Then, you can omit the path when you define the module in your Bicep file:

```bicep
module myModule 'br/MyRegistryWithPath:my-module:v1' = {
  // ...
}
```

## Build your Bicep file

TODO talk about transpilation
