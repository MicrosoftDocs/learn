Application registration in Microsoft Entra ID is the process of ensuring that the identity system is aware of what applications are used. This way you can confirm the user has access to the app and that the app has access to any needed resources. You ensure the security and privacy of users, apps, and your data.

## Scenario

Imagine you're an application developer who wants to create an application that requires authentication and authorization. You want to ensure that only authorized users can access the app and that the app can access the necessary resources.

By registering your application with Microsoft Entra ID, you can provide an identity configuration for your application that allows it to integrate with the Microsoft identity platform. This registration process enables several key capabilities:

- **Custom branding**: Customize the branding of your application in the sign-in dialog box. This branding is important because signing in is the first experience a user has with your app.
- **Tenant configuration**: Choose between single-tenant application (your organization), or multitenant application (accept accounts from other tenants). You can also allow personal Microsoft accounts or social accounts from LinkedIn, Google, and so on.
- **Permission management**: Request scope permissions, such as the user.read scope, which grants permission to read the profile of the signed-in user. Define scopes that control access to your web API.
- **Secure authentication**: Configure secure authentication methods. For confidential client applications that can hold credentials securely (like web applications with trusted back-end servers), you can use client secrets, certificates, or modern alternatives like managed identities for enhanced security.

## Learning objectives

- Benefits of registering an app.
- Single-tenant versus multitenant apps.
- What happens when an app is registered.
- Relationship between application objects and service principals.

## Goals

The goal of this module is to teach you how to register your application with Microsoft Entra ID, then how to configure it to integrate with the Microsoft identity platform. Learn how to customize the branding of your application in the sign-in dialog box. Then explore how to request scope permissions, and how to share a secret with the Microsoft identity platform that proves the app's identity. Finally, learn about single-tenant versus multitenant apps, application objects, and service principal objects, and the relationship between them.
