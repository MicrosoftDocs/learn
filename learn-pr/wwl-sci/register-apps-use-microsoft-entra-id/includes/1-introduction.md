Application registration in Microsoft Entra ID is the process of ensuring that the identity system is aware of what applications are used. This way you can confirm the user has access to the app and that the app has access to any needed resources. You ensure the security and privacy of users, apps, and your data.

## Scenario

Imagine you're an application developer who wants to create an application that requires authentication and authorization. You want to ensure that only authorized users can access the app and that the app can access the necessary resources. By registering your application with Microsoft Entra ID, you can provide an identity configuration for your application that allows it to integrate with the Microsoft identity platform. Registering the app also allows you to customize the branding of your application in the sign-in dialog box. This branding is important because signing in, is the first experience a user has with your app. You can decide if you want to allow users to sign in only if they belong to your organization. This architecture is known as a single-tenant application. Or, you can allow users to sign in by using any work or school account, which is known as a multitenant application. You can also allow personal Microsoft accounts or social accounts from LinkedIn, Google, and so on. Request scope permissions. For example, you can request the user.read scope, which grants permission to read the profile of the signed-in user. Define scopes that define access to your web API. Typically, when an app wants to access your API, it needs to request permissions to the scopes you define. Share a secret with the Microsoft identity platform that proves the app's identity. Using a secret is relevant in the case where the app is a confidential client application. A confidential client application is an application that can hold credentials securely, like a web client. A trusted back-end server is required to store the credentials.

## Learning objectives

 -  Benefits of registering an app.
 -  Single-tenant versus multitenant apps.
 -  What happens when an app is registered.
 -  Relationship between application objects and service principals.<br>

## Goals

The goal of this module is to teach you how to register your application with Microsoft Entra ID and how to configure it to integrate with the Microsoft identity platform. You learn how to customize the branding of your application in the sign-in dialog box, how to request scope permissions, and how to share a secret with the Microsoft identity platform that proves the app's identity. You'll also learn about single-tenant versus multitenant apps, application objects, and service principal objects, and the relationship between them.
