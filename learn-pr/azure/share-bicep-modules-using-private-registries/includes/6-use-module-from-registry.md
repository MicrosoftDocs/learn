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

Notice that the module definition is similar to that of a local module, but with one important difference. Instead of specifying the path to a Bicep file on your file system, you instead include the path to your module in your registry.

After you've added a reference to the module, Visual Studio Code attempts to automatically download the module from the registry. When the module is downloaded, the Bicep extension for Visual Studio Code gives you IntelliSense and other code authoring assistance as you work.

When you're ready to deploy your Bicep file, you deploy it just like you normally do. Bicep downloads the module from the registry automatically as part of the deployment process.

> [!NOTE]
> You can also separate the module download process from the build by using the `bicep restore` command, and use the `bicep build` command with the `--no-restore` command-line switch to stop the build process from downloading the module. Generally, though, you don't need to do this - just let Bicep download the modules automatically.

## Aliases 

You can use a *registry alias* to simplify your module definitions. Instead of specifying the registry name every time you define a module, you use its alias.

<!-- TODO aliases reduce typing when you reuse modules from the same registry repeatedly. Also, if you need to use different registires for different environemnts, you can use this aproach to switch out the registry name -->

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
