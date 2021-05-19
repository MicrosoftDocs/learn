<!-- Guidance on writing the opening to a content/conceptual unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

<!-- 

See here for general guidance on content units: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-structure-learning-content?branch=master

-->

You learn that your organization uses Azure Active Directory as the Identity provider for authentication and authorization. 

In this unit, you'll learn about authentication, authorization and how it is supported in Azure Active Directory.

Azure Active Directory provides authentication and authorization service by supporting modern authentication protocols such as OAuth 2.0 and OpenID Connect in a standards-compliant way. This allows you to use open-source libraries such as Microsoft Authentication Library (MSAL) and other standard-compliant libraries with Azure Active Directory. Here is a brief summary of the distinction between authentication and authorization.

## Authentication

**Authentication** refers to the process of establishing and verifying the identity of the end-user who is accessing an application.

Azure Active Directory uses the OpenID Connect protocol to handle authentication. OpenID Connect allows applications to obtain basic information about the authenticated user and session.

## Authorization

**Authorization** is the process of ensuring that an authenticated user has the permission to perform some operation or access some data.

The OAuth 2.0 protocol is used to provide authorization flows for different application in Azure Active Directory.

## Application registration

Azure Active Directory requires your application to be registered with it before it can provide identity and access management services. Registering your application establishes a trust relationship between the application and the Identity provider. You can create an application registration through the Azure Portal, using Azure CLI and even programmatically using Microsoft Graph APIs.

The application registration allows you to specify the name of your application, the type of the application (web, desktop, etc.) and the sign-in audience - the user accounts you want to allow access to. The sign-in audience include:

- **Accounts in this organizational directory only** if you're building an application for use only by users in the organizational tenant (**single-tenant**).
- **Accounts in any organizational directory** if you'd like users in any Azure Active Directory tenant to be able to use your application (**multi-tenant**).
- **Accounts in any organizational directory and personal Microsoft accounts** for the widest set of customers (**multi-tenant** that also supports Microsoft personal accounts).
- **Personal Microsoft accounts** for use only by users of personal Microsoft accounts (e.g., Hotmail, Live, Skype, Xbox accounts).

You can also configure credentials, redirect URIs and other authentication settings on the application registration.

When an application registration is complete, you receive an **Application (client) ID** which uniquely identifies your application in Azure Active Directory. This ID is used in your application code or in the authentication library as part of the authentication and authorization requests made to Azure Active Directory.
