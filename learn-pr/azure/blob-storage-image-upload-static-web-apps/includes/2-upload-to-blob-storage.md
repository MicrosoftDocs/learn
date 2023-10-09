You decided to store your users' images on Azure Blob Storage, allowing them to upload images directly from their browsers so you could avoid having your own middleware service, thus saving developer resources by letting Azure handle the complexity of running a service. The problem is if you have a storage backend that's accessed publicly via the browser, you want to restrict who's able to upload images there. This requirement means you need a way to authenticate your users as they upload images. Since your frontend is a static web app, you're presented with the problem of how to authenticate users to Azure Blob Storage.

Let's visualize the situation with the following picture. Your frontend can't access Blob Storage. Your storage account key resides in Azure, and for security reasons you can't share that with the world. So what do you do?

:::image type="content" source="../media/architecture-1.png" alt-text="Diagram showing a Static Web App and Blob Storage.":::

## Describe shared access signature tokens

To solve this problem, you need to generate a shared access signature (SAS) which provides limited access to an authorized user to write to an Azure Blob Storage. The benefit of using a shared access signature is that you can allow your users to upload pictures or any file directly to Azure Blob Storage without needing to share your storage account key with them. Furthermore, a shared access signature allows you to limit access to protect your Azure resource. For example, you can limit the duration of access to prevent fraudulent use.

Next, how do you generate a shared access signature? There are several ways to create them, but in this module, we'll use Azure Functions. The benefit of using Azure Functions for this purpose is that your storage account key stays safe on Azure, while your users contact this serverless API that will generate SAS tokens for them on demand. These tokens will be short lived, meaning that after a couple of minutes, they will be invalid to prevent misuse.

:::image type="content" source="../media/architecture-2.png" alt-text="Diagram showing a Static Web App and Blob Storage via Azure Functions.":::

With SAS tokens, you can specify the kind of access you grant to your users. Can they control your account almost completely, or are they just allowed to upload a file? In this use case, you just want them to be able to upload images without having access to anything else. To accomplish that, we need to learn how files are organized in blob storage.

## Describe containers

When using your blob storage account, you want to organize your blobs inside containers to keep things organized. You can have a container for image uploads from your website users while having a separate container to store videos and a third one to keep documents. By separating your files this way, you can decide on granting specific access to each container depending on the data-access needs of each of your users. For this exercise, you'll have a container called `images` where your image uploads will reside. Your users will have access to add files to that container.

## Describe cross-origin resource sharing

Since your application lives in your company's domain, a user won't be able to access your Azure Blob Storage account under `<StorageAccountName>.blob.core.windows.net`. There's a browser-security feature called a same-origin policy that prevents web pages from calling APIs in a different domain. For your frontend to be able to upload images to your storage account, you need to enable Cross-Origin Resource Sharing (CORS).

By enabling CORS, you'll have a secure way to allow your web application that lives under your own domain to upload files to your Azure Blob Storage account that lives under the Azure domain.

In the next step, you'll set up your Azure Blob Storage account and enable CORS.
