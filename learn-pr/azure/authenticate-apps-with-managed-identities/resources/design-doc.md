# Module Design

## Title

Authenticate apps to Azure services with service principals and managed identities for Azure resources

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

Securely authenticate applications to Azure to manage and access Azure services. Service principles and managed identities for Azure resources provides your app with an Azure Active Directory identity for use within your application.

## Learning objectives

- Identify the benefits and use cases for using service principals
- Identify the benefits of using managed identities for Azure resources
- Enable managed identity on an Azure VM
- Use managed identity with Azure SDKs in applications

## Chunk your content into subtasks

Identify the subtasks of *Authenticate apps to Azure services with service principals and managed identities for Azure resources*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Introduction to service principals in Azure AD | avoid handling credentials in configuration | Knowledge Check | 1 | No, below |
| Explain benefits and use cases for using service principals | avoid handling credentials in configuration | Knowledge Check | 1 | No, above |
| Understand managed identities in Azure | deployment and management tasks for the application to be as streamlined as possible | Knowledge Check | 2 | Yes |
| Using managed identities with Azure Virtual Machines | migrating a stock-tracking application to Azure VMs | Exercise | 3 | Yes |
| Build applications using Azure AD managed identities | application needs to access secrets in Key Vault | Exercise | 4 | Yes |

## Outline the units

1. **Introduction**

    You work for a furniture company that is migrating a stock-tracking application to Azure VMs. The application needs to access secrets in Key Vault to do part of its work. You want the deployment and management tasks for the application to be as streamlined as possible, and want to avoid handling credentials in configuration. You'd like to use an identity for Azure resources to automatically authenticate the application when it's running in Azure.

1. **Introduction to service principals in Azure AD**

    List the content that will enable the learner to *Identify the benefits and use cases for using service principals*:

    - Overview of Azure Service Principals
        - What are Azure service principals
        - Working with service principals in Azure
        - Azure Active Directory applications
        - Assigning Application Roles
        - Managing keys & permissions

   **Knowledge Check**

    What types of questions will test *Introduction to service principals in Azure AD*?

    - What is a key thing to remember when creating a service principal?
    - Which role needs to be removed in order for a service principals permissions to be restricted?
    - Which three items are needed for a custom app to authenticate with an Azure AD application?
    - What service is called when your application is passing a token to Azure?

1. **Understand managed identities in Azure**

    List the content that will enable the learner to *Identify the benefits of using managed identities for Azure resources*:

    - What are managed identities in Azure
        - Overview of Azure managed identities
        - How managed identities work
        - Using managed identities with Azure resources

   **Knowledge check**

    What types of questions will test *Understand managed identities in Azure*?

    - What is the Azure Instance Metadata Service?
    - Why can't a custom application hosted on-premises use managed identities?
    - What happens in IMDS if you do not specify an identity in the request?

1. **Using managed identities with Azure Virtual Machines**

    List the content that will enable the learner to *Identify the benefits of using managed identities for Azure resources*:

    - Managed identity with Azure Windows Virtual Machines
        - Introduction to Azure Resource Manager
        - Overview of identity in an Azure Windows VM
        - Access control and authentication

1. **Exercise - Configure a system-assigned managed identity for an Azure VM using powershell**

    List the steps that apply the learning content from previous unit:

    1. git clone source code with sample data.
    1. Create a virtual machine.
    1. Configure managed identity on the virtual machine.
    1. Run through assigning the VM access.
    1. Run the created identity through Azure Resource Manager.

1. **Build applications using Azure AD managed identities**

    List the content that will enable the learner to *Identify the benefits of using managed identities for Azure resources*:

    - Application Managed Identities
        - Overview of managed identity for Azure services
        - Identity-to-service management
        - Azure resource managed identity tokens
        - Setting up and accessing the Azure Key Vault from a C# app
        - Examples of other libraries, Java, Node.JS, and Python
        - Authenticating apps using a user-assigned identity

1. **Exercise - Configure a custom application in .NET using Azure AD managed identities**

    List the steps that apply the learning content from previous unit:

    1. git clone source code with sample application.
    1. Create app service and function applications.
    1. Create Key Vault instance.
    1. Configure managed identity for provisioned resources.
    1. Run through configuring the sample application to use system-assigned identity.
    1. Run through code changes to change application authentication process.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Introduction to service principals in Azure.
    - Overview of managed identity in Azure
    - Using managed identity with an Azure VM
    - Walk through of managed identity in a custom application.

## Notes

- Provide topical coverage of service principles, and under what circumstances they are recommended.
- As per the title, the focus is on IaaS apps (VMs), but the content should mention how it's available elsewhere, particularly App Service/Functions and ACI.
- The exercise should focus on how to use managed identity authentication with the .NET Key Vault client library, but the content should discuss what's happening in the background, and should indicate that the same basic strategy works for other client libraries and in other languages (although it may not be as easy in other languages, as the .NET library handles a lot)
- Mention the existence of user-assigned identity but don't cover it in the exercise, stick with system-assigned
- Managed identities are preferable, where they are available, to manually managing service principals and credentials. Mention some scenarios where they are not available or where manually configuring a service principal may make more sense.
- The name Managed Service Identity (MSI) is deprecated, but call it out because it's still commonly used, including in client libraries
- This will have to cover some conceptual territory regarding application registrations and service principals. However: this is a developer-role module, and it should focus on giving enough information for the reader to work confidently in a developer capacity, as opposed to an administrative or solution architect capacity. The exercise should go through registering the application, but shouldn't dwell on it for too long.
- Cover both cert and password auth, but use password auth for the exercise for simplicity
- Use the .NET Azure Management client libraries and the included classes for authentication, but mention what is going on behind the scenes (token acquisition, etc.)
- This module was originally intended to follow a separate module about service principal authentication that does not use managed identities. That module has been canceled and the content coverage merged in with the scope of this module. For reference, here's the design doc for that module.
  - <https://github.com/MicrosoftDocs/learn-pr/blob/NEW-authenticate-apps-with-service-principals/learn-pr/azure/authenticate-apps-with-service-principals/resources/design-doc.md>
- <https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/>

<!-- REVIEW make it clear which notes are applicable - e.g. are the exercises in the sandbox or not -->

## Useful Resources

- <https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy-add-on-premises-application>
- <https://docs.microsoft.com/azure/active-directory/manage-apps/plan-an-application-integration>
- <https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy>
- <https://docs.microsoft.com/azure/azure-resource-manager/resource-manager-api-authentication>
- <https://docs.microsoft.com/powershell/azure/create-azure-service-principal-azureps?view=azps-1.6.0>
- <https://azure.microsoft.com/resources/samples/aad-dotnet-manage-service-principals/>
- <https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli>
- <https://docs.microsoft.com/azure/active-directory/develop/app-objects-and-service-principals#overview>
- <https://docs.microsoft.com/azure/data-lake-store/data-lake-store-service-to-service-authenticate-net-sdk>
- <https://docs.microsoft.com/azure/key-vault/service-to-service-authentication#running-the-application-using-managed-identity-or-user-assigned-identity>
