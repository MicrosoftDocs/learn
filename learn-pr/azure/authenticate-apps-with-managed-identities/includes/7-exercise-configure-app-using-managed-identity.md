You can store application secrets, credentials, passwords, and other sensitive information in Azure Key Vault. You also need to provide credentials to access Key Vault. With Managed Identity, you can use the service principal created for your service to generate an access token to identify yourself to Azure Key Vault.

In the sample scenario, the stock-tracking application requires access to secret information in Key Vault. The stock-tracking application runs on a virtual machine. Your current app can only run on a single VM, so you're going to use the system-assigned managed identity you created. Then you'll add a policy to your Key Vault that assigns the appropriate permissions to the VM's service principal.

In this exercise, you'll create a secret and store it in Key Vault. Then you'll assign the service principal for the VM you created in the earlier exercises permissions to retrieve this secret. Finally, you'll build and run an app on the VM that uses the service principal to access Key Vault – then retrieve the secret.

## Use Key Vault to store a secret

1. Add a secret named *MySecret* with the value *Secret app data* to the key vault:

    ```azurecli
    az keyvault secret set \
      --vault-name furniture-secrets \
      --name MySecret \
      --value "Secret app data"
    ```

## Create an app to fetch secret information from Key Vault

1. Sign in to the VM you created earlier:

    ```bash
    ssh $publicIP
    ```

    > [!NOTE]
    > If the environment variable `publicIP` isn't set, reset it with the following command to:
    >
    > ```azurecli
    > export publicIP=$(az vm show \
    > --name prodserver \
    > --resource-group <rgn>[Sandbox resource group]</rgn> \
    > --show-details \
    > --query [publicIps] \
    > --output tsv)
    >```
    >
    > Then rerun `ssh $publicIP`


1. Move to the `identity/secretapp` folder:

    ```bash
    cd ~/identity/secretapp
    ```

1. Open the `Program.cs` file using the *nano* editor:

    ```bash
    nano Program.cs
    ```

    This file contains the C# source code for the sample app.

1. Examine the `Main` method:

    ```C#
    static void Main(string[] args)
    {
        AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
        GetSecretFromKeyVault(azureServiceTokenProvider).Wait();
    }
    ```

    This method is the entry point of the application. The code obtains a reference to an `AzureSericeTokenProvider` object. This object can issue access tokens for resources based on their credentials. The code then runs the `GetSecretFromKeyVault` method, using the token provider.

1. Scroll down to the `GetSecretFromKeyVault` method, and examine the first block of code in this method:

    ```C#
    private static async Task GetSecretFromKeyVault(AzureServiceTokenProvider azureServiceTokenProvider)
    {
        KeyVaultClient keyVaultClient =
            new KeyVaultClient(
                new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
        ...
    }
    ```

    This code uses the `AzureServiceTokenProvider` object to authenticate the client making the request. Behind the scenes, this code obtains the system-managed identity for the VM running the code, and generates a `KeyVaultClient` object that contains this ID. You can then use this `KeyVaultClient` object to attempt to access the Key Vault.

1. Look at the next part of the code:

    ```C#
    var keyVaultName = "<key vault name>";
    var keyVaultSecretName = "<secret name>";

    try
    {
        var secret = await keyVaultClient
            .GetSecretAsync($"https://{keyVaultName}.vault.azure.net/secrets/{keyVaultSecretName}")
            .ConfigureAwait(false);

        Console.WriteLine($"Secret: {secret.Value}");

    }
    catch (Exception exp)
    {
        Console.WriteLine($"Something went wrong: {exp.Message}");
    }
    ```

    Replace `"<key vault name>"` with the name `"furniture-secrets"`. Replace `<secret name>` with `"MySecret"`, the name of the secret you created in the key vault.

    This block of code calls the `GetSecretAsync` method of the `KeyVaultClient` object to retrieve a specific secret and display its value. If the client doesn't have permission to access the key, this code throws an exception, and displays an error message.

    > [!NOTE]
    > There is no password, certificate, or client secret being stored in the code.

1. Save your changes (press `CTRL-O`), and close the editor (press `CTRL-X`).

## Test the application

1. Run the following command to build the application:

    ```bash
    export PATH=$PATH:/snap/dotnet-sdk/current
    dotnet build
    ```

1. Run the application:

    ```bash
    dotnet run
    ```

    You haven't authorized the service principal associated with the VM to access your key vault yet, so the application should respond with the error message:

    `Something went wrong: Operation returned an invalid status code 'Forbidden'`

## Grant permissions to enable the service principal to retrieve secrets from Key Vault

1. Close your connection to the VM:

    ```bash
    exit
    ```

1. You should still have a note of the principal ID for your VM from the previous exercise. If not, run the following command to find the system-assigned ID for your VM. Replace *\<vm name>* with the name of your VM:

    ```azurecli
    az vm identity show \
      --name prodserver \
      --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

    The value returned should look like this – your IDs will be different:

    ```JSON
    {
        "principalId": "dba6da53-9780-47fc-8fc4-4b25f154e845",
        "tenantId": "a95baa51-dc91-4b9a-8362-877408afddbe",
        "type": "SystemAssigned",
        "userAssignedIdentities": null
    }
    ```

    Use the above value to return just the principalID in the next command.

1. Authorize the VM to retrieve and list secrets in your key vault using this principal ID:

    ```azurecli
        az keyvault set-policy \
          --name furniture-secrets \
          --object-id $(az vm identity show --name prodserver --resource-group <rgn>[Sandbox resource group]</rgn> --o tsv --query principalId) \
          --secret-permissions get list
    ```

    The value return will be in JSON format, it contain: id, location, name and all the associated properties.

## Test the application again

1. Sign in to your VM:

    ```bash
    ssh $publicIP
    ```

1. Go to the `identity/secretapp` folder:

    ```bash
    cd ~/identity/secretapp
    ```

1. Run the application:

    ```bash
    export PATH=$PATH:/snap/dotnet-sdk/current
    dotnet run
    ```

    This time the application should successfully retrieve the secret from Key Vault and display its value:

    `Secret: Secret app data`