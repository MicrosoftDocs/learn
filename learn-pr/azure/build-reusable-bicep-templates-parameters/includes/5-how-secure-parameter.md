Sometimes you need to pass sensitive values into your deployments, like passwords and API keys. But you need to ensure these values are protected. In some situations, you don't want the person who's creating the deployment to know the secret values. Other times, someone will enter the parameter value when they create the deployment, but you need to make sure the secret values aren't logged. In this unit, you'll learn about the ways you can protect your parameters.

> [!TIP]
> The best approach is to avoid using credentials entirely. [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) can enable the components of your solution to securely communicate with one another without any credentials. Managed identities aren't available for every resource, but it's a good idea to use them wherever you can. Where you can't, you can use the approaches described here.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Define secure parameters

The `@secure` decorator can be applied to string and object parameters that might contain secret values. When you define a parameter as `@secure`, Azure won't make the parameter values available in the deployment logs. Also, if you create the deployment interactively by using the Azure CLI or Azure PowerShell and you need to enter the values during the deployment, the terminal won't display the text on your screen.

As part of the HR application migration, you need to deploy an Azure SQL logical server and database. You'll provision the logical server with an administrator login and password. Because they're sensitive, you need these values to be secured. Here's an example declaration to create two string parameters for the SQL server's administrator details:

```bicep
@secure()
param sqlServerAdministratorLogin string

@secure()
param sqlServerAdministratorPassword string
```

Notice that neither parameter has a default value specified. It's a good practice to avoid specifying default values for usernames, passwords, and other secrets. Otherwise, if someone deploys your template and doesn't realize they should override the value, they'll weaken their security because they'll get the default value instead of something they've chosen themselves.

> [!TIP]
> Make sure you don't create outputs for sensitive data. Output values can be accessed by anyone who has access to the deployment history. They're not appropriate for handling secrets.

## Avoid using parameter files for secrets

As you learned in the previous unit, parameter files are a great way to specify a set of parameter values. You'll often create parameter files for each environment you're deploying to. In general, you should avoid using parameter files to specify secret values. Parameter files are often saved to a centralized version control system, like Git. Many people might have access to it in the future. Don't save sensitive data to version control systems because they're not designed to store this sort of information.

## Integrate with Azure Key Vault

Azure Key Vault is a service designed to store and provide access to secrets. You can integrate your Bicep templates with Key Vault by using a parameter file with a reference to a Key Vault secret.

You can use this feature by referring to the key vault and secret in your parameter file. The value is never exposed because you only reference its identifier, which by itself isn't anything secret. When you deploy the template, Azure Resource Manager will contact the key vault and retrieve the data.

> [!TIP]
> You can refer to secrets in key vaults that are located in a different resource group or subscription from the one you're deploying to.

:::image type="content" source="../media/5-parameter-file-key-vault.png" alt-text="Diagram that shows a parameter file reference Azure Key Vault and pass secret to Bicep template to deploy Azure resources." border="false":::

Here's a parameter file that uses Key Vault references to look up the SQL logical server administrator login and password to use:

:::code language="json" source="code/5-key-vault-parameters.json" highlight="6-11,14-19":::

Notice that instead of specifying a `value` for each of the parameters, this file has a `reference` object, which contains details of the key vault and secret.

> [!IMPORTANT]
> Your key vault must be configured to allow Resource Manager to access the data in the key vault during template deployments. Also, the user who deploys the template must have permission to access the key vault. You'll learn how to do these tasks in the next unit.

### Use Key Vault with modules

Modules enable you to create reusable Bicep files that encapsulate a set of resources. It's common to use modules to deploy parts of your solution. Modules may have parameters that accept secret values, and you can use Bicep's Key Vault integration to provide these values securely. Here's an example Bicep file that deploys a module and provides the value of the `ApiKey` secret parameter by taking it directly from Key Vault:

:::code language="bicep" source="code/5-module.bicep" highlight="8":::

Notice that in this Bicep file, the Key Vault resource is referenced by using the `existing` keyword. The keyword tells Bicep that the Key Vault already exists, and this code is a reference to that vault. Bicep won't redeploy it. Also, notice that the module's code uses the `getSecret()` function in the value for the module's `apiKey` parameter. This is a special Bicep function that can only be used with secure module parameters. Internally, Bicep translates this expression to the same kind of Key Vault reference you learned about earlier.
