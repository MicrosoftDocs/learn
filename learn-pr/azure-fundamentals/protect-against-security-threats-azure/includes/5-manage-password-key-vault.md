In this exercise, you add a password to Azure Key Vault. A password is an example of sensitive information that you need to protect. You then read the password from Azure Key Vault to verify that the password is accessible.

In practice, there are several ways to add secrets to and read secrets from Key Vault. You can use the Azure portal, the Azure CLI, or Azure PowerShell. By using your favorite programming language, your applications can also securely access the secrets that they need.

Here, you create a secret in Key Vault by using the Azure portal. You then access the secret from the portal and from the Azure CLI in Azure Cloud Shell.

The Azure CLI is a way to work with Azure resources from the command line or from scripts. Cloud Shell is a browser-based shell experience to manage and develop Azure resources. Think of Cloud Shell as an interactive console that runs in the cloud.

## Create a key vault

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure portal menu, or from the **Home** page, select **Create a resource**.

1. From the search bar, enter **Key Vault**, and then select **Key Vault** from the results.

1. On the **Key Vault** panel, select **Create**. The **Create key vault** panel appears.

1. On the **Basics** tab, fill in the following values for each setting.

    > [!NOTE]
    > Replace *NNN* with a series of numbers. This helps ensure that the name of your key vault is unique.

    | Setting | Value |
    | --- | --- |
     **Project details** |
    | Subscription | **Concierge Subscription** |
    | Resource group | **<rgn>[sandbox resource group name]</rgn>** |
    | **Instance details** |
    | Key vault name | **my-keyvault-NNN** |

    Leave the other settings at their default values.

1. Select **Review + create**, and then select **Create**.

    Wait for the creation process to finish.

1. Select **Go to resource**.

1. Note some of the details about your key vault.

    For example, the **Vault URI** field shows the URI that your application can use to access your vault from the REST API.

    Here's an example for a key vault that's named **my-keyvault-321**:

    :::image type="content" source="../media/5-portal-key-vault-overview.png" alt-text="A screenshot of the Azure portal showing details about a key vault. It shows fields such as the parent resource group, location, and DNS name.":::

1. As an optional step, on the left nav bar, under the **Settings** section, examine some of the other features.

    Although they're initially empty, here you'll find places where you can store keys, secrets, and certificates.

    > [!NOTE]
    > Your Azure subscription is the only one that's authorized to access this vault. Under **Settings**, the **Access policies** feature enables you to configure access to the vault.

## Add a password to the key vault

1. On the left nav bar, under **Settings**, select **Secrets**. Your Key vault panel appears.

1. From the top menu bar, select **Generate/Import**. The **Create a secret** panel appears.

1. Fill in the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | Upload options | **Manual** |
    | Name | **MyPassword** |
    | Value | **hVFkk96** |

    Leave the other settings at their default values. Notice that you can specify properties such as the activation date and the expiration date. You can also disable access to the secret.

1. Select **Create**.

## Show the password

Here, you access the password from Key Vault two times. First, you access it from the Azure portal. Next, you access it from the Azure CLI.

1. From your **Key Vault/Secrets** panel, select **MyPassword**. The **MyPassword/Versions** panel appears. You see that the current version is enabled.

1. Select the current version. The **Secret Version** panel appears.

    Under **Secret Identifier**, you see a URI that you can now use with applications to access the secret. Remember, only authorized applications can access this secret.

1. Select **Show Secret Value**.

    :::image type="content" source="../media/5-portal-secret-value.png" alt-text="A screenshot of the Azure portal showing the secret value in the key vault.":::

1. From the Cloud Shell pane to the side of the screen, run this command.

    > [!NOTE]
    > If you're not familiar with the Azure CLI, just follow along.

    ```azurecli
    az keyvault secret show \
      --name MyPassword \
      --vault-name $(az keyvault list --query [0].name --output tsv) \
      --query value \
      --output tsv
    ```

    You see the password in the output.

    ```output
    hVFkk96
    ```

Good work! At this point, you have a key vault that contains a password secret that's securely stored for use with your applications.

[!include[](../../../includes/azure-sandbox-cleanup.md)]
