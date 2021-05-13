To get some quick experience with Azure Key Vault, let's create a new Key Vault and do the most basic operation available: store a secret. Creating a vault in the Azure portal requires no initial configuration. Your signed-in user identity is automatically granted the full set of secret management permissions, and you can start adding secrets immediately. Once you have a vault, adding and managing secrets can be done from any Azure administrative interface, including the Azure portal, the Azure CLI, and Azure PowerShell.

## Create a new Azure Key Vault

Let's start by creating a new Key Vault in the Azure portal.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using the same credentials you used to activate the Azure Sandbox.
1. Select **+ Create a resource**.
1. Type **Key Vault** into the search box to find the Azure Key Vault service, and then select **Create**.

1. On the **Basics** tab:
    - Make sure the _Concierge Subscription_ is selected in the **Subscription** dropdown.
    - Select <rgn>[The Sandbox resource group]</rgn> from the **Resource group** dropdown.
    - Enter a globally unique name for the new vault. Vault names must be 3-24 characters long and contain only alphanumeric characters and dashes. The exercise uses the example name of **VaultamortDiary** for the new vault.
    - Leave the default selected values for **Region** and **Pricing tier**.

1. Select **Review + create** to go to the validation screen.
1. Select **Create** to create the Azure Key Vault.

Once the deployment is complete, navigate to the resource.

## Add a secret

Next, add a new secret to the vault.

1. In the Azure portal, select **Secrets** under the **Settings** section of your Azure Key Vault.
1. Click the **Generate/Import** button at the top of the **Secrets** panel.
1. Fill out the **Create a secret** screen with a name, value, and (optional) content type. An example is shown below.

    ![Screenshot showing the Create a secret pane in the Azure portal for Azure Key Vault](../media/1-create-secret.png)

1. Select **Create** to add the secret.

## Show the secret

Finally, verify that the secret value has been set.

1. Select your secret from the list and then select the current version of the secret.
1. Select **Show Secret Value** to see the value assigned to the secret.

    ![Screenshot showing the secret value in the Azure portal](../media/1-show-secret.png)

## Other ways to consume the secret

You can create and retrieve secrets from the Azure Key Vault as long as you are authenticated with Azure AD using the REST API, native SDKs, Azure CLI, or Azure PowerShell. For example, here's the same process using Azure PowerShell.

```powershell
Get-AzKeyVault
```

This will return the created vault with the name **VaultamortDiary**.

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

This returns our set value:

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
> The module [Manage secrets in your server apps with Azure Key Vault](https://docs.microsoft.com/learn/modules/manage-secrets-with-azure-key-vault/) shows how to use the Azure CLI and various programming languages to create Key Vaults, set, and retrieve secrets.
