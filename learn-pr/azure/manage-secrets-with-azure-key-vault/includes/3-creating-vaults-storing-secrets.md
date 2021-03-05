## Create key vaults for your applications

Good practice is to create a separate vault for each deployment environment of each of your applications, such as development, test, and production. You can use a single vault to store secrets for multiple apps and environments, but the impact of an attacker gaining read access to a vault increases with the number of secrets in the vault.

> [!TIP]
> If you use the same names for secrets across different environments for an application, the only environment-specific configuration that has to change in your app is the vault URL.

Creating a vault requires no initial configuration. Your user identity is automatically granted the full set of secret management permissions and you can start adding secrets immediately. Once you have a vault, adding and managing secrets can be done from any Azure administrative interface, including the Azure portal, the Azure CLI, and Azure PowerShell. When you set up your application to use the vault, you'll need to assign the correct permissions to it; we'll see that in the next unit.

## Create the vault and store the secret in it

Given all the trouble the company's been having with application secrets, management has asked you to create a small starter app to set the other developers on the right path. The app needs to demonstrate best practices for managing secrets as simply and securely as possible.

To start, you'll create a vault and store one secret in it.

### Create the vault

**Key vault names must be globally unique, so you'll need to pick a unique name**. Vault names must be 3-24 characters long and contain only alphanumeric characters and dashes. Make a note of the vault name you choose, as you'll need it throughout this exercise.

To create your vault, in the Cloud Shell, run the following command. Make sure to enter your unique vault name to the `--name` parameter.

```azurecli
az keyvault create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --location centralus \
    --name <your-unique-vault-name>
```

When it finishes, you'll see JSON output describing the new vault.

> [!TIP]
> The command used the pre-created resource group named **<rgn>[sandbox Resource Group]</rgn>**. When working with your own subscription, you would want to either create a new resource group, or use an existing one you have previously created.

### Add the secret

Now, add the secret: our secret will be named **SecretPassword** with a value of **reindeer_flotilla**. Make sure to enter your unique vault name to the `--vault-name` parameter.

```azurecli
az keyvault secret set \
    --name SecretPassword \
    --value reindeer_flotilla \
    --vault-name <your-unique-vault-name>
```

You'll write the code for your app shortly, but first you need to learn a little bit about how your app is going to authenticate to a vault.