One of the issues facing any application developer looking to integrate their application to on-premises, external, or cloud service is how to authenticate and gain access to resources, like databases, without compromising security.

Storing authentication credentials, tokens or even secret keys in configuration files accessed by your applications, creates a security nightmare as well as creating the on-going technical debt of having to modify and redistribute your application each time those credentials change.

A better solution is to utilize the authentication tools available in Azure, which embody **service principals** using **managed identities**.

You're a developer at a furniture company that's migrating a stock-tracking application to Azure VMs. The application needs to access secrets in Key Vault to do part of its work. The deployment and management tasks for the application should be as streamlined as possible – and avoid handling credentials in configuration files. You'd like to use an identity for Azure resources to automatically authenticate the application when it's running in Azure.

This module will explore the various service principals available, introduce you to managed identities and, examine some scenario's around their usage.

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