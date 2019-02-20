Clients and applications must be authenticated to connect to an Azure Blob storage account. We have several ways to do this, but the easiest approach for trusted applications is to use the _storage key_. Since we're managing the import process, let's use this approach.

We'll need two pieces of information to connect PolyBase to our Azure Storage account:

1. URL of the storage account
1. Private storage key

We can get both of these values from the Azure portal.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in retrieving the access keys to an Azure Storage account.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the Storage account, under **Settings**, select **Access keys**.
1. In the Access keys blade, copy the value of **key1** and save it to a temporary file - we'll use it in the next unit.

    ![Screenshot of Getting Access Key](../media/6-get-access-key.png)

1. Next, navigate to your blob container (use the **Blobs** section of the storage account and then select the **data-files** container).
1. Select the **Properties** option under **Settings**.
1. Copy the **URL** to the container - it should be something like `https://demodwstorage.blob.core.windows.net/data-files`.

    ![Screenshot of Copying URL](../media/6-copy-url.png)

1. Save the URL into the same text file.

> [!IMPORTANT]
> The Storage account access keys allow _full-access_ to the contents in the storage account. Never disclose these keys to untrusted parties or third-party applications. Check out the [Secure your Azure Storage account](https://docs.microsoft.com/learn/modules/secure-azure-storage-account/) module for more information on managing the security of your storage account.
