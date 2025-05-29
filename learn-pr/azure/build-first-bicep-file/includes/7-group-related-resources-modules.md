You've started to use Bicep files for some recent product launches, and they've been successful. Because you've declared your resources in a file, you can quickly deploy the resources for new toy launches without needing to manually configure resources in the Azure portal.

The IT manager can see your Bicep code is becoming more complex and has an increasing number of resources defined, so they've asked if you can make the code more _modularized_. You can create individual Bicep files, called modules, for different parts of your deployment. The main Bicep file can reference these modules. Behind the scenes, modules are transpiled into a single JSON template for deployment.

Modules are also a way to make Bicep code even more reusable. You can have a single Bicep module that many other Bicep files use.

You'll also often need to emit _outputs_ from the Bicep modules and files. Outputs are a way for your Bicep code to send data back to whoever or whatever started the deployment. Let's look at outputs first.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Outputs

A human can manually deploy Bicep files, or some sort of automated release process can deploy them. Either way, it's common to have some data from the file you need to send back to whoever or whatever is executing the file deployment.

Here are some example scenarios where you might need to get information from the Bicep file deployment:

- You create a Bicep file that deploys a virtual machine, and you need to get the public IP address so you can SSH into the machine.
- You create a Bicep file that accepts a set of parameters, like an environment name and an application name. The file uses an expression to name an Azure App Service app that it deploys. You need to output the app's name that the file has deployed so you can use it within a deployment pipeline to publish the application binaries.

You can use outputs for these scenarios. To define an output in a Bicep file, use the `output` keyword like this:

```bicep
output appServiceAppName string = appServiceAppName
```

The output definition includes a few key parts:

- The `output` keyword tells Bicep you're defining an output.
- `appServiceAppName` is the output's name. When someone deploys the Bicep file successfully, the output values include the name you specified so they can access the values they're expecting.
- `string` is the output type. Bicep outputs support the same types as parameters.
- A value must be specified for each output. Unlike parameters, outputs always need to have values. Output values can be expressions, references to parameters or variables, or properties of resources that are deployed within the file.

> [!TIP]
> Outputs can use the same names as variables and parameters. This convention can be helpful if you construct a complex expression within a variable to use within your Bicep file's resources, and you also need to expose the variable's value as an output.

Here's another example of an output. This one will have its value set to the fully qualified domain name (FQDN) of a public IP address resource.

```bicep
output ipFqdn string = publicIPAddress.properties.dnsSettings.fqdn
```

> [!TIP]
> Try to use resource properties as outputs rather than making assumptions about how resources will behave. For example, if you need to have an output for App Service app's URL, use the app's `defaultHostName` property instead of creating a string for the URL yourself. Sometimes these assumptions aren't valid in different environments, or the way the resource works changes, so it's safer to have the resource tell you its own properties.

> [!CAUTION]
> Don't create outputs for secret values like connection strings or keys. Anyone with access to your resource group can read outputs from Bicep files. There are other approaches you can use to get access to secret resource properties, which we'll cover in a later module.

## Define a module

Bicep modules allow you to organize and reuse your Bicep code by creating smaller units that can be composed into a Bicep file. Any Bicep file can be used as a module by another template. Throughout this learning module, you've created Bicep files. That means you've already created files that can be used as Bicep modules!

Imagine you have a Bicep file that deploys application, database, and networking resources for _solution A_. You might split this Bicep file into three modules, each of which is focused on its own set of resources. As a bonus, you can now reuse the modules in other templates for other solutions too; so when you develop a file for _solution B_, which has similar networking requirements to _solution A_, you can reuse the network module.

:::image type="content" source="../../includes/media/bicep-files-modules.png" alt-text="Diagram that shows a Bicep file for solution A referencing three modules: application, database, and networking. The networking module is then reused in another Bicep file for solution B." border="false":::

When you want the Bicep file to include a reference to a module file, use the `module` keyword. A module definition looks similar to a resource declaration, but instead of including a resource type and API version, you'll use the module's file name:

```bicep
module myModule 'modules/mymodule.bicep' = {
  name: 'MyModule'
  params: {
    location: location
  }
}
```

Let's look closely at some key parts of this module definition:

- The `module` keyword tells Bicep you're about to use another Bicep file as a module.
- Just like resources, modules need a _symbolic name_ like `myModule`. You'll use the symbolic name when you refer to the module's outputs in other parts of the Bicep file.
- `modules/mymodule.bicep` is the path to the module Bicep file, relative to the file. Remember, a module file is just a regular Bicep file.
- Just like resources, the `name` property is mandatory. Azure uses the module name because it creates a separate deployment for each module within the Bicep file. Those deployments have names you can use to identify them.
- You can specify any _parameters_ of the module by using the `params` keyword. When you set the values of each parameter within the Bicep file, you can use expressions, file parameters, variables, properties of resources deployed within the file and outputs from other modules. Bicep will automatically understand the dependencies between the resources.

## Modules and outputs

Just like templates, Bicep modules can define outputs. It's common to chain modules together within a template. In that case, the output from one module can be a parameter for another module. By using modules and outputs together, you can create powerful and reusable Bicep files.

## Design your modules

A good Bicep module follows some key principles:

> [!div class="checklist"]
>
> - **A module should have a clear purpose.** You can use modules to define all of the resources related to a specific part of your solution. For example, you might create a module that contains all of the resources used to monitor your application. You might also use a module to define a set of resources that belong together, like all of your database servers and databases.
>
> - **Don't put every resource into its own module.** You shouldn't create a separate module for every resource you deploy. If you have a resource that has many complex properties, it might make sense to put that resource into its own module, but in general, it's better for modules to combine multiple resources.
>
> - **A module should have clear parameters and outputs that make sense.** Consider the purpose of the module. Think about whether the module should manipulate parameter values, or whether the parent Bicep file should handle that, and then pass a single value through to the module. Similarly, think about the outputs a module should return, and make sure they're useful to the Bicep files that'll use the module.
>
> - **A module should be as self-contained as possible.** If a module needs to use a variable to define a part of a module, the variable should generally be included in the module Bicep file rather than in the parent Bicep file.
>
> - **A module shouldn't output secrets.** Just like templates, don't create module outputs for secret values like connection strings or keys.
