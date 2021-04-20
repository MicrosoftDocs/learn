# Describe uploading to Blob Storage

If you have an app that's accessed publicly via the browser, you want to restrict who's able to upload images to your storage backend, but by going the way of Azure Static Web Apps, you are presented with the problem of how to authenticate users towards Azure Blob Storage.

As you can see in the following image, your frontend cannot access Blob Storage. Your storage account key resides in Azure, and for security reasons you cannot share that with the world. So what do you do?

:::image type="content" source="../media/architecture_1.png" alt-text="Static Web App and Blob Storage":::

Luckily, there's a solution for that. Add an Azure Functions backend that takes care of generating Shared Access Signatures (SAS) so your users can upload pictures directly to Azure Blob Storage without you needing to share your storage account key with them. The security team at your company is happy, and your users are happy as well!

:::image type="content" source="../media/architecture_2.png" alt-text="Static Web App and Blob Storage via Azure Functions":::

## Describe Containers

describe the name of the container and explain that images are going to be stored there.

## Describe Cross-Origin Resource Sharing

Since you application lives in your company's domain name, while your Azure Blob Storage has a different location under yourcompany.azure.domain[FIX], for your frontend to be able to upload images to your storage account, you need to enable [Cross-Origin Resource Sharing](https://docs.microsoft.com/en-us/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services) or CORS.

CORS is required because web browsers have a security restriction called [same-origin policy](https://www.w3.org/Security/wiki/Same_Origin_Policy) which prevents web pages from calling APIs in a different domain. By enabling CORS, you'll have a secure way to allow your app domain to make calls to your Azure Blob Storage account.

Next you are going to setup your Blob Storage account, and enable CORS.
