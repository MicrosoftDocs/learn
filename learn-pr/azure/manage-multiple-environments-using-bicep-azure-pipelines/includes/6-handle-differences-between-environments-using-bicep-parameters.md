You've already learned about Bicep parameters. They help you specify values that can change between deployments of your Bicep files.

Parameters are commonly used to support the differences between your environments. For example, in your non-production environments, you often want to deploy inexpensive SKUs of your Azure resources. In production, you want to deploy SKUs that have better performance. And you might want to use different names for resources in each environment.

When you deploy your Bicep file, you provide values for each parameter. There are several options for how you specify the values for each parameter from your pipeline, and how you specify separate values for each environment. In this unit, you'll learn about the approaches for specifying Bicep parameter values in a deployment pipeline.

## Parameter files

A parameter file is a JSON-formatted file that lists the parameter values that you want to use for each environment. You submit the parameter file to Azure Resource Manager when you submit the deployment.

Here's an example parameter file:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "reviewApiUrl": {
      "value": "https://sandbox.contoso.com/reviews"
    }
  }
}
```

Parameter files can be committed to your Git repository alongside your Bicep file. You can then refer to the parameter file in your pipeline template where you execute your deployment.

It's a good idea to establish a consistent environment-naming strategy for parameter files. For example, you might name your parameter files _parameters.ENVIRONMENT_NAME.json_, like _parameters.Production.json_. Then, you can use a pipeline template parameter to automatically select the correct parameter file.

:::code language="yaml" source="code/6-parameter-file.yml" highlight="30" :::

When you use parameter files, your pipeline YAML files don't need to contain a list of parameters that need to be passed to your deployment steps individually. This is helpful when you have a large number of parameters.

A parameter file keeps the parameter values together in a single JSON file. The parameter files are also part of your Git repository, so they can get versioned in the same way as all your other code.

> [!IMPORTANT]
> Parameter files shouldn't be used for secure values. There's no way to protect the values of the secrets in the parameter files, and you should never commit secrets to your Git repository.

## Pipeline variables

Azure Pipelines enables you to store _pipeline variables_, which are useful for values that might be different between environments. They're also useful for values that you want to define only once and then reuse throughout your pipeline. Azure Pipelines supports several ways to define variables.

### Variables defined in a YAML file

You can define variables and set their values within a YAML file. This is useful when you need to reuse the same value multiple times. But, like Bicep parameter files, YAML files aren't suitable for secrets.

### Variables defined in the web interface

You can define variables by using the Azure DevOps web interface. You can change the variable values at any time, and the pipeline will read the updated values the next time it runs.

Variables defined through the web interface can be marked as secret, which tells Azure Pipelines to try to hide the variables' values in the pipeline logs. This means you can store values that your Bicep file then accepts as parameters with the `@secure()` decorator.

[!INCLUDE [Best-effort protection for secrets](../../includes/azure-devops-secret-best-effort.md)]

### Variable groups

You can also define _variable groups_, which are sets of variables. Like variables, you define these groups by using the Azure DevOps web interface. You can also use variable groups to safely store secrets. Variable groups can even be reused in multiple pipelines in the same Azure DevOps project.

Unlike other variables, you need to explicitly import a variable group into a pipeline by using the `group` keyword in a `variables` section, like this:

```yaml
variables:
- group: MyVariableGroup
```

When you work with pipeline templates, you can name your variable groups so that you can easily load them by using a template parameter. For example, suppose your pipeline deploys to two environments, and you need to define a set of variables for each environment. You could name your variable groups with the environment names included, like this:

| Environment name | Variable group name    |
|------------------|------------------------|
| Test             | `ToyWebsiteTest`       |
| Production       | `ToyWebsiteProduction` |

In each of these variable groups, you add variables with the same names but with different values for each environment.

Your pipeline template file uses the `{{ parameters.PARAMETER_NAME }}` macro to select the correct variable group to import:

:::code language="yaml" source="code/6-template-variable-group.yml" highlight="7" :::

### Key Vault variable groups

You can link variable groups to Azure Key Vault. Secrets in the key vault are made available as variables in the variable group. The secrets can then be used in your pipelines as if they're normal variables.

Key Vault makes the management of your secrets more secure. It also enables those values to be managed by your security team, and to separate the access to your pipelines from the secrets that it uses.

More steps are required to link a variable group to a key vault. These steps include creating a service connection that has permission to read the secrets from the key vault. In the summary unit, we provide a link to more details about how to configure Key Vault variable groups.

### Use variables in your pipeline

Regardless of how you define a variable, you access its value in your pipeline by using the `$(VariableName)` syntax. For example, when you run a Bicep deployment, you can use a variable to specify the value of a parameter:

:::code language="yaml" source="code/6-parameter-variables.yml" highlight="20, 22" :::

## What's the best approach?

You've learned about several ways to handle the parameters that your Bicep file needs for your deployment. It's helpful to understand when you might use which approach.

### Avoid unnecessary parameters

Parameters help you make your Bicep files reusable, but it's easy to define too many parameters. When you deploy a Bicep file, you need to provide a value for every parameter. In complex deployments against multiple environments, it gets hard to manage a large set of individual parameter values.

Consider making parameters optional where you can, and use default values that apply to most of your environments. You might then avoid the need for your pipelines to pass in values for the parameters.

Also, keep in mind that parameters are often used in Bicep when resources need to connect to other resources. For example, if you have a website that needs to connect to a storage account, you'll need to provide the storage account name and access key. Keys are secure values. However, consider these other approaches when you're deploying this combination of resources:

- Use the website's managed identity to access the storage account. When you create a managed identity, Azure automatically generates and manages its credentials. This approach simplifies the connection settings. It also means you don't have to handle secrets at all, so it's the most secure option.
- Deploy the storage account and website together in the same Bicep template. Use Bicep modules to keep the website and storage resources together. Then, you can automatically look up the values for the storage account name and the key within the Bicep code, instead of passing in parameters.
- Add the storage account's details to a key vault as a secret. The website code then loads the access key directly from the vault. This approach avoids the need to manage the key in the pipeline at all.

### Use variable groups for small sets of parameters

If you have only a few parameters for your Bicep files, consider using a variable group. You can store both secret and non-secret values in variable groups.

### Use parameter files for large sets of parameters

If you have a large set of parameters for your Bicep files, consider using parameter files to keep the non-secure values together for each environment. Then, whenever you need to change the values, you can update a parameter file and commit your change.

This approach keeps your pipeline steps simpler, because you don't need to explicitly set the value for every parameter.

### Store secrets securely

Use an appropriate process for storing and handling secrets. If you have only a small number of secrets to manage, Azure Pipelines variables and variable groups often work well. But you might have more complex requirements, like a large number of secrets, many different environments, or access control restrictions. For these situations, consider storing the secrets for each environment in separate key vaults. Use variable groups to link the vaults to your pipeline.

For secure parameters, remember to explicitly pass each parameter into your deployment steps.

### Combine approaches

It's common to combine multiple approaches to handle your parameters. For example, you can store most of your parameter values in parameter files, and then set secure values by using a variable group. The following example illustrates the combination:

:::code language="yaml" source="code/6-multiple.yml" highlight="1-2, 27-28" :::

There are special rules about how service connection names can be specified. These rules can affect how you use names in pipelines that deploy to multiple environments. For example, you can't use a variable defined within a variable group to specify a service connection name. You can use pipeline template parameters to specify the name of the service connection to use.
