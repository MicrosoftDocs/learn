To get some quick experience with Azure Key Vault, let's create a new Key Vault and do the most basic operation available: store a secret. Creating a vault in the Azure portal requires no initial configuration. Your signed-in user identity is automatically granted the full set of secret management permissions, and you can start adding secrets immediately. Once you have a vault, adding and managing secrets can be done from any Azure administrative interface, including the Azure portal, the Azure CLI, and Azure PowerShell.

## Create a new Azure Key Vault

Let's start by creating a new Key Vault in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) using the same credentials you used to activate the Azure Sandbox.

1. Select **Create a resource**. The **Create a resource** pane appears.

1. In the **Search services and marketplace**, search for and select *Key Vault* to find the Azure Key Vault service. The **Key Vault** pane appears.

1. Select **Create**. The **Create key vault** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project details** |
    | Subscription | From the dropdown, select *Concierge Subscription*. |
    | Resource group | From the dropdown, select <rgn>[sandbox resource group name]</rgn>. |
    | **Instance details** |
    | Key vault name | Enter a globally unique name for the new vault. Vault names must be 3-24 characters long and contain only alphanumeric characters and dashes. The exercise uses the example name of *VaultamortDiary* for the new vault.
    | Region | Accept default. |
    | Pricing tier | Accept default. |

1. Select **Review + create**.

1. After validation passes, select **Create** to create the Azure Key Vault.

After the deployment is complete, select **Go to resource**. Your *Key vault* pane appears.

## Add a secret

Next, add a new secret to the vault.

1. In the left menu pane, under **Objects**, select **Secrets**. The **Secrets** pane appears for your key vault.

1. In the top menu bar, select **Generate/Import**. The **Create a secret** pane appears.

1. Enter a name, value, and (optional) content type. An example follows.

   :::image type="content" source="../media/1-create-secret.png" alt-text="Screenshot showing the Create a secret pane in the Azure portal for Azure Key Vault.":::

1. Select **Create** to add the secret. The **Secrets** pane reappears.

## Show the secret

Finally, verify that the secret value has been set.

1. Select your secret from the list. The **Versions** pane appears for your secret.

1. Select the **CURRENT VERSION** of the secret. The **Secret Version** pane appears.

1. Select **Show Secret Value** to see the value assigned to the secret.

   :::image type="content" source="../media/1-show-secret.png" alt-text="Screenshot showing the secret value in the Azure portal.":::

## Other ways to consume the secret

You can create and retrieve secrets from the Azure Key Vault as long as you're authenticated with Microsoft Entra ID using the REST API, native SDKs, Azure CLI, or Azure PowerShell. For example, here's the same process using Azure PowerShell.

```powershell
Get-AzKeyVault
```

This command returns the created vault with the name **VaultamortDiary**.

```output
Vault Name          : VaultamortDiary
Resource Group Name : Learn-4f01665a-1272-46a8-9c16-83bbf146494e
Region              : northcentralus
Resource ID         : /subscriptions/xyz/providers/Microsoft.KeyVault/vaults/VaultamortDiary
```

With the name of the vault and the key, you can retrieve the secret value:

```powershell
Get-AzKeyVaultSecret -VaultName 'VaultamortDiary' -Name 'HiddenLocation'
```

This command returns our set value:

```output
Vault Name   : vaultamortdiary
Name         : VaultamortDiary
Version      : ff4b23af35bf4ba9a5c8792227d00ff6
Id           : https://vaultamortdiary1972.vault.azure.net:44
               3/secrets/VaultamortDiary/ff4b23af35bf4ba9
               a5c8792227d00ff6
Enabled      : True
Expires      :
Not Before   :
Created      : 12/17/2020 7:54:03 PM
Updated      : 12/17/2020 7:54:03 PM
Content Type : text
Tags         :
```

> [!NOTE]
> The module [Manage secrets in your server apps with Azure Key Vault](/training/modules/manage-secrets-with-azure-key-vault/) shows how to use the Azure CLI and various programming languages to create Key Vaults, set, and retrieve secrets.
