You've already learned about Bicep parameters. They help you specify values that can change between deployments of your Bicep files.

Parameters are commonly used to support the differences between your environments. For example, in your non-production environments, you often want to deploy inexpensive SKUs of your Azure resources. In production, you want to deploy SKUs that have better performance. And you might want to use different names for resources in each environment.

When you deploy your Bicep file, you provide values for each parameter. There are several options for how you specify the values for each parameter from your workflow, and how you specify separate values for each environment. In this unit, you'll learn about the approaches for specifying Bicep parameter values in a deployment workflow.

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

Parameter files can be committed to your Git repository alongside your Bicep file. You can then refer to the parameter file in your workflow template where you execute your deployment.

It's a good idea to establish a consistent environment-naming strategy for parameter files. For example, you might name your parameter files _parameters.ENVIRONMENT_NAME.json_, like _parameters.Production.json_. Then, you can use a workflow template input to automatically select the correct parameter file based on an input value.

:::code language="yaml" source="code/6-parameter-file.yml" highlight="4, 19" :::

When you use parameter files, your workflow YAML files don't need to contain a list of parameters that need to be passed to your deployment steps individually. This is especially helpful when you have a large number of parameters.

A parameter file keeps the parameter values together in a single JSON file. The parameter files are also part of your Git repository, so they can get versioned in the same way as all your other code.

> [!IMPORTANT]
> Parameter files shouldn't be used for secure values. There's no way to protect the values of the secrets in the parameter files, and you should never commit secrets to your Git repository.

## Workflow variables

GitHub Actions enables you to store _workflow variables_, which are useful for values that might be different between environments. They're also useful for values that you want to define only once and then reuse throughout your workflow.

### Variables defined in a YAML file

You can define variables and set their values within a YAML file. This is useful when you need to reuse the same value multiple times. You can define a variable for a whole workflow, a job, or a single step:

:::code language="yaml" source="code/6-define-variables.yml" highlight="1-2, 7-8. 11-12" :::

### Secrets defined in the web interface

Like Bicep parameter files, YAML files aren't suitable for secrets. Instead, you can define secrets by using the GitHub web interface. You can change the variable values at any time, and the workflow will read the updated values the next time it runs. GitHub Actions tries to hide the secrets' values in the workflow logs. This means you can store values that your Bicep file then accepts as parameters with the `@secure()` decorator.

[!INCLUDE [Best-effort protection for secrets](../../includes/github-actions-secret-best-effort.md)]

When you create a secret, GitHub enables you to choose whether to scope it to your entire Git repository or to a specific environment. Environment-scoped secrets honor the protection rules you configure on your environments, so if you configure a required reviewer rule, a workflow can't access the secrets values until the specified GitHub user has approved your pipeline to deploy to that environment.

Environment-scoped secrets can be helpful, but they don't easily work with Azure Resource Manager's preflight validation or what-if operations. These operations need to communicate with Azure, which means they need a workload identity. You generally want to provide deployment approval _after_ the preflight validation or what-if operations are completed, so that you but have a high degree of confidence in the changes that you're deploying. So, if you use environment-scoped secrets, the human review process happens too early in your workflow.

For this reason, you don't use environment-scoped secrets in this module's exercises. Instead, you create repository-scoped secrets with predictable names that include the environment name. This enables your workflow to identify the correct secret to use for each environment. In your own workflows, you might choose to use repository-scoped secrets, environment-scoped secrets, or even a mixture of both.

> [!NOTE]
> You can also scope secrets to GitHub organizations. Although this isn't in scope for this module, we link to more information in the summary.

### Use variables in your workflow

The way that you access a variable's value in your workflow depends on the type of variable.

| Type | Syntax |
|-|-|
| Variables defined in the same file | `${{ env.VARIABLE_NAME }}` |
| Inputs to a called workflow | `${{ inputs.INPUT_NAME }}` |
| Secrets | `${{ secrets.SECRET_NAME }}` |

For example, when you run a Bicep deployment, you might use secrets to specify the Azure workload identity to use, a called workflow input to specify the resource group name, and a variable to specify the value of a parameter:

:::code language="yaml" source="code/6-use-variables.yml" range="19-36" highlight="10-12, 16, 18" :::

## What's the best approach?

You've learned about several ways to handle the parameters that your Bicep file needs for your deployment. It's helpful to understand when you might use which approach.

### Avoid unnecessary parameters

Parameters help you make your Bicep files reusable, but it's easy to define too many parameters. When you deploy a Bicep file, you need to provide a value for every parameter. In complex deployments against multiple environments, it gets hard to manage a large set of individual parameter values.

Consider making parameters optional where you can, and use default values that apply to most of your environments. You might then avoid the need for your workflows to pass in values for the parameters.

Also, keep in mind that parameters are often used in Bicep when resources need to connect to other resources. For example, if you have a website that needs to connect to a storage account, you'll need to provide the storage account name and access key. Keys are secure values. However, consider these other approaches when you're deploying this combination of resources:

- Use the website's managed identity to access the storage account. When you create a managed identity, Azure automatically generates and manages its credentials. This approach simplifies the connection settings. It also means you don't have to handle secrets at all, so it's the most secure option.
- Deploy the storage account and website together in the same Bicep template. Use Bicep modules to keep the website and storage resources together. Then, you can automatically look up the values for the storage account name and the key within the Bicep code, instead of passing in parameters.
- Add the storage account's details to a key vault as a secret. The website code then loads the access key directly from the vault. This approach avoids the need to manage the key in the workflow at all.

### Use workflow variables for small sets of parameters

If you have only a few parameters for your Bicep files, consider defining variables in your YAML file.

### Use parameter files for large sets of parameters

If you have a large set of parameters for your Bicep files, consider using parameter files to keep the non-secure values together for each environment. Then, whenever you need to change the values, you can update a parameter file and commit your change.

This approach keeps your workflow steps simpler, because you don't need to explicitly set the value for every parameter.

### Store secrets securely

Use an appropriate process for storing and handling secrets. Use GitHub secrets to store secrets in your GitHub repository, or use Key Vault to store secrets in Azure.

For secure parameters, remember to explicitly pass each parameter into your deployment steps.

GitHub can automatically scan your repository for secrets that have been accidentally committed, so that you can be notified. You can then remove and rotate the secrets. We link to more information about this feature in the summary.

### Combine approaches

It's common to combine multiple approaches to handle your parameters. For example, you can store most of your parameter values in parameter files, and then set secure values by using a secret. The following example illustrates the combination:

:::code language="yaml" source="code/6-multiple.yml" highlight="17-18, 39-41" :::

> [!TIP]
> At the end of this example, the `parameters` value is provided as a YAML multiline string by using the `>` character. This makes the YAML file easier to read. It's equivalent to including the entire value on a single line.
