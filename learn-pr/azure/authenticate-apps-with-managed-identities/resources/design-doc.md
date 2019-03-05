# Module Design (template)

## Title

Automatically authenticate IaaS apps to Azure services with managed identities for Azure resources

## Role(s)

- Developer
- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Active Directory

## Prerequisites

- Familiarity with Azure Active Directory concepts
- Familiarity with general concepts of authorization and authentication
- Experience developing and deploying IaaS applications

## Summary

Managed identities for Azure resources provides your app with an automatically managed Azure Active Directory identity. Enable managed identity on an Azure Virtual Machine and use it from an application.

## Learning objectives

- Identify the benefits of using managed identities for Azure resources in IaaS applications
- Enable managed identity on an Azure VM
- Use managed identity with Azure SDKs in applications

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
||||||

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You work for a furniture company that is migrating a stock-tracking application to Azure VMs. The application needs to access secrets in Key Vault to do part of its work. You want the deployment and management tasks for the application to be as streamlined as possible, and want to avoid handling credentials in configuration. You'd like to use managed identities for Azure resources to automatically authenticate the application when it's running in Azure.

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

1. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type
    
1. **Exercise - exercise unit title**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- As per the title, the focus is on IaaS apps (VMs), but the content should mention how it’s available elsewhere, particularly App Service/Functions and ACI.
- The exercise should focus on how to use managed identity authentication with the .NET Key Vault client library, but the content should discuss what’s happening in the background, and should indicate that the same basic strategy works for other client libraries and in other languages (although it may not be as easy in other languages, as the .NET library handles a lot)
- Mention the existence of user-assigned identity but don’t cover it in the exercise, stick with system-assigned
- Managed identities are generally preferable, where they are available, to manually managing service principals and credentials. Mention some scenarios where they are not available or where manually configuring a service principal may make more sense.
- The name Managed Service Identity (MSI) is deprecated, but call it out because it's still commonly used, including in client libraries
- This module is intended to follow a separate module about service principal authentication that does not use managed identities. That module will be responsible for introducing general application authentication concepts to readers.
- https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/
- Unlike standard service principals, managed identities should work in the sandbox. This is expected to be a sandbox-enabled module.
