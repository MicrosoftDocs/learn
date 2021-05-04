Sometimes you need to pass sensitive values into your deployments, like logins, passwords, and API keys. However, you need to ensure these values are protected. In some situations, you don't want the person who's creating the deployment to know the value at all. Other times, someone will enter the parameter value when they create the deployment, but you need to make sure the secret values aren't exposed or logged. In this unit, you'll learn about some approaches to follow to protect your parameters.

> [!TIP]
> If you need to provide credentials like passwords and API keys then Bicep lets you do that using the approaches described here. However, an even better approach is to avoid using credentials entirely. [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) can enable the components of your solution to securely communicate with one another without any credentials. Managed identities are not available for every resource, but it's a good idea to use them wherever you can.

## Define secure parameters

Bicep provides the `@secure` decorator, which you can apply to string and object parameters that contain secure values. When you define a parameter as `@secure`, Azure won't make the parameter values available in the deployment logs. Also, if you create the deployment interactively using the Azure CLI or Azure PowerShell and you need to enter the values during the deployment, the terminal will not display the text on your screen.

As part of the HR application migration, you need to deploy an Azure SQL server and database. You'll provision the server with an administrative login and password. These values are sensitive, and you need the deployment to be secured. Here is an example declaration to create two string parameters for the SQL server details:

```bicep
@secure()
param sqlServerAdministratorLogin string

@secure()
param sqlServerAdministratorPassword string
```

Note that both secure parameters don't have a default value specified. It's a good practice not to specify a default value for usernames, passwords, and other secrets. Otherwise, if someone deploys your template and doesn't realize they should override the value, they will weaken their security because they'll get a default value instead of something they've chosen themselves.

> [!TIP]
> You also need to ensure you don't create outputs for sensitive data. Output values can be accessed by anyone who has access to the deployment history.

## Avoid using parameter files for secrets

As you learned in the previous unit, parameter files are a great way to specify a set of parameter values. You'll often create parameter files for each environment you're deploying to. However, you should generally avoid using parameter files to specify secret values. Parameter files are often saved to a centralized version control system, like Git, which lots of people might have access to in the future. You should never save sensitive data to version control systems.

## Integrate with Azure Key Vault

Azure Key Vault is a service designed to store and provide access to secrets. You can integrate your Bicep templates with Key Vault by using a parameter file with a reference to a Key Vault secret.

You retrieve the value by referring to the key vault and secret in your parameter file. The value is never exposed because you only reference its identifier, which itself isn't secret. When you deploy the template, Azure will contact the key vault and retrieve the data.

> [!TIP]
> You can refer to secrets in key vaults that are located in a different resource group or subscription than the one you're deploying to.

:::image type="content" source="../media/5-parameter-file-key-vault.png" alt-text="Diagram that shows a parameter file reference Azure Key Vault and pass secret to Bicep template to deploy Azure resources" border="false":::

Here's a parameter file that uses Azure Key Vault references to look up the SQL server administrator login and password to use:

:::code language="json" source="code/5-key-vault-parameters.json" highlight="6-11,14-19":::

> [!IMPORTANT]
> To use Key Vault references, your key vault must be configured to allow Resource Manager to access the data in the key vault during template deployments. Also, the user who deploys the template must have permission to access the key vault. You'll learn how to do this in the next unit.

> [!NOTE]
> Currently Bicep doesn't support Key Vault references for modules.
