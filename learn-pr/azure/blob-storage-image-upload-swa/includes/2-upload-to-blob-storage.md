# Describe uploading to Blob Storage

You decided to store your users images on Azure Blob Storage, allowing them to upload images directly from their browsers. THe problem is if you have a storage backend that's accessed publicly via the browser, you want to restrict who's able to upload images there. By going the way of Azure Static Web Apps, you are presented with the problem of how to authenticate users towards Azure Blob Storage.

As you can see in the following image, your frontend cannot access Blob Storage. Your storage account key resides in Azure, and for security reasons you cannot share that with the world. So what do you do?

:::image type="content" source="../media/architecture_1.png" alt-text="Static Web App and Blob Storage":::

Luckily, there's a solution for that. Add an Azure Functions backend that takes care of generating Shared Access Signatures (SAS) so your users can upload pictures directly to Azure Blob Storage without you needing to share your storage account key with them. The security team at your company is happy, and your users are happy as well!

:::image type="content" source="../media/architecture_2.png" alt-text="Static Web App and Blob Storage via Azure Functions":::

## Describe Containers

When using your blob storage account you'd want to organize your blobs inside containers, to keep things organized. You can have a container for image uploads from your website users, while having a separate container to store videos, and a third one to keep documents. By separating your files this way, you can decide on granting specifc access to each container depending on the data access needs of each of your users. For this example, you are going to have a container called `images` where your image uploads will reside.

## Describe Cross-Origin Resource Sharing

Since you application lives in your company's domain name, a user won't be able to access your Azure Blob Storage account under `<StorageAccountName>.blob.core.windows.net`. This is due to a browser security feature called [same-origin policy](https://www.w3.org/Security/wiki/Same_Origin_Policy) which prevents web pages from calling APIs in a different domain. for your frontend to be able to upload images to your storage account, you need to enable [Cross-Origin Resource Sharing](https://docs.microsoft.com/en-us/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services) or CORS.


By enabling CORS, you'll have a secure way to allow your app domain to make calls to your Azure Blob Storage account.

In the next step you are going to setup your Azure Blob Storage account, and enable CORS.
