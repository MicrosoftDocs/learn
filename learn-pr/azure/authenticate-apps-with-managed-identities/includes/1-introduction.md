A common problem when accessing Azure services is how to handle authentication. Access, authentication, and security are always important when working with software of any kind. Consider the options available that avoid storing your credentials, tokens, or secrets in either code or configuration files.

Using Azure Active Directory provides a solution with **Service Principals** and **Managed Identities**. Both of these features have been designed to solve this problem allowing you to use a single identity to integrate your application through Azure AD.

You're a developer at a furniture company that is migrating a stock-tracking application to Azure VMs. The application needs to access secrets in Key Vault to do part of its work. You want the deployment and management tasks for the application to be as streamlined as possible, and want to avoid handling credentials in configuration. You'd like to use an identity for Azure resources to automatically authenticate the application when it's running in Azure.

In this module, you'll look at what service principals are and how they work with Azure AD, managed identities for apps running on an Azure VM, and the scenarios in which you might be able to use them for your application.

## Learning objectives

In this module, you will:

- Identify the benefits and use cases for using service principals
- Identify the benefits of using managed identities for Azure resources
- Enable managed identity on an Azure VM
- Use managed identity with Azure SDKs in applications

## Prerequisites

- Familiarity with Azure Active Directory concepts
- Familiarity with general concepts of authorization and authentication
- Experience developing and deploying IaaS applications