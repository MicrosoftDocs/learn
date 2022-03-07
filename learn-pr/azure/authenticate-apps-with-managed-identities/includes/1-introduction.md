One of the issues that faces application developers who want to integrate their application with on-premises, external, or cloud services is authentication. What's the most practical way to access resources like databases without compromising security?

Storing credentials, tokens, or secret keys in configuration files that your applications access isn't a secure solution. It also creates an ongoing technical debt, requiring you to modify and redistribute your application each time credentials change.

Azure provides a better solution using authentication tools. These tools include *service principals* and *managed identities*.

Imagine that you're a developer at a furniture company. Your company is migrating a stock-tracking application to Azure virtual machines (VMs). The application needs access to secrets in Azure Key Vault. The application's deployment and management tasks should be as streamlined as possible. The processes should avoid handling credentials in configuration files. You want to use a managed identity for Azure resources to authenticate the application that's running in Azure.

This module explores the available service principals, introduces you to managed identities, and examines some usage scenarios.

## Learning objectives

In this module, you'll:

- Identify the benefits of and use cases for service principals.
- Identify the benefits of using managed identities for Azure resources.
- Enable managed identities on an Azure VM.
- Use managed identities with Azure SDKs in applications.

## Prerequisites

- Familiarity with Azure Active Directory (Azure AD) concepts
- Familiarity with general concepts of authorization and authentication
- Experience with developing and deploying infrastructure as a service (IaaS) applications