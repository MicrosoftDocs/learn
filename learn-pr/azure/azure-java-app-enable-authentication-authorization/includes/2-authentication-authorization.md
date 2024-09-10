Microsoft Entra ID provides authentication and authorization service by supporting modern authentication protocols, such as OAuth 2.0 and OpenID Connect, in a standards-compliant way. You can use open-source libraries such as Microsoft Authentication Library (MSAL) and other standard-compliant libraries with Microsoft Entra ID. 

In the employee-portal scenario, you learn that your organization uses Microsoft Entra ID as the Identity provider for authentication and authorization.

In this unit, you'll learn about authentication, authorization, and how they're supported in Microsoft Entra ID.

## Authentication

**Authentication** refers to the process of establishing and verifying the identity of the end user who is accessing an application.

Microsoft Entra ID uses the OpenID Connect protocol to handle authentication. OpenID Connect allows applications to obtain basic information about the authenticated user and session.

## Authorization

**Authorization** is the process of ensuring that an authenticated user has the permission to perform some operation or access some data.

The OAuth 2.0 protocol is used to provide authorization flows for different application in Microsoft Entra ID.

## Application registration

Microsoft Entra ID requires you to register your application before it can provide identity and access management services. Registering your application establishes a trust relationship between the application and the Identity provider. You can create an application registration through the Azure portal, using the Azure CLI, and even programmatically using Microsoft Graph APIs.

The application registration allows you to specify your application's name, the application type (web, desktop, and so on), and the sign-in audience, which is the user accounts to which you want to allow access. The sign-in audience includes:

- **Accounts in this organizational directory only** if you're building an application for use only by users in the organizational tenant (**single-tenant**).
- **Accounts in any organizational directory** if you'd like users in any Microsoft Entra tenant to use your application (**multi-tenant**).
- **Accounts in any organizational directory and personal Microsoft accounts** for the widest set of customers (**multi-tenant** that also supports Microsoft personal accounts).
- **Personal Microsoft accounts** for use only by users of personal Microsoft accounts (for example, Hotmail, Live, Skype, and Xbox accounts).

You can also configure credentials, redirect URIs and other authentication settings on the application registration.

When an application registration is complete, you receive an **Application (client) ID** that uniquely identifies your application in Microsoft Entra ID. This ID is used in your application code or in the authentication library as part of the requests made to Microsoft Entra ID.
