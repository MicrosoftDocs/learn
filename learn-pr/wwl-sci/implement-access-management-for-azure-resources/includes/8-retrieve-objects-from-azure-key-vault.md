
Azure Key Vault is a secure tool for storing secrets, keys, and certificates. Once stored, these items can be used by users and applications to perform actions and operations in a secure method. The process to retrieve any of these resources is common. So we'll look at how to review a secret from a key vault.

### Add a secret to your key vault

To add a secret to the vault, follow the steps:

1.  Navigate to your new key vault in the Azure portal
2.  On the Key Vault settings pages, select **Secrets**.
3.  Select on **Generate/Import**.
4.  On the Create a secret screen choose the following values:
    
    | **Setting**    | **Value to enter**    |
    | -------------- | --------------------- |
    | Upload options | Manual                |
    | Name           | mySC300keyvaultSecret |
    | Value          | This is my secret     |
5.  Select **Create**.

### Retrieve a secret using the Azure portal

This process is simple. Open your key vault, then open the secret you created. Select the **Show secret value** button.

:::image type="content" source="../media/key-vault-view-secret-9b36f3cf.png" alt-text="Screenshot of the Azure Key Vault, with a secret open and the show secret value selected. You can read or copy the value in plain text.":::


### Retrieve a secret using CLI or PowerShell

You can quickly and easily grab a secret from your key vault using scripting languages.

**CLI**

```
az keyvault secret show --name "mySC300keyvaultSecret" --vault-name "<your-unique-keyvault-name>" --query "value"

```

***PowerShell***

```
$secret = Get-AzKeyVaultSecret -VaultName "<your-unique-keyvault-name>" -Name "mySC300keyvaultSecret" -AsPlainText

```

### Retrieve a secret in an application

If you're building an application that needs access to your key vault secrets, certificates, and keys that can be done. You can access the key vault using .NET, Node.js, Python, and other languages.
