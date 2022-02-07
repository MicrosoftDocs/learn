## Design managed identities

Azure managed identity is a feature of Azure Active Directory (Azure AD) that you can use free of charge. This feature automatically creates identities to allow apps to authenticate with Azure resources and services.

Tailwind is planning on moving applications from on-premises servers to Azure-hosted virtual machines (VMs). Now that you host the applications on VMs in Azure, you can use managed identities.

In this unit, you'll explore the managed identity feature. You'll learn how it works and what resources you can access in Azure.

### What are managed identities in Azure?

A common challenge for developers is the management of secrets and credentials used to secure communication between different components making up a solution. Managed identities eliminate the need for developers to manage credentials. Managed identities provide an identity for applications to use when connecting to resources that support Azure Active Directory (Azure AD) authentication. Applications may use the managed identity to obtain Azure AD tokens. For example, an application may use a managed identity to access resources like Azure Key Vault where developers can store credentials in a secure manner or to access storage accounts.

A managed identity combines Azure AD authentication and Azure role-based access control (RBAC). 

When you use managed identities, you don't need to rotate credentials or worry about expiring certifications. Azure handles credential rotation and expiration in the background. To configure an application to use a managed identity, you use the provided token to call the service.

### When to use managed identities 

When you work with managed identities, you should be familiar some common terms:

- Client ID: A unique ID that's linked to the Azure AD application and service principal that was created when you provisioned the identity.
- Object ID: The service principal object of the managed identity.
- Azure Instance Metadata Service: A REST API that's enabled when Azure Resource Manager provisions a VM. The endpoint is accessible only from within the VM.

Managed identities are available in all editions of Azure AD, including the Free edition included with an Azure subscription. Using it in App Service has no extra cost and requires no configuration, and it can be enabled or disabled on an app at any time.

:::image type="content" source="../media/use-managed-identities.png" alt-text="I can use managed Identities when I want to build an application using Azure App Service that access Azure Storage without having to manage any credentials.":::

Resources that support system assigned managed identities allow you to:

- Enable or disable managed identities at the resource level.
- Use RBAC roles to grant permissions.
- Review create, read, update, delete (CRUD) operations in Azure Activity logs.
- Review sign-in activity in Azure AD sign-in logs.

There are two types of managed identities:

- **System-assigned** Some Azure services allow you to enable a managed identity directly on a service instance. When you enable a system-assigned managed identity an identity is created in Azure AD that is tied to the lifecycle of that service instance. So when the resource is deleted, Azure automatically deletes the identity for you. By design, only that Azure resource can use this identity to request tokens from Azure AD.
- **User-assigned** You may also create a managed identity as a standalone Azure resource. You can create a user-assigned managed identity and assign it to one or more instances of an Azure service. In the case of user-assigned managed identities, the identity is managed separately from the resources that use it.

When to use system assigned managed identity: 

- Workloads that are contained within a single Azure resource
- Workloads for which you need independent identities.


When to use User-assigned managed identity:

- Workloads that run on multiple resources and which can share a single identity.
- Workloads that need pre-authorization to a secure resource as part of a provisioning flow.
- Workloads where resources are recycled frequently, but permissions should stay consistent.


You can add managed identities to virtual machines (VMs) in Azure. You decide to run your stock-tracking application inside a VM that has an assigned managed identity. This setup will allow the app to use an Azure key vault to authenticate without having to store a username and password in code.

Now that your company has migrated your VM from on-premises to Azure, you can remove the hard-coded authentication details from the application code. You want to use the more secure managed identity token for access to Azure resources.
 
### Vault authentication with managed identities for Azure resources

Your application requires service passwords, connection strings, and other secret configuration values to do its job. Storing and handling secret values is risky, and every usage introduces the possibility of leakage. Azure Key Vault, in combination with managed identities for Azure resources, enables your Azure web app to access secret configuration values easily and securely without needing to store any secrets in your source control or configuration.

Azure Key Vault uses Azure Active Directory (Azure AD) to authenticate users and apps that try to access a vault. To grant your web app access to the vault, you first need to register your app with Azure Active Directory. Registering creates an identity for the app. After the app has an identity, you can assign vault permissions to it.

Apps and users authenticate to Key Vault using an Azure AD authentication token. Getting a token from Azure AD requires a secret or certificate because anyone with a token could use the app identity to access all the secrets in the vault.
To access resources that are secured by an Azure AD tenant, the entity that requires access must be represented by a security principal. This requirement is true for both users (user principal) and applications (service principal). The security principal defines the access policy and permissions for the user/application in the Azure AD tenant. This enables core features such as authentication of the user/application during sign-in, and authorization during resource access.

## Select application service principals

There are three types of service principal:
- Application - The type of service principal is the local representation, or application instance, of a global application object in a single tenant or directory. In this case, a service principal is a concrete instance created from the application object and inherits certain properties from that application object. A service principal is created in each tenant where the application is used and references the globally unique app object. The service principal object defines what the app can do in the specific tenant, who can access the app, and what resources the app can access.
When an application is given permission to access resources in a tenant (upon registration or consent), a service principal object is created. When you register an application using the Azure portal, a service principal is created automatically. You can also create service principal objects in a tenant using Azure PowerShell, Azure CLI, Microsoft Graph, and other tools.
- Managed identity - This type of service principal is used to represent a managed identity. Managed identities eliminate the need for developers to manage credentials. Managed identities provide an identity for applications to use when connecting to resources that support Azure AD authentication. When a managed identity is enabled, a service principal representing that managed identity is created in your tenant. Service principals representing managed identities can be granted access and permissions, but cannot be updated or modified directly.
- Legacy - This type of service principal represents a legacy app, which is an app created before app registrations were introduced or an app created through legacy experiences. A legacy service principal can have credentials, service principal names, reply URLs, and other properties that an authorized user can edit, but does not have an associated app registration. The service principal can only be used in the tenant where it was created.

### Relationship between application objects and service principals
The application object is the global representation of your application for use across all tenants, and the service principal is the local representation for use in a specific tenant. The application object serves as the template from which common and default properties are derived for use in creating corresponding service principal objects.

An application object has:
- A 1:1 relationship with the software application
- A 1:many relationship with its corresponding service principal object(s).

A service principal must be created in each tenant where the application is used, enabling it to establish an identity for sign-in and/or access to resources being secured by the tenant. A single-tenant application has only one service principal (in its home tenant), created and consented for use during application registration. A multi-tenant application also has a service principal created in each tenant where a user from that tenant has consented to its use.


### Applications represented in Azure AD
There are two representations of applications in Azure AD:
- Application objects - Although there are exceptions, application objects can be considered the definition of an application.
- Service principals - Can be considered an instance of an application. Service principals generally reference an application object, and one application object can be referenced by multiple service principals across directories.

Application objects describe the application to Azure AD and can be considered the definition of the application, allowing the service to know how to issue tokens to the application based on its settings. The application object will only exist in its home directory, even if it's a multi-tenant application supporting service principals in other directories

Service principals are what govern an application connecting to Azure AD and can be considered the instance of the application in your directory. For any given application, it can have at most one application object (which is registered in a "home" directory) and one or more service principal objects representing instances of the application in every directory in which it acts.

:::image type="content" source="../media/application-service-principals.png" alt-text="The diagram shows how application objects and service principals are used in Azure subscriptions.":::
- Useful when Managed Identities cannot be used
- Often used to authenticate external applications to Azure resources


## Design a user consent solution for applications
The Microsoft identity platform implements the OAuth 2.0 authorization protocol. This protocol is a method that a third-party app can use to access web-hosted resources on behalf of a user. The web-hosted resources can define a set of permissions that you can use to implement functionality in smaller chunks. Developers can leverage one of two types of permissions supported by the Microsoft identity platform depending on the app scenario.

Knowing the different types of permissions supported in Azure AD applications will enable you to design an access strategy that works for your organization. You'll also learn about the different consent framework models and how they are used to obtain permissions from users for use in custom apps.

## Types of permissions
Microsoft identity platform supports two types of permissions: delegated permissions and application permissions.

- Delegated permissions are used by apps that have a signed-in user present. These permissions are provided to the application by the user so the app can perform actions on their behalf. This doesn't give permissions to the app, instead the user is simply allowing the app to act on their behalf using their permissions.
- Application permissions are used by apps that run without a signed-in user present.

## Effective permissions
Effective permissions are the permissions that your app will have when making requests to the target resource. It's important to understand the difference between the delegated and application permissions that your app is granted and its effective permissions when making calls to the target resource.

For delegated permissions, the effective permissions of your app are the intersection of the delegated permissions the app has been granted and the privileges of the currently signed-in user. In other words, the app can never have more privileges than the signed-in user. Within organizations, the privileges of the signed-in user may be determined by policy or by membership in one or more administrator roles.

For example, assume your app has been granted the User.ReadWrite.All delegated permission. This permission enables your app to be used to read and update the profile of every user in an organization. If the signed-in user is a global administrator, your app can update the profile of every user in the organization. However, if the signed-in user isn't in an administrator role, your app can update only the profile of the signed-in user. It can't update the profiles of other users in the organization because the user that it has permission to act on behalf of does not have those privileges.

For application permissions, the effective permissions of your app will be the full level of privileges implied by the permission. For example, an app that has the User.ReadWrite.All application permission can update the profile of every user in the organization.

## Best practices for requesting permissions
When building an app that uses Azure AD to provide sign-in and access tokens for secured endpoints, there are a few good practices you should follow.
- Only ask for the permissions required for implemented app functionality. Don't request user consent for permissions that you haven't yet implemented for your application.
- In addition, when requesting permissions for app functionality, you should request the least-privileged access. For example, if an app analyzes a user's email but takes no action on the mailbox, you shouldn't request the more permissive Mail.ReadWrite when Mail.Read will work.
- Apps should gracefully handle scenarios where the user doesn't grant consent to the app when permissions are requested. In the case where an app doesn't receive an access token with the required permissions, it should explain the situation to the user with options on how to remedy the issue.

Microsoft recommends restricting user consent to allow users to consent only for app from verified publishers, and only for permissions you select. For apps which do not meet this policy, the decision-making process will be centralized with your organization's security and identity administrator team.

After end-user consent is disabled or restricted, there are several important considerations to ensure your organization stays secure while still allowing business critical applications to be used. These steps are crucial to minimize impact on your organization's support team and IT administrators, while preventing the use of unmanaged accounts in third-party applications.


