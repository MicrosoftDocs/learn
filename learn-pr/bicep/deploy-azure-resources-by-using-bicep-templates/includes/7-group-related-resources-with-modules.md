You've started to use Bicep templates for some recent product launches, and they have been very successful. Since you've declared your resources in a template file, you can quickly deploy the resources for new toy launches without needing to manually configure resources in the Azure portal.

The IT manager can see that your Bicep code is becoming more complex and has more and more resources defined, so they've asked if you can make them more _modularized_. You can create individual Bicep files, called modules, for different parts of your deployment. The main Bicep template references these modules, and behind the scenes the modules are transpiled into a single JSON template for deployment. Modules are also a way to make Bicep code even more reusable. You can have a single Bicep module that is used by lots of Bicep templates.

You also will often need to emit _outputs_ from the Bicep modules and templates. Outputs are a way for your Bicep code to send data back to whoever or whatever has initiated the deployment. Let's look at outputs first.

## Outputs

Bicep templates can be deployed manually by a human, or by some sort of automated release process. Either way, it's common to have some data from the template that you need to provide back to whoever or whatever is executing the template deployment. Here are some example scenarios where you might need to get information from the template deployment:

* You create a Bicep template that deploys a virtual machine, and you need to get the public IP address so that you can SSH into the machine.
* You create a Bicep template that accepts a set of parameters, like an environment name and an application name. The template uses an expression to create the name of an App Service app that it deploys. You need to output the name of the app the template has deployed so that it can be used within a deployment pipeline to publish the application binaries.

You can use _outputs_ for these scenarios. To define an output in a Bicep template, use the `output` keyword like this:

```bicep
output appName string = appName
```

The output definition includes a few key parts:

- The `output` keyword tells Bicep that you're defining an output.
- `appName` is the name of the output. When someone executes the template successfully, the output values will include the name you specified so they can access the values they're expecting.
- `string` is the type of the output. Bicep outputs support the same types as parameters.
- A value must be specified for each output. Unlike parameters, outputs always need to have values. Output values can be expressions, references to parameters or variables, or properties of resources that are deployed within the file.

> [!TIP]
> Outputs can use the same names as variables and parameters.

Here's another example of an output - this one will have its value set to the fully qualified domain name (FQDN) of a public IP address resource:

```bicep
output ipFqdn string = publicIPAddress.properties.dnsSettings.fqdn
```

> [!TIP]
> Try to use resource properties as outputs, rather than making assumptions about how resources will behave. For example, if you need to have an output for the URL to an App Service app, use the `defaultHostname` property of the app instead of creating a string for the URL yourself. Sometimes these assumptions aren't correct in different environments, or the resources change the way they work, so it's safer to have the resource tell you its own properties. 

## Define a module

Any Bicep template can be used as a module by another template. Throughout this learning module, you've been creating Bicep templates. That means you have already created files that can be used as Bicep modules!

When you want the template to include a reference to a module file, use the `module` keyword. A module definition looks similar to a resource declaration, but instead of including a resource type and API version, you instead use the module filename:

```bicep
module myModule 'modules/my-module.bicep' = {
  name: 'MyModule'
  params: {
    location: location
  }
}
```

Let's look closely at some key parts of this module definition.

* The `module` keyword tells Bicep that you're about to use another Bicep file as a module.
* Just like with resources, modules need a _symbolic name_. You use the symbolic name when you refer to the module's outputs in other parts of the template.
* `modules/my-module.bicep` is the path to the module file, relative to the template file. Remember, this is just a regular Bicep file.
* Just like with resources, the _name_ property is mandatory. The name of the module is used by Azure because it creates a separate deployment for each module within the template file, and those deployments have names that you can use to identify them.
* You can specify any _parameters_ of the module using the `params` keyword. When you set the values of each parameter within the template, you can use expressions, template parameters, variables, properties of resources deployed within the template, and outputs from other modules. Bicep will automatically understand the dependency between the resources.

## Modules and outputs

Just like templates, Bicep modules can define outputs. It's common to chain modules together within a template - the output from one module can be a parameter for another module. By using modules and outputs together, you can create powerful and reusable Bicep files.

## Design your modules

A good Bicep module follows a few key principles.

> [!div class="checklist"]
> * **A module should have a clear purpose.** For example, you might use a module to define all of the resources that are related to a specific part of your application, like all of the resources that form the credit card billing components of a commerce application. You might also use a module to define a set of resources that belong together, like all of your database servers and databases.
> * **A module should create more than one resource.** You shouldn't create a separate module for every resource you deploy.
> * **A module should have clear parameters and outputs that make sense.** Consider the purpose of the module. Think about whether the module should be manipulating parameter values, or whether the parent template should handle that and then pass a single value through to the module. Similarly, think about the outputs that a module should return, and make sure they are useful to the templates that will include the module.
> * **A module should be as self-contained as possible.** If a module needs to use a variable to define a part of a module, the variable should generally be included in the module file rather than in the parent template.
