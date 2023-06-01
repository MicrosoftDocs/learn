


The company is designing and developing a new app. Developers need to ensure the storage is only accessed using keys and managed identities. The developers would like to use role-based access control. To help with testing, protected immutable storage is needed. 

## Architecture diagram

| Storage Plan  | Tasks|
| --- | --- |
| :::image type="content" source="../media/task-5.png" alt-text="Diagram with a storage account, managed identities, and a key vault." border="true"::: | <ul><li>Create a storage account. </li><li> Configure a user-assigned managed identity. </li><li>  Configure a system-assigned managed identity.</li><li>  Configure a key vault with key.  </li><li>  Configure a container with immutable storage. </li><li>  Configure an encryption scope. </li></ul> |

## Exercise instructions

> [!NOTE]
> To complete this lab you will need an [Azure subscription](https://azure.microsoft.com/free/).

1. Provide a storage account for the app. 

    - Search the portal for **Storage accounts**. 
    - Click **+ Create**. 
    - Provide a name for your storage account. 
    - **Review** and then **Create** the storage account.
    - Wait for the resource to deploy.

1. Provide a user-assigned managed identity for the storage to use.  [Learn more about managed identities](/azure/active-directory/managed-identities-azure-resources/overview)

    - Search for and select **Managed identities**.
    - Click **Create**.
        - Use your guided project resource group. 
        - Give your managed identity a name.
    - Click **Review and create** and then **Create**. 

1. Assign the correct permissions to the user-assigned managed identity. The identity only needs read and list containers and blobs. [Learn more about how to assign Azure roles](/azure/role-based-access-control/role-assignments-portal)
    
    - Browse to your storage account and select the **Access Control (IAM)** blade.
    - Click **Add role assignment**.
    - Search for and select the **Storage Data Blob Reader** role. 
    - On the **Members** tab, select **Managed identity**.
    - Click **Select members**, select the managed identity
    - Click **Select** and then **Review + assign** the role. 
    - Click **Review + assign** a second time to add the role assignment. 


1. Create a key vault to store the access keys. [Learn more about the Azure Key Vault](/azure/key-vault/general/overview)

    - Search for and select **Key vaults** in the portal, and then click **Create**.
    - Use your resource group.
    - Provide the name for the key vault.
    - Click **Review + create**, and then **Create**.
    - After the deployment, click **Go to resource**. 


1. Create a customer-managed key in the key vault. [Learn more about Azure Key Vault keys, secrets and certificates](/azure/key-vault/general/about-keys-secrets-certificates)

    - Select your key vault and then the **keys** blade.
    - Click **Generate/Import** and **Name** the key.
    - Take the defaults for the rest of the parameters, and **Create** the key.

1. Configure the storage account encryption to use customer managed keys in your key vault. [Learn more about customer managed keys on an existing storage account](/azure/storage/common/customer-managed-keys-configure-existing-account?WT.mc_id=Portal-Microsoft_Azure_Storage&tabs=azure-portal)

    - Select the storage account and the **Encryption** blade.
    - On the **Encryption** tab, select **Customer-managed keys**.
        - Select your key vault and key. 
        - Ensure the **Identity type** is **System-assigned**
        - **Save** your changes. 

1. The developers require a storage container where files can't be modified, even by the administrator. [Learn more about blob immutable storage](/azure/storage/blobs/immutable-storage-overview)

    - In your storage account, select the **Container** blade. 
    - Create a container called **hold** and upload a file to the container. 
    - From the **Overview** blade of your container, select the **Access policy** blade. 
    - In the **Immutable blob storage** section, click **+ Add policy**. 
    - For the **Policy type**, select **time-based retention**. 
    - Set the **Retention period** to **5 days**. 
    - Be sure to **Save** your changes. 
    - Try to remove the file in the container. 
    - Verify you can't delete the file due to policy. 

1. The developers require an encryption scope that enables infrastructure encryption. [Learn more about infrastructure encryption](/azure/storage/common/infrastructure-encryption-enable?tabs=portal)

    - Continue working with your new storage account. 
    - In the **Security + networking** blade, select **Encryption**.
     -In the **Encryption scopes** tab, click **Add**.
        - Give your encryption scope a **name**. 
        - The encryption type is **Microsoft-managed key**.
        - Set infrastructure encryption to **Enable**. 


> [!NOTE]
> For additional practice complete the [Secure and isolate access to Azure resources by using network security groups and service endpoints](/training/modules/secure-and-isolate-with-nsg-and-service-endpoints/) module. The module has a sandbox where you can get more practice restricting access to storage.
