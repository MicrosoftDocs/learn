The Azure Storage platform is Microsoft's cloud storage solution for modern data storage solution. Azure Blob Storage is Microsoft's object storage solution for the cloud because it is optimized for storing massive amounts of unstructured data. Every request to access files stored in Azure requires authorization. A shared access signature (SAS) provides secure delegated access to resources in your storage account. 

You work for a healthcare organization that stores patient diagnostic images in blob storage. These images are highly sensitive, and you are developing an application for storing and accessing content. You need to ensure that access is secure. You're updating your application to integrate with other providers and to authorizae to the images by using a SAS.

In this module, you'll explore the options available to authorize access to your Azure storage. The focus in the module is on a SAS and its different variants. You'll deploy a web app that uses a storage account and enhance the web app to use a SAS.

After you finish this module, you'll have a running web app that uses a SAS associated with a stored access policy. You'll see how patient images are only accessible by using a SAS. Then you'll revoke access by updating the stored access policy.

## Learning objectives

- Identify the features of a shared access signature (SAS) for Azure Storage.
- Identify the features of stored access policies.
- Programmatically generate and use a SAS to access storage.

## Prerequisites

- Knowledge of Azure Storage accounts
- Familiarity with C#
- Familiarity with jQuery and JSON
