When you access Azure services, you need the best solution to handle authentication. Access, authentication, and security need to be focused on for all kinds of software, but especially when that software is accessed and stored online. Consider the problems associated with storing your credentials, tokens, or secrets in code or configuration files.

Using Azure Active Directory provides a solution with **Service Principals** and **Managed Identities**. Both features are designed to solve this problem, allowing you to use a single identity to integrate your application through Azure AD.

You're a developer at a furniture company that's migrating a stock-tracking application to Azure VMs. The application needs to access secrets in Key Vault to do part of its work. The deployment and management tasks for the application should be as streamlined as possible – and avoid handling credentials in configuration files. You'd like to use an identity for Azure resources to automatically authenticate the application when it's running in Azure.

In this module, you'll look at what service principals are – and how they work with Azure AD – managed identities for apps running on an Azure VM, and the scenarios in which you might use them for your application.

## Learning objectives

In this module, you'll:

- Identify the benefits and use cases for using service principals.
- Identify the benefits of using managed identities for Azure resources.
- Enable managed identity on an Azure VM.
- Use managed identity with Azure SDKs in applications.

## Prerequisites

- Familiarity with Azure Active Directory concepts.
- Familiarity with general concepts of authorization and authentication.
- Experience of developing and deploying IaaS applications.