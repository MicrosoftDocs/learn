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

- Basic knowledge of Azure Storage accounts
- Familiarity with C#

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
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |

## Outline the units

1. **Introduction**

    You work for a healthcare organization and are developing an application that stores patient diagnostic images on blob storage. These images are very sensitive, and you need to ensure that your application is accessing them securely. Your application will integrate with other providers and will need to be able to provide authorization to the images to those provider's applications.

1. **Learning-content unit title**

    List the content that will enable the learner to *subtask*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

    **Knowledge check**

    What types of questions will test *learning objective*? *[(Knowledge check guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-knowledge-check)*

    - Question type
    - Question type

1. **Exercise - exercise unit title**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 

    *Add your summary [(Summary guidance)](https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-module-summary-unit)*

## Notes

This is a combined architect/dev module. The exercise should be hands-on with code, developing a portion of an app that uses the valet key pattern to provide temporary blob storage SAS keys to clients.

## References

- [Grant limited access to Azure Storage resources using shared access signatures (SAS)](https://docs.microsoft.com/en-gb/azure/storage/common/storage-sas-overview)
- [Concept](https://docs.microsoft.com/en-gb/azure/storage/common/storage-sas-overview)
- [Valet Key Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/valet-key)
- [SAS example](https://github.com/Azure-Samples/storage-dotnet-sas-getting-started/tree/master/)
- https://docs.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-3.0&tabs=windows#enable-secret-storage

- https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Blobs/samples

- https://www.mikesdotnetting.com/article/261/integrating-web-api-with-asp-net-razor-web-pages

- https://docs.microsoft.com/en-us/aspnet/core/tutorials/web-api-javascript?view=aspnetcore-3.0