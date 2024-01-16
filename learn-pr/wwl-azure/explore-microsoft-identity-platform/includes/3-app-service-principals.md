To delegate Identity and Access Management functions to Microsoft Entra ID, an application must be registered with a Microsoft Entra tenant. When you register your application with Microsoft Entra ID, you're creating an identity configuration for your application that allows it to integrate with Microsoft Entra ID. When you register an app in the Azure portal, you choose whether it is:

* **Single tenant**: only accessible in your tenant 
* **Multi-tenant**: accessible in other tenants

If you register an application in the portal, an application object (the globally unique instance of the app) and a service principal object are automatically created in your home tenant. You also have a globally unique ID for your app (the app or client ID). In the portal, you can then add secrets or certificates and scopes to make your app work, customize the branding of your app in the sign-in dialog, and more.

> [!NOTE]
> You can also create service principal objects in a tenant using Azure PowerShell, Azure CLI, Microsoft Graph, and other tools.

## Application object

A Microsoft Entra application is defined by its one and only application object. The application object resides in the Microsoft Entra tenant where the application was registered (known as the application's "home" tenant). An application object is used as a template or blueprint to create one or more service principal objects. A service principal is created in every tenant where the application is used. Similar to a class in object-oriented programming, the application object has some static properties that are applied to all the created service principals (or application instances).

The application object describes three aspects of an application. How the service can issue tokens in order to access the application. Resources that the application might need to access and the actions that the application can take.

The Microsoft Graph [Application entity](/graph/api/resources/application) defines the schema for an application object's properties.

## Service principal object

To access resources secured by a Microsoft Entra tenant, the entity that requires access must be represented by a security principal. This is true for both users (user principal) and applications (service principal).

The security principal defines the access policy and permissions for the user/application in the Microsoft Entra tenant. This enables core features such as authentication of the user/application during sign-in, and authorization during resource access.

There are three types of service principal:

* **Application** - This type of service principal is the local representation, or application instance, of a global application object in a single tenant or directory. A service principal is created in each tenant where the application is used and references the globally unique app object.  The service principal object defines what the app can actually do in the specific tenant, who can access the app, and what resources the app can access. 

* **Managed identity** - This type of service principal is used to represent a [managed identity](/azure/active-directory/managed-identities-azure-resources/overview). Managed identities provide an identity for applications to use when connecting to resources that support Microsoft Entra authentication. When a managed identity is enabled, a service principal representing that managed identity is created in your tenant. Service principals representing managed identities can be granted access and permissions, but can't be updated or modified directly.

* **Legacy** - This type of service principal represents a legacy app, which is an app created before app registrations were introduced or an app created through legacy experiences. A legacy service principal can have:
    * credentials
    * service principal names
    * reply URLs
    * and other properties that an authorized user can edit, but doesn't have an associated app registration.

## Relationship between application objects and service principals

The application object is the *global* representation of your application for use across all tenants, and the service principal is the *local* representation for use in a specific tenant. The application object serves as the template from which common and default properties are *derived* for use in creating corresponding service principal objects.

An application object has:

* A one to one relationship with the software application, and
* A one to many relationships with its corresponding service principal object(s).

A service principal must be created in each tenant where the application is used to enable it to establish an identity for sign-in and/or access to resources being secured by the tenant. A single-tenant application has only one service principal (in its home tenant), created and consented for use during application registration. A multitenant application also has a service principal created in each tenant where a user from that tenant consented to its use.
