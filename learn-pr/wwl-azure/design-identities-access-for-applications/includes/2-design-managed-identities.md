Azure managed identity is a feature of Azure Active Directory (Azure AD) that you can use free of charge. This feature automatically creates identities to allow apps to authenticate with Azure resources and services.

Tailwind is planning on moving applications from on-premises servers to Azure-hosted virtual machines (VMs). Now that you host the applications on VMs in Azure, you can use managed identities.

In this unit, you'll explore the managed identity feature. You'll see how it works and what resources you can access in Azure.

## What are managed identities in Azure?

A common challenge for developers is the management of secrets and credentials used to secure communication between different components making up a solution. Managed identities eliminate the need for developers to manage credentials. Managed identities provide an identity for applications to use when connecting to resources that support Azure Active Directory (Azure AD) authentication. Applications may use the managed identity to obtain Azure AD tokens. For example, an application may use a managed identity to access resources like Azure Key Vault where developers can store credentials in a secure manner or to access storage accounts.

A managed identity combines Azure AD authentication and Azure role-based access control (RBAC). 

When you use managed identities, you don't need to rotate credentials or worry about expiring certifications. Azure handles credential rotation and expiration in the background. To configure an application to use a managed identity, you use the provided token to call the service.

## When to use managed identities 

When you work with managed identities, you should be familiar some common terms:

- Client ID: A unique ID that's linked to the Azure AD application and service principal that was created when you provisioned the identity.
- Object ID: The service principal object of the managed identity.
- Azure Instance Metadata Service: A REST API that's enabled when Azure Resource Manager provisions a VM. The endpoint is accessible only from within the VM.

Managed identities are available in all editions of Azure AD, including the Free edition included with an Azure subscription. Using it in App Service has no extra cost and requires no configuration, and it can be enabled or disabled on an app at any time.

:::image type="content" source="../media/use-managed-identites.png" alt-text="I can use managed Identities when I want to build an application using Azure App Service that access Azure Storage without having to manage any credentials.":::

Resources that support system assigned managed identities allow you to:

- Enable or disable managed identities at the resource level.
- Use RBAC roles to grant permissions.
- View create, read, update, delete (CRUD) operations in Azure Activity logs.
- View sign-in activity in Azure AD sign-in logs.

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
 
## Vault authentication with managed identities for Azure resources

Your application requires service passwords, connection strings, and other secret configuration values to do its job. Storing and handling secret values is risky, and every usage introduces the possibility of leakage. Azure Key Vault, in combination with managed identities for Azure resources, enables your Azure web app to access secret configuration values easily and securely without needing to store any secrets in your source control or configuration.

Azure Key Vault uses Azure Active Directory (Azure AD) to authenticate users and apps that try to access a vault. To grant your web app access to the vault, you first need to register our app with Azure Active Directory. Registering creates an identity for the app. After the app has an identity, you can assign vault permissions to it.

Apps and users authenticate to Key Vault using an Azure AD authentication token. Getting a token from Azure AD requires a secret or certificate because anyone with a token could use the app identity to access all the secrets in the vault.
