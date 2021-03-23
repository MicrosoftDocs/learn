As our templates become more complex and have more resources defined in them, it's helpful to make them more _modularized_. We can create individual Bicep files, called modules, for different parts of our deployment. Our main Bicep template references these modules, and the modules are transpiled into a single ARM template for deployment. Modules are also a way to make our Bicep code reusable. We can have a single Bicep module that is used by lots of Bicep templates.

We also will often need to emit _outputs_ from our Bicep modules and templates. Outputs let our Bicep code send data back to whoever or whatever has initiated the deployment.

## Outputs

Bicep templates can be executed manually by a human or by an automated release process. Either way, it's common for us to have some data from our template that we need to provide back to whoever or whatever is executing our template deployment. Here are some example scenarios where we might want to use outputs:

* We create a Bicep template that deploys a virtual machine, and we need to get the public IP address so that we can SSH into the machine.
* We create a Bicep template that accepts a set of parameters, like an environment name and an application name. The template uses an expression to create the name of an App Service app that it deploys. We need to output the name of the app the template has deployed so that it can be used within a deployment pipeline to publish the application binaries.

To define an output in a Bicep template, we use the `output` keyword like this:

```bicep
output appName string = appName
```

The output definition includes a few key parts:

- The `output` keyword tells Bicep that we're defining an output.
- `appName` is the name of our output. When someone executes our template successfully, the output values will include the name we specified so they can access the values they're expecting.
- `string` is the type of our output. We can use the same types as parameters.
- We have to specify a value for each output. Unlike parameters, outputs need to have values. Output values can be expressions, references to parameters or variables, or properties of resources we've deployed within the file.

> [!TIP]
> Outputs can use the same names as variables and parameters.

Here's another example of an output - this one will have its value set to the fully qualified domain name (FQDN) of a public IP address resource:

```bicep
output ipFqdn string = publicIPAddress.properties.dnsSettings.fqdn
```

## Defining a module

Any Bicep template can be used as a module by another template. Throughout this learning module, we've been creating Bicep templates. That means you have already created files that can be used as Bicep modules!

When we want our template to include a reference to a module file, we need to use the `module` keyword. A module definition looks similar to a resource declaration, but instead of including a resource type and API version, we instead use our module filename:

```bicep
module myModule 'modules/my-module.bicep' = {
  name: 'MyModule'
  params: {
    location: location
  }
}
```

Let's look closely at some key parts of this module definition.

* The `module` keyword tells Bicep that we're about to use another Bicep file as a module.
* Just like with resources, we have to give our module a _symbolic name_. We use the symbolic name when we need to refer to the module's outputs in other parts of our template.
* `modules/my-module.bicep` is the path to our module file, relative to the template file. If we looked at that file, we'd see it's just a regular Bicep file.
* Just like with resources, we have to set the _name_ property. The name of the module is used by Azure because it creates a separate deployment for each module within the template file, and those deployments have names that we can use to identify them.
* We specify the _parameters_ of the module. When we set the values of each parameter within our template, we can use expressions, template parameters, variables, properties of resources we've deployed, and outputs from other modules. Bicep will automatically understand the dependency between our resources.

## Modules and outputs

Just like templates, Bicep modules can define outputs. It's common to _chain_ modules together into a template - the output from one module can be a parameter for another module. By using modules and outputs together, you can create sophisticated and reusable Bicep files.

## Effective modules

A good Bicep module follows a few key principles.

1. A module should have a clear purpose. For example, we might use a module to define all of the resources that are related to a specific part of our application, like all of the resources that form the credit card billing components of a commerce application. We might also use a module to define a set of resources that belong together, like all of our database servers and databases.
2. A module should generally consist of more than one resource. We shouldn't use a separate module for every resource we deploy.
3. A module should clear parameters and outputs that make sense. Consider the purpose of the module. Think about whether a module should be manipulating parameter values, or whether the parent template should handle that and then pass a single value through to the module. Similarly, think about the outputs that a module should return, and make sure they are useful to the templates that will include the module.
4. Modules should include all of the relevant declarations for the resources it creates. If a module needs to use a variable to define a part of a module, the variable should generally be included in the module file rather than in the parent template.

