You've learned how to publish modules into a private registry. In this unit, you'll learn how to use modules that are already in a registry as part of a Bicep template.

## Use a Bicep module

When you've found a module that you want to use, you create a _module definition_ in your Bicep template. Here's an example:

```bicep
module myModule 'br:myregistry.azurecr.io/modulepath/modulename:moduleversion' = {
  name: 'my-module'
  params: {
    moduleParameter1: 'value'
  }
}
```

Notice that the module definition is similar to that of a local module, but with one important difference. Instead of specifying the path to a Bicep file on your file system, you include the path to your module in your registry.

After you've added a reference to the module, Visual Studio Code tries to automatically download the module from the registry. When the module is downloaded, the Bicep extension for Visual Studio Code gives you IntelliSense and other code-authoring assistance as you work.

## Aliases

You can use a _registry alias_ to simplify your module definitions. Instead of specifying the registry name every time you define a module, you use its alias. Aliases help you in a few ways:

- They can keep your Bicep file tidier and help you avoid typing the full name of the registry repeatedly.
- If you change to a new registry in the future, you can update the alias instead of updating every reference to it.
- Some organizations need to use different registries for different situations, like for development and production environments. You can switch the registry that an alias refers to by modifying a configuration file. The change then applies to all Bicep files in the folder.

To define an alias, you need to create a _bicepconfig.json_ file in the same folder as your Bicep file. Within the _bicepconfig.json_ file, you define aliases as in this example:

::: code language="json" source="code/6-bicepconfig-aliases.json" range="1-5, 10-13" :::

When you define a module in a Bicep file, you use a slightly different type of module path, which includes the alias:

```bicep
module myModule 'br/MyRegistry:bicep/my-module:v1' = {
  // ...
}
```

> [!TIP]
> Notice that the beginning of the path is `br/` when you use an alias and `br:` when you don't.

An alias can also include the path to your modules within the registry, which is helpful if you use a common prefix for your modules:

::: code language="json" source="code/6-bicepconfig-aliases.json" range="1-3, 7-13" :::

Then, you can omit the path when you define the module in your Bicep file:

```bicep
module myModule 'br/MyRegistryWithPath:my-module:v1' = {
  // ...
}
```

## Build your Bicep file

When you're ready to deploy your Bicep file, you deploy it just like you normally do. Bicep downloads the module from the registry automatically as part of the deployment process. Bicep embeds all of the modules that you refer to into the transpiled ARM template, which is a JSON file.

You can also separate the module download process from the build by using the `bicep restore` command. You can then use the `bicep build` command with the `--no-restore` command-line switch to stop the build process from downloading the module. Generally, though, you don't need to separate modules and let Bicep download the modules automatically.
