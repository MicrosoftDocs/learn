You can store application connection strings, credentials, passwords, and other sensitive information in Azure Key Vault. To access Key Vault, you need to provide credentials. Now as part of the application move to an Azure VM, you can update it to use managed identities to get an access token to authenticate to Key Vault.

Your stock-tracking application connects to Azure SQL Database. Previously, your on-premises app stored the connection string in configuration files. As part of the migration to Azure, you now securely store all credentials and connection strings in an Azure Key Vault.

Your stock-tracking application runs on a virtual machine (VM), so you can use the system-assigned managed identity that you created. To your key vault, you add a policy that grants the appropriate permissions to the VM.

In this exercise, you'll edit your app to use the new key vault. Then, you'll grant the managed identity for the VM access so that the app can retrieve the database connection. Finally, you'll build and run an app on the VM to access Key Vault, and retrieve the information.

## Create an app to fetch secret information from Key Vault

1. Sign in to the VM that you created earlier.

    ```bash
    ssh $publicIP
    ```

    > [!NOTE]
    > If the environment variable `publicIP` isn't set, reset it by running the following command:
    >
    > ```azurecli
    > export publicIP=$(az vm show \
    >     --name prodserver \
    >     --resource-group "<rgn>[sandbox resource group name]</rgn>" \
    >     --show-details \
    >     --query [publicIps] \
    >     --output tsv)
    >```
    >
    > Then, rerun the `ssh $publicIP` command.

1. Move to the *identity/secretapp* folder.

    ```bash
    cd ~/identity/secretapp
    ```

1. Open the *Program.cs* file by using the nano editor.

    ```bash
    nano Program.cs
    ```

    This file contains the C# source code for the sample app.

1. Examine the `Main` method.

    ```C#
    static async Task Main(string[] args)
    {
        await GetSecretFromKeyVault().ConfigureAwait(false);
    }
    ```

    This method is the entry point of the application which just calls the `GetSecretFromKeyVault` method.

1. Go down to the `GetSecretFromKeyVault` method. Examine the method's first block of code.

    ```C#
    private static async Task GetSecretFromKeyVault()
    {
        var keyVaultName = "<key vault name>";
        Uri keyVaultUri = new Uri($"https://{keyVaultName}.vault.azure.net");

        SecretClient secretClient = new SecretClient(keyVaultUri, new DefaultAzureCredential());
        ...
    }
    ```

    Replace `"<key vault name>"` with your key vault name. This code uses the `DefaultAzureCredential` to authenticate the client that will make the request. Behind the scenes, this code obtains the system-managed identity for the VM that runs the code. It then generates an instance of `SecretClient` that will utilize this authentication scheme. You can use this `SecretClient` instance to access secrets in the key vault.

1. Look at the next part of the code.

    ```C#
    var keyVaultSecretName = "<secret name>";

    try
    {
        var secret = await secretClient.GetSecretAsync(keyVaultSecretName).ConfigureAwait(false);

        Console.WriteLine($"Secret: {secret.Value}");
    }
    catch (Exception exp)
    {
        Console.WriteLine($"Something went wrong: {exp.Message}");
    }
    ```

     Replace `<secret name>` with `"DBCredentials"`, which is the name of the secret that you created in the key vault.

    This block of code calls the `GetSecretAsync` method of the `SecretClient` to retrieve a specific secret and display its value. If the client doesn't have permission to access the key, then this code throws an exception, and displays an error message.

    > [!NOTE]
    > No password, certificate, or client secret is stored in the code.

1. To save your changes, press <kbd>Ctrl+O</kbd>, and then press <kbd>Enter</kbd>.

1. To close the nano editor, press <kbd>Ctrl+X</kbd>.

## Test the application

1. Run the following command to build the application.

    ```bash
    dotnet restore
    dotnet build
    ```

    If you correctly edited the program, the app should build without errors.

1. Run the application.

    ```bash
    dotnet run
    ```

    You haven't yet authorized the VM's service principal to access your key vault. Therefore, the application should respond with an error message:

    `Something went wrong: Operation returned an invalid status code 'Forbidden'`

## Grant permissions to enable the service principal to retrieve secrets from Key Vault

1. Close your connection to the VM.

    ```bash
    exit
    ```

1. In the previous exercise, you noted the principal ID for your VM. If you don't remember the principal ID, then run the following command to find the system-assigned ID for your VM. (The `$VMNAME` variable was set in the prior exercise to a value of `prodserver`.)

    ```azurecli
    az vm identity show \
      --name $VMNAME \
      --resource-group "<rgn>[sandbox resource group name]</rgn>"
    ```

    The following code is an example of the returned value. Your IDs will differ.

    ```JSON
    {
        "principalId": "aba6da53-9180-47fc-8fc4-4b35f154e845",
        "tenantId": "a95baa51-dcb1-4b9a-8312-8774a8afddbe",
        "type": "SystemAssigned",
        "userAssignedIdentities": null
    }
    ```

    Use this value to return only the principal ID in the next command.

1. Use the principal ID to authorize the VM to retrieve and list secrets in your key vault.

    ```azurecli
    az keyvault set-policy \
        --name $KVNAME \
        --secret-permissions get list \
        --object-id $(az vm identity show \
                        --name $VMNAME \
                        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
                        --output tsv \
                        --query principalId)
    ```

    The returned value is in JSON format. It contains the ID, location, name, and all of the associated properties.

## Test the application again

1. Sign in to your VM.

    ```bash
    ssh $publicIP
    ```

1. Change to the `identity/secretapp` folder.

    ```bash
    cd ~/identity/secretapp
    ```

1. Run the application.

    ```bash
    dotnet run
    ```

    This time, the application should retrieve the secret from Key Vault and display its value.

    ```output
    Database connection string:: Server=tcp:prodserverSQL.database.windows.net,1433;Database=myDataBase;User ID=mylogin@myserver;Password=examplePassword;Trusted_Connection=False;Encrypt=True;
    ```
