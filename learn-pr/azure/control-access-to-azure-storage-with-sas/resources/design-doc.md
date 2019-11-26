# Title

Control access to Azure Storage accounts with Shared Access Signatures

## Role(s)

- Administrator
- Developer
- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Storage

## Prerequisites

- Knowledge of Azure Storage accounts
- Familiarity with C#
- Familiarity with JQuery and JSON

## Summary

Grant access to data stored in your Azure Storage accounts securely through the use of shared access signatures.

## Learning objectives

1. Identify the features of Shared Access Signatures (SAS) for Azure Storage
2. Identify the features of Stored Access Policies
3. Programmatically generate and use SAS to access storage

## Subtasks

Identify the subtasks of *Control access to Azure Storage with shared access signatures*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| 1. Describe how to authorize access to blob storage | ensure that your application is accessing them securely | KC | 1 | Yes |
| 2. Explain what shared access policies are | application will integrate with other providers and will need to be able to provide authorization to the images | Exercise | 2 | Yes |
| 3. Explain what the different SAS forms are | application will integrate with other providers and will need to be able to provide authorization to the images | Exercise | 1 | Yes |
| 4. Create a web app that provides access to images in blob storage with SAS tokens | you need to ensure that your application is accessing them securely | Exercise | 3 | No, 3 |

## Outline the units

1. **Introduction**

    You work for a healthcare organization and are developing an application that stores patient diagnostic images on blob storage. These images are very sensitive, and you need to ensure that your application is accessing them securely. Your application will integrate with other providers and will need to be able to provide authorization to the images to those provider's applications.

1. **Authorization options for Azure Storage**

    Four types of ways to access files stored in Blob storage

    - Anonymous (public) access
        - Containers can have three access levels, none, blob, and container and blob
        - No control over who has access to files
    - Azure Active Directory access
        - Controlled with built-in RBAC roles, e.g. Storage Blob Data Owner to Storage Blob Data Reader
        - Requires Azure AD account to grant access
    - Shared Key
        - The equivalent of using root access, only one shared key exists for a whole storage account
        - No fine grain control over what can be accessed
    - Shared Access Signature (SAS)
        - Different levels of access, account, service, or user (controlled with Azure AD)
        - Control down to the level of individual blob items
        - Control of the lifetime, and SAS can be revoked

    **Knowledge check**

    1. Your organization has an internal system to share patient appointment information and notes. You can secure the access based on a users membership of an AD group. Which kind of authorization supports this scenario best, and why?
    1. Your public facing static website stores all its UI images in blob storage. The web site needs to display the graphics without any kind of authorization. Which is the best option?

1. **Use shared access signatures (SAS) to delegate access to Azure storage**

    - Two forms of SAS:
        - Ad hoc, all three kinds user, account, and service can be accessed with ad-hoc
        - Service SAS with a stored access policy
    - Explain the components of a SAS; both the signature and token
    - Create an ad-hoc SAS in .NET
    - Create a Service SAS with a stored access policy in .NET
    - Best practices when using SAS

1. **Exercise - Use shared access signatures (SAS) to delegate access to Azure storage**

    1. Add code to build an ad-hoc SAS URI for the external access page.
    1. Add client-side code to call the secure access page.
    1. Test the image can be displayed.
    1. Test the access is lost after 1 minute.

1. **Use stored access policies to delegate access to Azure storage**

    - What are stored access policies, use them to group levels of access together
    - Creating stored access policies with the portal, Azure CLI, or .NET code
    - Can only be used with service SAS

1. **Exercise - Use stored access policies to delegate access to Azure storage**

    1. Create azure storage account.
    1. Create a blob container.
    1. Upload example medical images.
    1. Create a stored access policy to be used by the app.
    1. Clone the app - the app won't have external access - just uses Shared Key to view blob data.

1. **Summary**

    - Restate the scenario problem
    - Show how SAS and shared access policies solved the problem
    - Describe the experience without these features
    - Describe the business impact of using these features

## Notes

This is a combined architect/dev module. The exercise should be hands-on with code, developing a portion of an app that uses the valet key pattern to provide temporary blob storage SAS keys to clients.

Exercise is being built with .NET v12 SDK, .NET Core 3.0, Razor web pages, with JQuery to call API.

## References

- [Grant limited access to Azure Storage resources using shared access signatures (SAS)](https://docs.microsoft.com/en-gb/azure/storage/common/storage-sas-overview)
- [Concept](https://docs.microsoft.com/en-gb/azure/storage/common/storage-sas-overview)
- [Valet Key Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/valet-key)
- [SAS example](https://github.com/Azure-Samples/storage-dotnet-sas-getting-started/tree/master/)
- https://docs.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-3.0&tabs=windows#enable-secret-storage

- https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Blobs/samples

- https://www.mikesdotnetting.com/article/261/integrating-web-api-with-asp-net-razor-web-pages

- https://docs.microsoft.com/en-us/aspnet/core/tutorials/web-api-javascript?view=aspnetcore-3.0