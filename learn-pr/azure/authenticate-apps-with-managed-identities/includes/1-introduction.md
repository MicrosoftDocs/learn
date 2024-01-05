Developers integrating applications with on-premises, external, or cloud services face the issue of authentication. In the past, accessing resources like databases frequently involved options that could compromise security. For example, storing credentials, tokens, or secret keys in configuration files accessible to your applications isn’t recommended from a security standpoint. This approach requires ongoing updates to modify and redistribute applications each time credentials change.

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

- Familiarity with Microsoft Entra concepts
- Familiarity with general concepts of authorization and authentication
- Experience with developing and deploying infrastructure as a service (IaaS) applications
