Use these Try-This exercises to get some hands-on experience with Azure.

In this demonstration, we will explore the Azure Key Vault.

## Task 1: Create a key vault

In this task, we will create a key vault.

1. Sign in to the Azure portal and search for **Key Vaults**.
1. On the Key vaults page, click **+ Create**.
1. On the **Basics** tab, fill out the required information.
     -  Discuss the **Pricing tier** selections, Standard and Premium. Premium supports HSM-backed keys.
     -  Discuss **Soft delete** and **Retention period**.
1. Click **Review and Create** and then **Create**.
1. Wait for the new key vault to be created, or move to a key vault that has already been created.

## Task 2: Review key vault settings

In this task, we will review key vault settings.

1. In the Portal, navigate to the key vault.
1. Under the **Name** list, click the newly created **Key Vault**.
1. Under the **Objects**, click **Keys**.
1. Click **Generate/Import** and review the Keys configuration information.
1. Under **Settings**, click **Secrets**.
1. Click **Generate/Import**, review the Secrets configuration information, and click **Create**.
1. View the new Secret and note that keys support versioning.
1. Under **Settings**, click **Certificates**.
1. Click **Generate/Import** and review the Certificates configuration information.

## Task 3: Configure access policies

> [!NOTE]
> To complete this demonstration you will need a non-privileged test user.

In this task, we will configure access policies and test access.

1. Continue in the Portal with your key vault.
1. Under **Settings**, click **Access Policies**.
1. Review the **Enable access to** choices: Azure Virtual Machines for deployment, Azure Resource Manager for template deployment, and Azure Disk Encryption for volume encryption.
1. Review the creator account **Key Permissions**. Note the **Cryptographic operation** permissions are not assigned.
1. Review the creator account **Secret Permissions**. Note the **Purge** permission.
1. Review the creator account **Certificate Permissions**.
1. Open the **Cloud Shell** with the **Bash** option. You should be signed in as a Global Administrator.
1. Use your key information to verify the secret you created in the previous task displays successfully for this role.
    
    ```CLI
    az keyvault secret show --name <secret_name> --vault-name <keyvault_name>'
    
    ```
1. In another browser tab, open the portal, and sign-in as the test user.
1. Open the **Cloud Shell** with the **Bash** option.
1. Verify that the secret does not display for the test user. Access is denied.
    
    ```CLI
    az keyvault secret show --name <secret_name> --vault-name <keyvault_name>
    
    ```
1. Return to the Global Administrator account in the portal.
1. Add the Key Vault Contributor role to your test user.
1. Try the test user's access. Access is denied.
    
    ```CLI
    az keyvault secret show --name <secret_name> --vault-name <keyvault_name>
    
    ```
1. Explain that adding the RBAC role grants access to the Key Vault control plane. It does not grant access to the date in the Key Vault.
1. Return to your Key Vault and create an access policy.
1. Under **Settings**, select **Access policies** and then **Add Access Policy**.
     -  Configure from the template (optional): **Key, Secret, &amp; Certificate Management**
     -  Key permissions: **none**
     -  Secret permissions: **Get, List**
     -  Certificate permissions: **none**
     -  Select principal: **select your test user**

1. Be sure to **Add** your new access policy. And to **Save** your changes.
1. Try the test user's access. The user should now have access and the key should display.
    
    ```CLI
    az keyvault secret show --name <secret_name> --vault-name <keyvault_name>
    
    ```
1. As you have time, return to the Secret configuration settings and change **Enabled** to **No**. Be sure to save your changes, then try access the key again.
