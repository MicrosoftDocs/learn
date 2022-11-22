In this exercise, you add a password to Azure Key Vault. A password is an example of sensitive information that you need to protect. You then read the password from Azure Key Vault to verify that the password is accessible.

In practice, there are several ways to add secrets to and read secrets from Key Vault. You can use the Azure portal, the Azure CLI, or Azure PowerShell. By using your favorite programming language, your applications can also securely access the secrets that they need.

Here, you create a secret in Key Vault by using the Azure portal. You then access the secret from the portal and from the Azure CLI in Azure Cloud Shell.

The Azure CLI is a way to work with Azure resources from the command line or from scripts. Cloud Shell is a browser-based shell experience to manage and develop Azure resources. Think of Cloud Shell as an interactive console that runs in the cloud.

## Create a key vault

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).<br>
2. On the Azure portal menu, or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.
3. In the search bar, enter *Key Vault*, and then select **Key Vault** from the results. **The Key Vault** pane appears.
4. Select **Create**. The **Create a key vault** pane appears.
5. On the **Basics** tab, enter the following values for each setting.

    > [!NOTE]
    > Replace *NNN* with a series of numbers. This helps ensure that the name of your key vault is unique.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Project details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        **Concierge Subscription**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
         **<rgn>\[sandbox resource group name\]</rgn>** 
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Instance details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Key vault name
      :::column-end:::
      :::column:::
        **my-keyvault-NNN** where NNN is a unique identifier
      :::column-end:::
    :::row-end:::
    
    
    Accept the remaining settings at their default values.<br><br>
6. Select **Review + create**, and after passing validation, select **Create**.<br><br>Wait for deployment to successfully complete.<br>
7. Select **Go to resource**.
8. Take note of some of the details about your key vault.<br><br>For example, the **Vault URI** field shows the URI that your application can use to access your vault from the REST API.<br><br>Here's an example for a key vault that's named **my-keyvault-321**: :::image type="content" source="../media/5-portal-key-vault-overview-90fc2a40.png" alt-text="A screenshot of the Azure portal showing details about a key vault. It shows fields such as the parent resource group, location, and DNS name.":::
    <br><br>
9. As an optional step, on the left menu pane, under **Settings**, examine some of the other features.<br><br>Although they're initially empty, here you'll find places where you can store keys, secrets, and certificates.
    
    > [!NOTE]
    > Your Azure subscription is the only one that's authorized to access this vault. Under **Settings**, the **Access policies** feature enables you to configure access to the vault.

## Add a password to the key vault

1. On the left menu pane, under **Settings**, select **Secrets**. Your key vault pane appears.
2. From the top menu bar, select **Generate/Import**. The **Create a secret** pane appears.
3. Fill in the following values for each setting.<br><br>
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Upload options
      :::column-end:::
      :::column:::
        **Manual**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        **MyPassword**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Value
      :::column-end:::
      :::column:::
        **hVFkk96**
      :::column-end:::
    :::row-end:::
    
    
    Accept the remaining settings at their default values. Notice that you can specify properties such as the activation date and the expiration date. You can also disable access to the secret.<br><br>
4. Select **Create**.

## Show the password

Here, you access the password from Key Vault two times. First, you access it from the Azure portal. Next, you access it from the Azure CLI.

1. From your **Key Vault/Secrets** pane, select **MyPassword**. The **MyPassword/Versions** pane appears. You see that the current version is enabled.<br><br>
2. Select the current version. The **Secret Version** pane appears.<br><br>Under **Secret Identifier**, you see a URI that you can now use with applications to access the secret. Remember, only authorized applications can access this secret.<br><br>
3. Select **Show Secret Value**. The unique value for this version of the password appears.<br><br>:::image type="content" source="../media/5-portal-secret-value-54fc6db7.png" alt-text="A screenshot of the Azure portal showing the secret value in the key vault.":::
    <br><br>
4. From Cloud Shell, run this command.
    
    > [!NOTE]
    > Replace **my-keyvault-NNN** with the name you used earlier.
    
    ```azurecli
    az keyvault secret show \
        --name MyPassword \
        --vault-name my-keyvault-NNN \
        --query value \
        --output tsv
    ```
    
    You see the password in the output.
    
    ```output
    hVFkk96    
    ```

Good work! At this point, you have a key vault that contains a password secret that's securely stored for use with your applications.

[!include[](../../../includes/azure-sandbox-cleanup.md)]
