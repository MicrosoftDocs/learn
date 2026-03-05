After completing the app registration, you have a globally unique instance of the app (the application object) that lives within your home tenant or directory. You also have a globally unique ID for your app (the app/client ID). In the Microsoft Entra admin center, you can then add secrets or certificates and scopes to make your app work, customize the branding of your app in the sign-in dialog, and more.

If you register an application in the Microsoft Entra admin center, an application object and a service principal object are automatically created in your home tenant. If you register/create an application using the Microsoft Graph APIs, creating the service principal object is a separate step.

> [!NOTE]
> **Security Best Practice**: For applications authentication (workload identities), Microsoft recommends using certificates instead of passwords for enhanced security. For Azure workloads, managed identities are the preferred approach as they eliminate the need to manage credentials entirely.

## Application object

A Microsoft Entra application is defined by its application object, which resides in the Microsoft Entra tenant where the application was registered (known as the application's "home" tenant). An application object is used as a template or blueprint to create one or more service principal objects. A service principal is created in every tenant where the application is used. Similar to a class in object-oriented programming, the application object has some static properties that are applied to all the created service principals (or application instances).

The application object describes three aspects of an application:

- How the service can issue tokens in order to access the application
- The resources that the application might need to access
- The actions that the application can take

The application object might include (but not limited to):

- Name, logo, and publisher
- Redirect URIs
- Authentication credentials:
  - Certificates (recommended for enhanced security)
  - Client secrets (passwords - use only when certificates aren't feasible)
- API dependencies (OAuth)
- Published APIs/resources/scopes (OAuth)
- App roles
- Single sign-on (SSO) metadata and configuration
- User provisioning metadata and configuration
- Proxy metadata and configuration

## Service principal object

To access resources that secured by a Microsoft Entra tenant, the entity that requires access must be represented by a security principal. This requirement is true for both users (user principal) and applications (service principal). The security principal defines the access policy and permissions for the user/application in the Microsoft Entra tenant. This enables core features such as authentication of the user/application during sign-in, and authorization during resource access. The types of service principal:

- **Application** - The service principal is the local representation, or application instance, of a global application object in a single tenant or directory. In this case, a service principal is a concrete instance created from the application object and inherits certain properties from that application object. When an application is given permission to access resources in a tenant, a service principal object is created.
- **Managed identity** (Recommended for Azure workloads) - The service principal is used to represent a managed identity. Managed identities eliminate the need for developers to manage credentials, reducing security risks, and operational overhead. Managed identities provide an identity for applications to use when connecting to resources that support Microsoft Entra authentication. A managed identity is the preferred approach for Azure-hosted applications.
- **Legacy** - The service principal represents a legacy app, which is an app created before app registrations were introduced or an app created through legacy experiences. A legacy service principal can have credentials, service principal names, reply URLs, and other properties. Legacy service principals should be migrated to modern app registrations when possible.

The service principal can include:

- A reference back to an application object through the application ID property
- Records of local user and group application-role assignments
- Records of local user and admin permissions granted to the application
- Records of local policies including Conditional Access policy
- Records of alternate local settings for an application

## Relationship between application objects and service principals

The application object is the global representation of your application for use across all tenants, and the service principal is the local representation for use in a specific tenant. The application object serves as the template from which common and default properties are derived for use in creating corresponding service principal objects. An application object has:

- A one-to-one relationship with the software application
- A one-to-many relationship with its corresponding service principal object(s)

A service principal must be created in each tenant where the application is used, enabling it to establish an identity for sign-in and/or access to resources being secured by the tenant. A single-tenant application has only one service principal (in its home tenant), created and consented for use during application registration. A multitenant application also has a service principal created in each tenant where a user from that tenant has consented to its use.

## Managing Application Objects and Service Principals

Always have a management strategy and process for maintaining your service principals.

### Consequences of Modifications and Deletion

Any changes made to your application object are reflected in its service principal object in the application's home tenant only. This means:

- Deleting an application object will also delete its home tenant service principal object
- However, restoring the application object through the Microsoft Entra admin center won't restore its corresponding service principal
- Service principals in other tenants (for multitenant apps) remain independent of the home tenant's application object

### Finding Service Principals

You can find service principals associated with an application object in the Microsoft Entra admin center by navigating to the application registration overview and selecting **Managed application in local directory**.

 > [!IMPORTANT]
 > When working with workload identities (non-human identities like applications), always consider the security implications of credential management and prefer managed identities for Azure resources whenever possible.
