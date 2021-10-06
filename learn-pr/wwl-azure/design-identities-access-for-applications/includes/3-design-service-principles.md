
Tailwind Traders plans to migrate most applications to the cloud, but some will remain on premises while in production. Consider the scenario where an application on-premise needs to securely access data in an Azure Storage Account. 

To access resources that are secured by an Azure AD tenant, the entity that requires access must be represented by a security principal. This requirement is true for both users (user principal) and applications (service principal). The security principal defines the access policy and permissions for the user/application in the Azure AD tenant. This enables core features such as authentication of the user/application during sign-in, and authorization during resource access.

## Service principal object
There are three types of service principal:
- Application - The type of service principal is the local representation, or application instance, of a global application object in a single tenant or directory. In this case, a service principal is a concrete instance created from the application object and inherits certain properties from that application object. A service principal is created in each tenant where the application is used and references the globally unique app object. The service principal object defines what the app can do in the specific tenant, who can access the app, and what resources the app can access.
When an application is given permission to access resources in a tenant (upon registration or consent), a service principal object is created. When you register an application using the Azure portal, a service principal is created automatically. You can also create service principal objects in a tenant using Azure PowerShell, Azure CLI, Microsoft Graph, and other tools.
- Managed identity - This type of service principal is used to represent a managed identity. Managed identities eliminate the need for developers to manage credentials. Managed identities provide an identity for applications to use when connecting to resources that support Azure AD authentication. When a managed identity is enabled, a service principal representing that managed identity is created in your tenant. Service principals representing managed identities can be granted access and permissions, but cannot be updated or modified directly.
- Legacy - This type of service principal represents a legacy app, which is an app created before app registrations were introduced or an app created through legacy experiences. A legacy service principal can have credentials, service principal names, reply URLs, and other properties that an authorized user can edit, but does not have an associated app registration. The service principal can only be used in the tenant where it was created.

## Relationship between application objects and service principals
The application object is the global representation of your application for use across all tenants, and the service principal is the local representation for use in a specific tenant. The application object serves as the template from which common and default properties are derived for use in creating corresponding service principal objects.

An application object has:
- A 1:1 relationship with the software application
- A 1:many relationship with its corresponding service principal object(s).

A service principal must be created in each tenant where the application is used, enabling it to establish an identity for sign-in and/or access to resources being secured by the tenant. A single-tenant application has only one service principal (in its home tenant), created and consented for use during application registration. A multi-tenant application also has a service principal created in each tenant where a user from that tenant has consented to its use.


## Applications represented in Azure AD
There are two representations of applications in Azure AD:
- Application objects - Although there are exceptions, application objects can be considered the definition of an application.
- Service principals - Can be considered an instance of an application. Service principals generally reference an application object, and one application object can be referenced by multiple service principals across directories.

Application objects describe the application to Azure AD and can be considered the definition of the application, allowing the service to know how to issue tokens to the application based on its settings. The application object will only exist in its home directory, even if it's a multi-tenant application supporting service principals in other directories

Service principals are what govern an application connecting to Azure AD and can be considered the instance of the application in your directory. For any given application, it can have at most one application object (which is registered in a "home" directory) and one or more service principal objects representing instances of the application in every directory in which it acts.

### How are application objects and service principals related to each other?
An application has one application object in its home directory that is referenced by one or more service principals in each of the directories where it operates (including the application's home directory).
:::image type="content" source="../media/application-objects.png" alt-text="The diagram shows how application objects and service principals are related.":::

 
In the preceding diagram, Microsoft maintains two directories internally (shown on the left) that it uses to publish applications:
- One for Microsoft Apps (Microsoft services directory)
- One for pre-integrated third-party applications (App gallery directory)

Application publishers/vendors who integrate with Azure AD are required to have a publishing directory (shown on the right as "Some SaaS Directory").

Applications that you add yourself (represented as App (yours) in the diagram) include:
- Apps you developed (integrated with Azure AD)
- Apps you connected for single-sign-on
- Apps you published using the Azure AD application proxy


## Design a user consent solution for applications
The Microsoft identity platform implements the OAuth 2.0 authorization protocol. This protocol is a method that a third-party app can use to access web-hosted resources on behalf of a user. The web-hosted resources can define a set of permissions that you can use to implement functionality in smaller chunks. Developers can leverage one of two types of permissions supported by the Microsoft identity platform depending on the app scenario.

Knowing the different types of permissions supported in Azure AD applications will enable you to design an access strategy that works for your organization. You'll also learn about the different consent framework models and how they are used to obtain permissions from users for use in custom apps.

## Types of permissions
Microsoft identity platform supports two types of permissions: delegated permissions and application permissions.

- Delegated permissions are used by apps that have a signed-in user present. These permissions are provided to the application by the user so the app can perform actions on their behalf. This doesn't give permissions to the app, instead the user is simply allowing the app to act on their behalf using their permissions.
- Application permissions are used by apps that run without a signed-in user present.

## Effective permissions
Effective permissions are the permissions that your app will have when making requests to the target resource. It's important to understand the difference between the delegated and application permissions that your app is granted and its effective permissions when making calls to the target resource.

:::image type="content" source="../media/user-permissions.png" alt-text="Diagram showing the difference between the delegated and application permissions that your app is granted and its effective permissions when making calls to the target resource.":::

 
For delegated permissions, the effective permissions of your app are the intersection of the delegated permissions the app has been granted and the privileges of the currently signed-in user. In other words, the app can never have more privileges than the signed-in user. Within organizations, the privileges of the signed-in user may be determined by policy or by membership in one or more administrator roles.
:::image type="content" source="../media/effective-permissions.png" alt-text="Diagram showing the effective permissions as the intersection of app permissions and user capabilities.":::

 
For example, assume your app has been granted the User.ReadWrite.All delegated permission. This permission enables your app to be used to read and update the profile of every user in an organization. If the signed-in user is a global administrator, your app can update the profile of every user in the organization. However, if the signed-in user isn't in an administrator role, your app can update only the profile of the signed-in user. It can't update the profiles of other users in the organization because the user that it has permission to act on behalf of does not have those privileges.

For application permissions, the effective permissions of your app will be the full level of privileges implied by the permission. For example, an app that has the User.ReadWrite.All application permission can update the profile of every user in the organization.

##Best practices for requesting permissions
When building an app that uses Azure AD to provide sign-in and access tokens for secured endpoints, there are a few good practices you should follow.
- Only ask for the permissions required for implemented app functionality. Don't request user consent for permissions that you haven't yet implemented for your application.
- In addition, when requesting permissions for app functionality, you should request the least-privileged access. For example, if an app analyzes a user's email but takes no action on the mailbox, you shouldn't request the more permissive Mail.ReadWrite when Mail.Read will work.
- Apps should gracefully handle scenarios where the user doesn't grant consent to the app when permissions are requested. In the case where an app doesn't receive an access token with the required permissions, it should explain the situation to the user with options on how to remedy the issue.

Microsoft recommends restricting user consent to allow users to consent only for app from verified publishers, and only for permissions you select. For apps which do not meet this policy, the decision-making process will be centralized with your organization's security and identity administrator team.

After end-user consent is disabled or restricted, there are several important considerations to ensure your organization stays secure while still allowing business critical applications to be used. These steps are crucial to minimize impact on your organization's support team and IT administrators, while preventing the use of unmanaged accounts in third-party applications.


## Process changes and education
- Consider enabling the admin consent workflow to allow users to request administrator approval directly from the consent screen.
- Ensure all administrators understand the permissions and consent framework, how the consent prompt works, and how to evaluate a request for tenant-wide admin consent.
- Review your organization's existing processes for users to request administrator approval for an application, and make updates if necessary. If processes are changed:
o	Update the relevant documentation, monitoring, automation, and so on.
o	Communicate process changes to all affected users, developers, support teams, and IT administrators.

To minimize impact on trusted, business-critical applications which are already in use, consider proactively granting administrator consent to applications that have a high number of user consent grants:
- Take an inventory of the apps already added to your organization with high usage, based on sign-in logs or consent grant activity. A PowerShell script can be used to quickly and easily discover applications with a large number of user consent grants.
- Evaluate the top applications that have not yet been granted admin consent.

Important
Carefully evaluate an application before granting tenant-wide admin consent, even if many users in the organization have already consented for themselves.

- For each application that is approved, grant tenant-wide admin consent using one of the methods documented below.
- For each approved application, consider restricting user access.
