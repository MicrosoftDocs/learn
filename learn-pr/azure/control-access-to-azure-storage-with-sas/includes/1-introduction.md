When you store files and data in Azure, you need to grant access to them securely. Azure Storage accounts provide ways to do this using shared access signature (SAS).

You work for a healthcare organization and are developing an application that stores patient diagnostic images on blob storage. These images are highly sensitive, and you need to ensure your application is accessing them securely. You'll update your application to integrate with other providers and give authorization to the images using SAS.

In this module, you'll explore the options available to authorize access to your Azure Storage. The focus in the module is on SAS and its different variants. You'll deploy a web app that uses a storage account and enhance it to use SAS.  

After completing this module, you'll have a running web app that uses SAS associated with a stored access policy. You'll see how your patients' images are only accessible using a SAS. Then you'll revoke access by updating the stored access policy.

## Learning objectives

- Identify the features of shared access signature (SAS) for Azure Storage
- Identify the features of stored access policies
- Programmatically generate and use SAS to access storage

## Prerequisites

- Knowledge of Azure Storage accounts
- Familiarity with C#
- Familiarity with JQuery and JSON