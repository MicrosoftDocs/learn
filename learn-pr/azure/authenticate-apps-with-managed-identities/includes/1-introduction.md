When working with software of any kind access, authentication and security should always be at the forefront of your thoughts. A common problem is how best to handle authentication requests, and which method meets your requirements. You should consider which options are available to avoid storing credentials, tokens, or secrets in either code or configuration files. This problem is magnified when working with an application hosted in a cloud platform, such as Microsoft Azure. 

Authenticating with Azure Active Directory provides a solution with **Service Principals** and **Managed Identities**. Both of these features have been designed to solve this problem allowing you to use a single identity to integrate your application through Azure AD.

In this module, you'll look at what service principals are and how they work with Azure AD, Azure-Managed identities, and the scenarios in which to use them for your applications.

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