In this exercise, you'll create a parameter file that provides values for the Bicep file that you previously created. In the same parameter file, you'll also add Azure Key Vault references to securely provide sensitive information.

During the process, you'll do the following tasks:

> [!div class="checklist"]
>
> - Add some secure parameters.
> - Create a parameter file.
> - Test the deployment to ensure that the parameter file is valid.
> - Create a key vault and secrets.
> - Update the parameter file to refer to the key vault secrets.
> - Re-test the deployment to ensure that the parameter file is still valid.

## Remove the default value for the App Service plan SKU

To make your template work across environments, the Azure App Service plan's SKU details will be provided in a parameter file rather than by a default value.

In the _main.bicep_ file in Visual Studio Code, update the `appServicePlanSku` parameter to remove its default value.

:::code language="bicep" source="code/6-template.bicep" range="19-20" highlight="2" :::

## Add new parameters

Now you need to add a SQL server and database. First, you'll add parameters for the administrator login and password, and the database SKU. You'll set their values later.

In the _main.bicep_ file in Visual Studio Code, add the `sqlServerAdministratorLogin`, `sqlServerAdministratorPassword`, and `sqlDatabaseSku` parameters underneath the current parameter declarations. When you're finished, your parameter declarations should look like this example:

:::code language="bicep" source="code/6-template.bicep" range="1-34" highlight="25-34" :::

Notice that you're not specifying default values for the `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters. It's bad security practice to add default values for secure parameters. Also, you're not specifying a default value for `sqlDatabaseSku`. You'll specify a value in a parameter file.

## Add new variables

In the _main.bicep_ file in Visual Studio Code, add the `sqlServerName` and `sqlDatabaseName` variables underneath the existing variables. When you're finished, your variable declarations should look like this example:

:::code language="bicep" source="code/6-template.bicep" range="36-39" highlight="3-4" :::

### Add SQL server and database resources

1. In the _main.bicep_ file in Visual Studio Code, add the following code to the bottom of the file:

   :::code language="bicep" source="code/6-template.bicep" range="60-77" :::

1. Save the changes to the file.

## Verify your Bicep file

After you've completed all of the preceding changes, your Bicep file should look like this example:

:::code language="bicep" source="code/6-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

## Create a parameter file

1. Open Visual Studio Code, and open the folder where the _main.bicep_ file is located. In the same folder, create a new file called _main.parameters.dev.json_.

1. In the _main.parameters.dev.json_ file, add the following code:

    :::code language="json" source="code/6-parameters-1.json" :::

1. Save the changes to the file.

## Deploy the Bicep template with the parameter file

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. Notice that you're providing a parameter file for the deployment.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters main.parameters.dev.json
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. Notice that you're providing a parameter file for the deployment.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -TemplateParameterFile main.parameters.dev.json
```

::: zone-end

You're prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment. You don't need to specify `solutionName` because it has a default value specified in the template. You don't need to specify the other parameter values because their values are specified in the parameter file.

> [!TIP]
> When you enter the secure parameters, the values you choose must follow some rules:
>
> - `sqlServerAdministratorLogin` must not be an easily guessable login name like `admin` or `root`. It can contain only alphanumeric characters and must start with a letter.
> - `sqlServerAdministratorPassword` must be at least eight characters long and include lowercase letters, uppercase letters, numbers, and symbols. For more information on password complexity, see the [SQL Azure password policy](/sql/relational-databases/security/password-policy#password-complexity).
>
> If the parameter values don't meet the requirements, Azure SQL won't deploy your server.
>
> Also, _make sure you keep a note of the login and password that you enter_. You'll use them in the next section.

The deployment might take a couple of minutes to finish.

## Create a key vault and secrets

Your toy company already has a key vault with the secrets it needs for its deployments. To simulate this scenario, you'll create a new key vault and add some secrets to use.

In the terminal, execute the following commands to create the key vault and secrets. Update the variable values before you execute these commands. Key vault names must be a globally unique string of 3 to 24 characters that can contain only uppercase and lowercase letters, hyphens (`-`), and numbers. For example, _demo-kv-1234567abcdefg_.

> [!CAUTION]
> Make sure you use the same login and password that you used in the previous step. If you don't, the next deployment won't complete successfully.

::: zone pivot="cli"

For the `keyVaultName` replace `YOUR-KEY-VAULT-NAME` with a name for your key vault. The `read` commands for the `login` and `password` variables will prompt you for values. As you type, the values aren't displayed in the terminal and aren't saved in your command history.

To protect the variable values in your Bash terminal session, be aware of the following items:

- Variable values aren't stored as a secure string and can be displayed by entering a command like `$yourVariableName` on the command line or with the `echo` command. In this exercise, after your vault secrets are created, you can remove each variable's existing value by running the `read` commands without inputting a value.
- The `az keyvault secret set` uses the `--value` parameter to create a secret's value. The command's output displays a property named `value` that contains the secret's value. You can suppress the command's entire output with the parameter `--output none` as shown in the example.

To create the `keyVaultName`, `login`, and `password` variables, run each command separately. Then you can run the block of commands to create the key vault and secrets.

```azurecli
keyVaultName='YOUR-KEY-VAULT-NAME'
read -s -p "Enter the login name: " login
read -s -p "Enter the password: " password

az keyvault create --name $keyVaultName --location westus3 --enabled-for-template-deployment true
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value $login --output none
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value $password --output none
```

> [!NOTE]
> You're setting the `--enabled-for-template-deployment` setting on the vault so that Azure can use the secrets from your vault during deployments. If you don't set this setting then, by default, your deployments can't access secrets in your vault.
>
> Also, whoever executes the deployment must also have permission to access the vault. Because you created the key vault, you're the owner, so you won't have to explicitly grant the permission in this exercise. For your own vaults, [you need to grant access to the secrets](/azure/azure-resource-manager/templates/key-vault-parameter#grant-access-to-the-secrets).

::: zone-end

::: zone pivot="powershell"

For the `keyVaultName` replace `YOUR-KEY-VAULT-NAME` with a name for your key vault. The `Read-Host` commands for the `login` and `password` variables will prompt you for values. As you type, the values aren't displayed in the terminal and aren't saved in your command history. The values are stored as a secure string.

To create the `keyVaultName`, `login`, and `password` variables, run each command separately. Then you can run the block of commands to create the key vault and secrets.

```azurepowershell
$keyVaultName = 'YOUR-KEY-VAULT-NAME'
$login = Read-Host "Enter the login name" -AsSecureString
$password = Read-Host "Enter the password" -AsSecureString

New-AzKeyVault -VaultName $keyVaultName -Location westus3 -EnabledForTemplateDeployment
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorLogin' -SecretValue $login
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'sqlServerAdministratorPassword' -SecretValue $password
```

> [!NOTE]
> You're setting the `-EnabledForTemplateDeployment` setting on the vault so that Azure can use the secrets from your vault during deployments. If you don't set this setting then, by default, your deployments can't access secrets in your vault.
>
> Also, whoever executes the deployment must also have permission to access the vault. Because you created the key vault, you're the owner, so you won't have to explicitly grant the permission in this exercise. For your own vaults, [you need to grant access to the secrets](/azure/azure-resource-manager/templates/key-vault-parameter#grant-access-to-the-secrets).

::: zone-end

### Get the key vault's resource ID

To use the key vault secrets in your deployment, you need the resource ID of the vault. Run the following command to retrieve the key vault's resource ID:

::: zone pivot="cli"

```azurecli
az keyvault show --name $keyVaultName --query id --output tsv
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
(Get-AzKeyVault -Name $keyVaultName).ResourceId
```

::: zone-end

The resource ID will look something like this example:

```Output
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/PlatformResources/providers/Microsoft.KeyVault/vaults/toysecrets
```

Copy the resource ID. You'll use it in the next step.

## Add a key vault reference to a parameter file

1. In the _main.parameters.dev.json_ file, append the following code after the `sqlDatabaseSku` parameter's closing brace. Make sure that you replace `YOUR-KEY-VAULT-RESOURCE-ID` with the value of the key vault resource ID you copied in the previous step. After you're finished, your parameters file should look like this example:

   :::code language="json" source="code/6-parameters-2.json" highlight="17-32" :::

1. Save the changes to the file.

## Deploy the Bicep template with parameter file and Azure Key Vault references

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. You're providing a parameter file along with a Bicep file.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters main.parameters.dev.json
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. You're providing a parameter file along with a Bicep file.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -TemplateParameterFile main.parameters.dev.json
```

::: zone-end

You aren't prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment this time. Azure retrieves the values from your key vault instead.

The deployment completes more quickly this time because the Azure resources already exist.

### Check your deployment

1. In your browser, go back to the Azure portal. Go to your resource group. You'll still see one successful deployment, because the deployment used the same name as the first deployment.

1. Select the **1 Succeeded** link.

1. Select the deployment called **main**.

1. On the left menu, select **Inputs**.

1. Notice that the `appServicePlanSku` and the `sqlDatabaseSku` parameter values have both been set to the values in the parameter file. Also, notice that the `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameter values aren't displayed, because you applied the `@secure()` decorator to them.

    :::image type="content" source="../media/6-parameter-values.png" alt-text="Screenshot of the Azure portal interface for the specific deployment showing the parameter values." border="true":::
