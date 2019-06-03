You can store application secrets, credentials, passwords, and other sensitive information in Azure Key Vault. However, you also need to provide credentials to access Key Vault itself. If you're using Managed Identity, you can utilize the service principal created for your service to generate an access token to identify yourself to Azure key vault.

In the sample scenario, the stock-tracking application requires access to secret information in Key Vault. The stock-tracking application runs on a virtual machine. You can use the service principal assigned by the Managed Identity service for your VM. Add a policy to your Key Vault that assigns the appropriate permissions to the service principal for the VM.

In this exercise, you'll create a secret and store it in Key Vault. Then, you'll assign the service principal for the VM you created in the earlier exercises permissions to retrieve this secret. Finally, build and run an app on the VM that uses the service principal to access Key Vault and retrieve the secret.

## Use Key Vault to store a secret

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Run the following command to create a new key vault. Select a unique name for your key vault.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    ```azurecli
    az keyvault create \
      --name <key vault name> \
      --resource-group <rgn>[Sandbox resource group]</rgn>
      --location <location>
    ```

1. Add a secret named *MySecret* with the value *Secret app data* to the key vault:

    ```azurecli
    az keyvault secret set \
      --vault-name <key vault name> \
      --name MySecret \
      --value "Secret app data"
    ```

## Create an app to fetch secret information from Key Vault

1. Sign in to the VM you created earlier:

    ```bash
    ssh <public ip address of VM>
    ```

    > [!NOTE]
    > If you can't recall the IP address of your VM, run the following command:
    >
    > ```azurecli
    > az vm list-ip-addresses \
    >     --name <vm name> \
    >     --resource-group <rgn>[Sandbox resource group]</rgn> \
    >| grep ipAddress
    >```

1. Run the following command to download the source code for the sample app for this exercise:

    <!-- TODO: Replace <location of repository> with the name of the repository containing the sample code in GitHub. The source code is currently supplied in the src folder for this module -->

    ```bash
    git clone http://github.com/<location of repository> secrets
    ```

1. Move to the `secrets/secretapp` folder:

    ```bash
    cd secrets/secretapp
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

    This method is the entry point of the application. The code obtains a reference to an `AzureSericeTokenProvider` object. This is the object that can issue access tokens for resources based on their credentials. The code then runs the `GetSecretFromKeyVault` method, using the token provider.

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

    Replace *\<key vault name\>* with the name of the key vault you created earlier. Replace *\<secret name\>* with *"MySecret", the name of the secret you creates in the key vault.

    This block of code calls the `GetSecretAsync` method of the `KeyVaultClient` object to retrieve a specific secret and display its value. If the client doesn't have permission to access the key, then this code throws and exception and displays an error message.

1. Save your changes (press CTRL-O), and close the editor (press CTRL-X).

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

    You haven't authorized the service principal associated with the VM to access your key vault yet, so the application should respond with the error message *Something went wrong: Operation returned an invalid status code 'Forbidden'*

## Grant permissions to enable the service principal to retrieve secrets from Key Vault

1. Close your connection to the VM:

    ```bash
    exit
    ```

1. You should still have a note of the principal ID for your VM from the previous exercise. If not, run the following command to find the system-assigned ID for your VM. Replace *\<vm name>* with the name of your VM:

    ```azurecli
    az vm identity show \
      --name <vm name> \
      --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

    The value returned should look like this (your IDs will be different):

    ```JSON
    {
        "principalId": "dba6da53-9780-47fc-8fc4-4b25f154e845",
        "tenantId": "a95baa51-dc91-4b9a-8362-877408afddbe",
        "type": "SystemAssigned",
        "userAssignedIdentities": null
    }
    ```

    Make a note of the value for the *principalId*.

1. Authorize the VM to be able to retrieve and list secrets in your key vault using this principal ID.

    ```azurecli
        az keyvault set-policy \
          --name "<key vault name>" \
          --object-id "<principal id>" \
          --secret-permissions get list
    ```

## Test the application again

1. Sign in to your VM again:

    ```bash
    ssh <public ip address of VM>
    ```

1. Move to the `secrets/secretapp` folder:

    ```bash
    cd secrets/secretapp
    ```

1. Run the application:

    ```bash
    export PATH=$PATH:/snap/dotnet-sdk/current
    dotnet run
    ```

    This time the application should successfully retrieve the secret from Key Vault and display its value, *Secret app data*.