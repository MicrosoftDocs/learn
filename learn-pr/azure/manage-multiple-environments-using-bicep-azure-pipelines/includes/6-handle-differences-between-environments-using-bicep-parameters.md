You've already learned about Bicep parameters, which help you to specify values that can change between deployments of your Bicep files. Parameters are commonly used to support the differences between your environments. For example, in your non-production environment you often want to deploy inexpensive SKUs of your Azure resources, while in production you want to deploy SKUs that have better performance. Or, you might want to use different names for different environments.

When you deploy your Bicep file, you can indicate the values of each parameter. When you use a pipeline, there are several options for how you can specify the values for each parameter, and how you specify separate values for each environment. In this unit, you'll learn about the approaches yuo can consider for specifying Bicep parameter values in a pipeline.

## Parameter files

A parameter file is a JSON-formatted file that lists the parameter values you want to use for each environment. Here's an example of a parameter file:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environmentName": {
      "value": "NonProduction"
    }
  }
}
```

Parameter files can be committed to your Git repository with your Bicep file. You can then refer to the parameter file in your template. If you use parameter files, it's a good idea to establish a consistent environment naming strategy. For example, you might name your parameter files *azuredeploy.parameters.ENVIRONMENT_NAME.json*, like *azuredeploy.parameters.production.json*. THen, you can use a pipeline template parameter to automatically select the correct parameter file:

We already mentioned parameter files as one way to pass parameters to a Bicep template. This is a good way of passing parameter values that are not secure values. You indicate all values in the parameter file and you can even vary which parameter file to use when calling a pipeline template: 

:::code language="yaml" source="code/6-parameter-file.yml" highlight="25" :::

An advantage of using this approach is that your pipeline YAML files don't need to contain a list of parameters that need to be passed in individually. This is especially beneficial when you have a large number of parameters. All of the parameters are grouped together and defined in a single JSON file. The parameter files are also part of your Git repository, so they can get versioned in the same way as all your other code.

However, parameter files shouldn't be used for secure values. There's no way to protect the values of the secrets in the parameters files, and you should never commit secure values to your Git repository. Also, every time you want to change a parameter's value, you need to update the corresponding parameter file, commit the change, and then re-run your pipeline. In some situations, this might be too complex or slow.

## Pipeline variables

Azure Pipelines enables you to store *pipeline variables*, which are useful for values that might be different between environments, as well as for values that you only want to define once and then reuse throughout your pipeline. Azure Pipelines supports several ways to define variables.

### Variables defined in a YAML file

You can define variables and set their values within a YAML file. This is useful when you need to reuse the same value multiple times. But, like Bicep parameter files, YAML files aren't suitable for secrets.

### Variables defined in the web interface

The first type of variable is one that you define by using the Azure DevOps web interface. You can change the variable values any time, and next time the pipeline runs it uses the updated values.

Variables defined using the web interface can be marked as secret, which tells Azure Pipelines to try to hide the variable's value in the pipeline logs. This means you can store values that your Bicep file then accepts as parameters with the `@secure()` decorator.

[!include[Best-effort protection for secrets](../../includes/azure-devops-secret-best-effort.md)]

### Variable groups

You can also define *variable groups*, which are sets of variables. Like variables, you define these by using the Azure DevOps web interface. You can also use variable groups to store secrets.

Unlike normal variables, you need to explicitly import a variable group into a pipeline by using the `group` keyword in a `variables` section, like this:

```yaml
variables: 
- group: MyVariableGroup
```

When you work with pipeline templates, you can name your variable groups so that you can easily load them by using a template parameter. For example, suppose your pipeline deploys to two environments, and you need to define a set of variables for each environment. You could name your variable groups like this:

| Environment name | Environment ID | Variable group name  |
|------------------|----------------|----------------------|
| Non-Production   | `nonprod`      | `ToyWebsite-nonprod` |
| Production       | `prod`         | `ToyWebsite-prod`    |

In each of these variable groups you add variables with the same names, but with different values for each environment.

In your pipeline template file, you can then use the `{{ parameters.PARAMETER_NAME }}` macro to select the correct variable group to import:

:::code language="yaml" source="code/6-template-variable-group.yml" highlight="7" :::

### Key Vault variable groups

Variable groups can be linked to an Azure Key Vault. Secrets in the vault are made available as variables in the variable group and can be used in your pipelines as if they're normal variables.

This way of linking a variable group to an Azure Key Vault will make the management of your secret values even more secure. It also enables those values to be managed by a separate security team, and to keep the access to your pipelines and the secrets separated from each other.

<!-- TODO diagram? more detail? -->

### Use variables in your pipeline

Regardless of how you define a variable, you access its value in your pipeline by using the `$(VariableName)` syntax.

When you need to use a variable to set a parameter for your Bicep file, you use it like this:

:::code language="yaml" source="code/6-parameter-variables.yml" highlight="22" :::

## What's the best approach?

TODO

### Avoid unnecessary parameters

Parameters help you to make your Bicep files reusable, but it's easy to define too many parameters. Every parameter needs a value to be provided, and when you start to work with complex deployments and multiple environments, it gets hard to manage a large set of individual parameter values.

Consider making parameters optional where you can, and use default values that apply to most of your environments. This might avoid the need for your pipelines to pass in values for the parameters.

Also, keep in mind that parameters are often used in Bicep when resources need to connect to other resources. For example, if you have a website that needs to connect to a storage account, then you'll need to provide the storage account name and access key. Keys are secure values. However, there are other possible approaches to consider when deploying this combination of resources, such as:

- Deploy the storage account and website together in the same Bicep template. Use Bicep modules to keep the website and storage resources together. Then, you can automatically look up the values for the storage account name and the key within the Bicep code, instead of passing in parameters.
- Use the website's managed identity to access the storage account. A managed identity is automatically handled by Azure, and you don't need to maintain any credentials. This simplifies the connection settings, and means you don't have to pass in secrets at all.
- Add the storage account's details to Key Vault. Have the website code load the key directly from the vault. This avoids the need to manage the key in the pipeline at all.

### Store secrets appropriately

When you can't handle secrets another way, consider 
TODO Use variables or KV groups for all secrets

### Use parameter files for large sets of parameters

TODO

### Combine approaches

TODO