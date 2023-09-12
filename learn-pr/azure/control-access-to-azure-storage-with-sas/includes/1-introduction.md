The Azure Storage platform is Microsoft's cloud storage solution for modern data storage solution. Azure Blob Storage is Microsoft's object storage solution for the cloud, and is optimized for storing massive amounts of unstructured data. Every request to access files stored in Azure requires authorization. A shared access signature (SAS) provides secure, delegated access to resources in your storage account. 

You work for a healthcare organization that stores patient diagnostic images in blob storage. These images are highly sensitive, and you're developing an application for securely storing and securely accessing content. You're updating your application to integrate with other providers, and you want to authorize access to the images by using a SAS.

In this module, you explore the options available to authorize access to your Azure storage, focusing on SAS and its different variants. You deploy a web app that uses a storage account, and you enhance the web app to use a SAS.

After you finish this module, you'll have a web app that uses multiple SASs that are associated with a stored access policy. The web app shows how patient images are only accessible by using a SAS, and how you can revoke access by updating the stored access policy.

## Learning objectives

- Identify the features of a shared access signature (SAS) for Azure Storage.
- Identify the features of stored access policies.
- Programmatically generate and use a SAS to access storage.

## Prerequisites

- Knowledge of Azure Storage accounts
- Familiarity with C#
- Familiarity with jQuery and JSON
