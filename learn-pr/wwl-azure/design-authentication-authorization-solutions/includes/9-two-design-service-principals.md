When a user or application requests access to a resource that's secured by a Microsoft Entra tenant, the user or app must be represented by a _security principal_. The security principal defines the access policy and permissions for the user (_user principal_) or app (_service principal_) in the Microsoft Entra tenant. The principal supports core features like authentication for a user and app during sign-in, or authorization during resource access.

The Tailwind Traders organization is interested in implementing service principals for its applications. As the CTO, you need to understand the two ways an app can be represented in Microsoft Entra ID: as an application object, or by a service principal.

- **Application objects**: Although there are exceptions, an app object can be considered _the definition for an app_. An app object allows the service to know how to issue tokens to the app based on the object settings. The app object exists only in its home directory, even if it's a multi-tenant app that supports service principals in other directories.

- **Service principals**: The service principal for an app can be considered _an instance of an app_. Service principals generally reference an app object. One app object can be referenced by multiple service principals across directories.

Service principals are what govern the app connection to Microsoft Entra ID and can be considered the instance of the app in your directory. 

:::image type="content" source="../media/application-service-principals.png" alt-text="Diagram that shows how application objects and service principals are used in Azure subscriptions." border="false":::

### Types of service principals

There are three types of service principals that you can use for your organization: application, managed identity, and legacy.

- **Application**: An application service principal is a local representation, or app instance, of a global app object in a single tenant or directory. This service principal is a concrete instance created from the app object that inherits certain properties from the object. The principal is created in each tenant where the app is used, and references the globally unique object. The service principal object defines what the app can do in the specific tenant, who can access the app, and what resources the app can access.

   While an app object is the global representation of your app for use across all tenants, the application service principal is the local representation that's used in a _specific_ tenant. The app object serves as the template from which common and default properties are derived for use in creating corresponding service principal objects.

- **Managed identity**: This type of service principal represents a managed identity, which eliminates the need to manage credentials. Managed identities provide an identity for applications to use when connecting to resources that support Microsoft Entra authentication. When a managed identity is enabled, the service principal that represents that managed identity is created in your tenant.

   Common terms for managed identities and service principals:

   - **Client ID**: The unique ID that's linked to the app and service principal created when you provisioned the identity.
   - **Object ID**: The service principal object of the managed identity.
   - **Azure Instance Metadata Service**: The REST API that's enabled when Azure Resource Manager creates a VM. The endpoint is accessible only from within the VM.

- **Legacy**: A legacy service principal represents a legacy app that was created before app registrations were introduced, or an app created through a legacy configuration experience. A legacy service principal can have credentials, service principal names, reply URLs, and other properties that an authorized user can edit. A legacy service principal doesn't have an associated app registration. 

### Things to know about application objects and service principals

As you continue to plan the identity strategy for Tailwind Traders, consider these characteristics of app objects and service principals:

- An app can have at most one app object, which is registered in a "home" directory.

- An app can have one or more service principal objects that represent instances of the app in every directory in which it acts.

- An app object has a `1:1` relationship with the software app, and a `1:many` relationship with its service principal object(s).

- A service principal must be created in each tenant where the app is used, to establish an identity for sign-in and access to resources secured by the tenant.

- A single-tenant app has only one service principal (in its home tenant) that's created and consented for use during app registration. A multi-tenant app also has a service principal created in each tenant where a user from that tenant has consented to its use.

- Managed identity service principals can be granted access and permissions, but they can't be updated or modified directly.

- Legacy service principals can only be used in the tenant where they're created.

### Things to consider when using service principals

Now you're ready to review how you can use managed identities and service principals in your strategy for Tailwind Traders. 

- **Consider how to create your application service principals**. A service principal object for an app can be created in different ways:

   - When an app is given permission to access resources in a tenant (upon registration or consent), a service principal object is created.
   - When you register an app by using the Azure portal, a service principal is created automatically.
   - You can create service principal objects in a tenant by using Azure PowerShell, the Azure CLI, Microsoft Graph, and other tools.

- **Consider service principals without managed identities**. Use service principals _without_ managed identities when you want to be able to manage the credentials.

- **Consider authentication of external apps to Azure resources**. Authenticate external apps to Azure resources by using service principals.

- **Consider the best practices for requesting permissions**. (Recommended) Review these suggestions for how to build apps that use Microsoft Entra ID to provide sign-in and access tokens for secured endpoints:

   - Only ask for the permissions required for implemented app functionality. Don't request user consent for permissions that you haven't yet implemented for your application.
   - When you request permissions for app functionality, request the least-privileged access. If an app analyzes a user's email, but it takes no action on the mailbox, you shouldn't request the more permissive `Mail.ReadWrite` permission when the `Mail.Read` permission is sufficient.
   - Apps should gracefully handle scenarios where the user doesn't grant consent to the app when permissions are requested. In the case where an app doesn't receive an access token with the required permissions, the app should explain the situation to the user with options on how to remedy the issue.

- **Consider restricting user consent**. (Microsoft recommended) Restrict user consent to allow users to consent only for apps from verified publishers, and only for the Tailwind Traders permissions you select. For apps that don't meet this policy, centralize the decision-making process to the security and identity administrator team. After end-user consent is disabled or restricted, there are several important considerations to ensure your organization stays secure while still allowing business-critical applications to be used. These steps are crucial to minimize impact on your organization's support team and IT admins, while preventing the use of unmanaged accounts in third-party applications.
