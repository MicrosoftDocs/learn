One of the issues facing application developers looking to integrate their application with on-premises, external, or cloud service is authentication. What's the most practical way to access resources like databases, without compromising security?

Storing credentials, tokens, or secret keys in configuration files accessed by your applications, isn't secure. It also creates an on-going technical debt where you have to modify and redistribute your application each time credentials change.

A better solution is to use the authentication tools provided by Azure, **service principals** and **managed identities**.

You're a developer at a furniture company that's migrating a stock-tracking application to Azure VMs. The application needs to access secrets in Azure Key Vault to work. The deployment and management tasks for the application should be as streamlined as possible, and avoid handling credentials in configuration files. You'd like to use a managed identity for Azure resources to authenticate the application that's running in Azure.

This module will explore the various service principals available, introduce you to managed identities, and examine some scenarios around their usage.

## Learning objectives

In this module, you'll:

- Identify the benefits and use cases for using service principals
- Identify the benefits of using managed identities for Azure resources
- Enable managed identity on an Azure VM
- Use managed identity with Azure SDKs in applications

## Prerequisites

- Familiarity with Azure Active Directory concepts
- Familiarity with general concepts of authorization and authentication
- Experience of developing and deploying IaaS applications