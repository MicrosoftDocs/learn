You can store application connection strings, credentials, passwords, and other sensitive information in Azure Key Vault. You also need to provide credentials to access Key Vault. With managed identity, you can use the service principal created for your service to generate an access token to authenticate to Azure Key Vault.

Your stock-tracking application connects to an Azure SQL Database. Previously, your on-premises app stored the connection string in config files. As part of the migration to Azure, you're now securely storing all credentials and connection strings in an Azure key vault.

With your stock-tracking application running on a virtual machine, you can use the system-assigned managed identity you created. You add a policy to your key vault that grants the appropriate permissions to the VM.

In this exercise, you'll edit your app to use the new key vault. Then grant the managed identity for the VM access to retrieve the database connection. Finally, you'll build and run an app on the VM to access Key Vault and retrieve the information.

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

1. Move to the **identity/secretapp** folder:

    ```bash
    cd ~/identity/secretapp
    ```

1. Open the **Program.cs** file using the *nano* editor:

    ```bash
    nano Program.cs
    ```

    This file contains the C# source code for the sample app.

1. Examine the **Main** method:

    ```C#
    static void Main(string[] args)
    {
        AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
        GetSecretFromKeyVault(azureServiceTokenProvider).Wait();
    }
    ```

    This method is the entry point of the application. The code obtains a reference to an **AzureSericeTokenProvider** object. This object can issue access tokens for resources based on their credentials. The code then runs the **GetSecretFromKeyVault** method, using the token provider.

1. Scroll down to the **GetSecretFromKeyVault** method, and examine the first block of code in this method:

    ```C#
    private static async Task GetSecretFromKeyVault(AzureServiceTokenProvider azureServiceTokenProvider)
    {
        KeyVaultClient keyVaultClient =
            new KeyVaultClient(
                new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));
        ...
    }
    ```

    This code uses the **AzureServiceTokenProvider** object to authenticate the client making the request. Behind the scenes, this code obtains the system-managed identity for the VM running the code, and generates a **KeyVaultClient** object that contains this ID. You can then use this **KeyVaultClient** object to attempt to access the key vault.

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
 
    Replace **"\<key vault name\>"** with your key vault name. Replace **\<secret name\>** with **"DBCredentials"**, the name of the secret you created in the key vault.

    This block of code calls the **GetSecretAsync** method of the **KeyVaultClient** object to retrieve a specific secret and display its value. If the client doesn't have permission to access the key, this code throws an exception, and displays an error message.

    > [!NOTE]
    > There's no password, certificate, or client secret being stored in the code.

1. Save your changes, press <kbd>CTRL</kbd>+<kbd>O</kbd>, and then press Enter.

1. Close the nano editor, press <kbd>CTRL</kbd>+<kbd>X</kbd>.

## Test the application

1. Run the following command to build the application:

    ```bash
    dotnet restore
    dotnet build
    ```

    If you have edited the program correctly the app should build without any errors.

1. Run the application:

    ```bash
    dotnet run
    ```

    You haven't yet authorized the service principal associated with the VM to access your key vault. The application should respond with the error message:

    `Something went wrong: Operation returned an invalid status code 'Forbidden'`

## Grant permissions to enable the service principal to retrieve secrets from Key Vault

1. Close your connection to the VM:

    ```bash
    exit
    ```

1. You should still have a note of the principal ID for your VM from the previous exercise. If not, run the following command to find the system-assigned ID for your VM. Replace `<vm name>` with the name of your VM:

    ```azurecli
    az vm identity show \
      --name <vm name> \
      --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

    The value returned should look like this. Your IDs will be different:

    ```JSON
    {
        "principalId": "dba6da53-9780-47fa-8fc4-4b25f153e845",
        "tenantId": "a95b1a51-dc91-419a-8162-877418afd1be",
        "type": "SystemAssigned",
        "userAssignedIdentities": null
    }
    ```

    Use the above value to return only the principal ID in the next command.

1. Authorize the VM to retrieve and list secrets in your key vault using this principal ID:

    ```azurecli
    az keyvault set-policy \
        --name $KVNAME \
        --secret-permissions get list \
        --object-id $(az vm identity show \
                        --name prodserver \
                        --resource-group <rgn>[Sandbox resource group]</rgn> \
                        --output tsv \
                        --query principalId)
    ```

    The value returned will be in JSON format and contains ID, location, name, and all the associated properties.

## Test the application again

1. Sign in to your VM:

    ```bash
    ssh $publicIP
    ```

1. Change to the `identity/secretapp` directory:

    ```bash
    cd ~/identity/secretapp
    ```

1. Run the application:

    ```bash
    dotnet run
    ```

    This time, the application should successfully retrieve the secret from Key Vault and display its value:

    `Database connection string:: Server=tcp:prodserverSQL.database.windows.net,1433;Database=myDataBase;User ID=mylogin@myserver;Password=examplePassword;Trusted_Connection=False;Encrypt=True;`