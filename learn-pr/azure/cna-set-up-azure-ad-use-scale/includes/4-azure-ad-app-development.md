Now that you have a better understanding of the basic principles and benefits of Azure AD, you need to determine how you can use its capabilities to implement authentication and authorization for your application. You realize that, to help secure your customers' data, you need to ensure that your implementation will integrate with PostgreSQL access control mechanisms. You decided to start by identifying the tasks that are involved in developing, provisioning, and managing Azure AD applications. You also want to determine how you can address the need to provide access to your application to multiple customers.

## What are the primary application-related Azure AD tasks?

To implement Azure AD-based applications, you'll need to perform several application-related management tasks, including registering, configuring its permissions, and managing its secrets.

### What is application registration?

When operating in an Azure AD environment, a user authenticates to an application in two stages:

1. First, Azure AD verifies the user's identity. Upon successful authentication, Azure AD issues tokens that contain information reflecting the successful authentication.
1. The user passes tokens to the application. The application validates the user’s security tokens to ensure that authentication was successful.

To perform such validation, the application must be able to communicate securely with Azure AD. This, in turn, requires that the application itself operates as an Azure AD security principal. To make it possible, you must ensure that the application is represented in some form in the same Azure AD tenant that contains the account of the authenticating user.

There are two representations of an application in Azure AD:

- An application object, which defines the properties of the application.
- A service principal, which provides authentication and authorization functionality and references the application object.

You can create application objects directly in the Azure portal from the **App Registrations** blade. For your own custom applications, such registration automatically creates the corresponding service principal. Afterwards, you can manage service principals in the Azure portal from the **Enterprise Applications** blade.

During application registration, you have the option of specifying the application's redirect uniform resource identifier (URI). Its value designates the location to which the authorization server redirects the user after the app has been successfully authorized. The authorization server sends the code or token to the redirect URI, so it's important that you register the correct location as part of the app registration process.

> [!NOTE]
> The redirect URI must begin with **https**, unless it's referencing localhost, in which case, you can use `http://localhost`. It's also case-sensitive.

### What are application permissions?

Applications that integrate with Azure AD follow an authorization model that allows you to control in a granular manner its permissions to other Azure AD-integrated applications and resources. Azure AD relies on the OAuth 2.0 authorization model to implement these permissions. In OAuth 2.0, permissions are organized into sets, commonly referred to as *scopes*.

As a developer, you request the permissions your application needs by specifying a permission string as part of its configuration. For example, by setting the permission string to "https://graph.microsoft.com/Calendars.Read", you indicate that the application will need to be able to read users' calendars in Microsoft Graph. The application must be granted these permissions through a consent, which must be granted by either an Azure AD user or an Azure AD administrator, depending on the extent of these permissions.

Azure AD supports two types of permissions:

- Delegated permissions are used by interactive apps with a signed-in user. As a result, the app acts on behalf of a signed-in user when it accesses the target resource.
- Application permissions are used by apps that run without relying on a signed-in user, such as background services. These apps require administrative consent.

### What are application secrets?

There are two types of authentication available for service principals:

- Password-based authentication, which relies on application secrets that you can generate directly in the Azure portal. When generating a secret, you specify its lifetime.
- Certificate-based authentication, which relies on certificates that you upload to Azure AD.

> [!NOTE]
> If your application will be hosted by an Azure compute resource, such as an Azure Virtual Machine (VM), Azure App Service web app, or an AKS cluster, rather than using service principals, consider using managed identities for your application identity. This eliminates the need to manage passwords or certificates for authentication.

## What are different types of application authentication scenarios?

The authentication flow and the corresponding configuration details depend on the application type. The common categories of application types include:

- Browser-based apps. These are web apps in which tokens are acquired by a JavaScript or TypeScript app running in the browser. These applications often use a framework such as Angular, React, or Vue. MSAL.js is the only Microsoft Authentication Library that supports SPAs.
- Public client applications. These are apps that always rely on signed-in users to obtain tokens. Such apps include desktop and mobile apps that call web APIs on behalf of signed-in users.
- Confidential client applications. These obtain tokens on their own. Apps in this category include web apps that call a web API, web APIs that call another web API, Linux daemons, and Windows services.

The first two items above authenticate a user, whereas the third only authenticates an app or service between the user and a back-end service. In this case, the back-end service won't know anything about the end user, but it will know which app is using it. For example, think of an app using Azure maps as a back-end service. The maps service needs to know that an authorized application is calling it for correct billing, but it doesn't need to know anything about the end user.

## What is the difference between single-tenant and multitenant Azure AD applications?

As a developer, you can choose to configure your app to be either single-tenant or multitenant during app registration:

- Single-tenant apps are only available in the tenant they were registered in, and are referred to as their home tenant.
- Multitenant apps are available to users in both their home tenant and other Azure AD tenants.

If you use the Azure portal for app registration, you specify the tenancy of the app by setting its audience property to one of the following values:

- Accounts in this directory only. This results in the single-tenant configuration. Effectively, this allows you to grant access to the application to any security principal in your tenant, including guest accounts.
- Accounts in any Azure AD directory. This results in a multitenant configuration. This allows users outside of your organization to register the application in their respective Azure AD tenants.
- Accounts in any Azure AD directory and personal Microsoft accounts (such as Skype, Xbox, Outlook.com). This also results in a multitenant configuration, but it makes it possible for users with personal Microsoft accounts to use the app.

> [!NOTE]
> An application object exists only in the home tenant, but in the case of the multitenant configuration, it can be referenced by multiple service principals across different Azure AD tenants.
