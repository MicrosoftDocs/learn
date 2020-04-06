When you store files and data in Azure, you need to grant access to them securely. Azure Storage accounts provide ways to grant secure access by using a shared access signature (SAS).

You work for a healthcare organization and are developing an application that stores patient diagnostic images in blob storage. These images are highly sensitive, and you need to ensure that your application accesses them securely. You'll update your application to integrate with other providers and give authorization to the images by using an SAS.

In this module, you'll explore the options available to authorize access to your Azure storage. The focus in the module is on an SAS and its different variants. You'll deploy a web app that uses a storage account and enhance it to use an SAS.

After you finish this module, you'll have a running web app that uses an SAS associated with a stored access policy. You'll see how your patients' images are only accessible by using an SAS. Then you'll revoke access by updating the stored access policy.

## Learning objectives

- Identify the features of a shared access signature for Azure Storage.
- Identify the features of stored access policies.
- Programmatically generate and use a shared access signature to access storage.

## Prerequisites

- Knowledge of Azure Storage accounts
- Familiarity with C#
- Familiarity with jQuery and JSON