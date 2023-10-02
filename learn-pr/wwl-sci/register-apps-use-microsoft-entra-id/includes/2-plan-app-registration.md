Application (App) registration in Microsoft Entra is the process of ensuring that your identity system is aware of what applications used. This way you can confirm the user has access to the app and that the app has access to any needed resources. This ensures the security and privacy of users, apps, and your data.

## Benefits of registering an app

When you register your application with Microsoft Entra ID, you're providing an identity configuration for your application that allows it to integrate with the Microsoft identity platform. Registering the app also allows you to:

 -  Customize the branding of your application in the sign-in dialog.
    
    
     -  This branding is important because signing in is the first experience a user will have with your app.
 -  Decide if you want to allow users to sign in only if they belong to your organization.
    
    
     -  This architecture is known as a single-tenant application. Or, you can allow users to sign in by using any work or school account, which is known as a multitenant application. You can also allow personal Microsoft accounts or a social account from LinkedIn, Google, and so on.<br>
 -  Request scope permissions.
    
    
     -  For example, you can request the "user.read" scope, which grants permission to read the profile of the signed-in user.
 -  Define a scope that defines access to your web API.
    
    
     -  Typically, when an app wants to access your API, it will need to request permissions to the scopes you define.
 -  Share a secret with the Microsoft identity platform that proves the app's identity.
    
    
     -  Using a secret is relevant in the case where the app is a confidential client application. A confidential client application is an application that can hold credentials securely, like a web client. A trusted back-end server is required to store the credentials.

### Single tenant versus multitenant apps

As the name implies an app registered as a single tenant app is only available to users and resources. In the case of apps registered as multitenant apps, users from different tenants can access the apps. The multitenant scenario should be used intentionally when needed. In the multitenant scenario, a service principal object is created in the directory for each tenant the app has users. The creation of the service principal happens at the time of app registration in the source tenant, and during the first user authentication in other tenants. When it comes to developing apps, developers can choose to configure their app to be either single-tenant or multitenant during app registration in the Azure portal.

 -  Single-tenant apps are only available in the tenant they were registered in, also known as their home tenant.
 -  multitenant apps are available to users in both their home tenant and other tenants.

In the Azure portal, you can configure your app to be single-tenant or multitenant by setting the audience as follows.

| **Audience**                                                                                                 | **Single/multitenant** | **Who can sign in**                                                                                                                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------ | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Accounts in this directory only                                                                              | Single tenant          | All user and guest accounts in your directory can use your application or API.                                                                                                                                                                   |
| Accounts in any Microsoft Entra directory                                                                    | multitenant            | All users and guests with a work or school account from Microsoft can use your application or API. This includes schools and businesses that use Microsoft 365.                                                                                  |
| Accounts in any Microsoft Entra directory and personal Microsoft accounts (such as Skype, Xbox, Outlook.com) | multitenant            | All users with a work or school, or personal Microsoft account can use your application or API. It includes schools and businesses that use Microsoft 365 as well as personal accounts that are used to sign in to services like Xbox and Skype. |

## What happens when an app is registered

After the app is registered, it's given a unique identifier that it shares with the Microsoft identity platform when it requests tokens. If the app is a confidential client application, it will also share the secret or the public key depending on whether certificates or secrets were used. There are two representations of applications in Microsoft Entra ID:

 -  **Application objects** \- Although there are exceptions, application objects can be considered the definition of an application.
 -  **Service principals** \- Can be considered an instance of an application. Service principals generally reference an application object, and one application object can be referenced by multiple service principals across directories.

The Microsoft identity platform represents applications by using a model that fulfills two main functions. First, the identity platform will Identify the app by the authentication protocols it supports. And second, it provides all the identifiers, URLs, secrets, and related information that are needed to authenticate.

The Microsoft identity platform:

 -  Holds all the data required to support authentication at runtime.
 -  Holds all the data for deciding what resources an app might need to access, and under what circumstances a given request should be fulfilled.
 -  Provides infrastructure for implementing app provisioning within the app developer's tenant, and to any other Microsoft Entra tenant.
 -  Handles user consent during token request time and facilitates the dynamic provisioning of apps across tenants.

Consent is the process of a resource owner granting authorization for a client application to access protected resources, under specific permissions, on behalf of the resource owner. Microsoft Entra enables users and administrators to dynamically grant or deny consent for the app to access resources on their behalf. And ultimately enables administrators to decide what apps are allowed to do and which users can use specific apps, and how the directory resources are accessed.
