
In this exercise you'll learn how to perform the following actions by using the Azure CLI:

* Create a Key Vault
* Add and retrieve a secret

## Prerequisites

* * An **Azure account** with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free)


## Log in to Azure and start the Cloud Shell

1. Log in to the [Azure portal](https://portal.azure.com) and open the Cloud Shell.

    :::image type="content" source="../media/cloud-shell-menu.png" alt-text="The location of Cloud Shell launch button.":::

1. After the shell opens be sure to select the **Bash** environment.

    :::image type="content" source="../media/shell-bash-selection.png" alt-text="Selecting the Bash environment.":::


## Create a Key Vault

1. Let's set some variables for the CLI commands to use to reduce the amount of retyping. Replace the `<myLocation>` variable string below with a region that makes sense for you. The Key Vault name needs to be a globally unique name, and the script below generates a random string.

    ```bash
    myKeyVault=az204vault-$RANDOM
    myLocation=<myLocation>
    ```
1. Create a resource group. 

    ```azurecli
    az group create --name az204-vault-rg --location $myLocation
    ```

1. Create a Key Vault by using the `az keyvault create` command. 

    ```azurecli
    az keyvault create --name $myKeyVault --resource-group az204-vault-rg --location $myLocation
    ```

    > [!NOTE]
    > This can take a few minutes to run.

## Add and retrieve a secret

To add a secret to the vault, you just need to take a couple of additional steps. 

1. Create a secret. Let's add a password that could be used by an app. The password will be called **ExamplePassword** and will store the value of **hVFkk965BuUv** in it.

    ```azurecli
    az keyvault secret set --vault-name $myKeyVault --name "ExamplePassword" --value "hVFkk965BuUv"
    ```

1. Use the `az keyvault secret show` command to retrieve the secret.

    ```azurecli
    az keyvault secret show --name "ExamplePassword" --vault-name $myKeyVault
    ```

    This command will return some JSON. The last line will contain the password in plain text. 

    ```json
    "value": "hVFkk965BuUv"
    ```

You have created a Key Vault, stored a secret, and retrieved it.

## Clean up resources

When you no longer need the resources in this exercise use the following command to delete the resource group and associated Key Vault.

```azurecli
az group delete --name az204-vault-rg --no-wait 
```
