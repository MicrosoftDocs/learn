A common challenge for developers is how to manage secrets and credentials that secure communication between different components of a solution. Managed identities eliminate the need for developers to manage credentials.

Azure managed identity is a feature of Microsoft Entra ID that you can use free of charge. This feature automatically creates identities to allow apps to authenticate with Azure resources and services. Managed identities are available in all editions of Microsoft Entra ID, including the Free edition that comes with an Azure subscription. You can use managed identities in App Service at no extra cost, and with no required configuration.

Managed identities provide an identity for apps to use when connecting to resources that support Microsoft Entra authentication. Apps can use the managed identity to obtain Microsoft Entra tokens. An app might use a managed identity to access resources like Azure Key Vault where developers can store credentials in a secure manner or to access storage accounts.

### Things to know about managed identities

Tailwind Traders is planning on moving apps from on-premises servers to Azure-hosted virtual machines (VMs). Now that you host the apps on VMs in Azure, you can use managed identities. As you plan, consider these characteristics of managed identities:

- A managed identity combines Microsoft Entra authentication and Azure role-based access control (RBAC). 

- When you use managed identities, you don't need to rotate credentials or worry about expiring certifications. Azure handles credential rotation and expiration in the background. To configure an app to use a managed identity, you use the provided token to call the service.

- Resources that support system-assigned managed identities allow you to:
   - Enable or disable managed identities at the resource level.
   - Use RBAC roles to grant permissions.
   - Review create, read, update, delete (CRUD) operations in Azure Activity logs.
   - Review sign-in activity in Microsoft Entra sign-in logs.

- Managed identities can be enabled or disabled on an app at any time.

There are two types of managed identities:

- **System-assigned**: Some Azure services allow you to enable a managed identity directly on a service instance. When you enable a system-assigned managed identity, an identity is created in Microsoft Entra that's tied to the lifecycle of that service instance. When the resource is deleted, Azure automatically deletes the identity. By design, only that Azure resource can use that identity to request tokens from Microsoft Entra ID.

- **User-assigned**: You can create a managed identity as a standalone Azure resource. Create a user-assigned managed identity and assign it to one or more instances of an Azure service. A user-assigned identity is managed separately from the resources that use it.

### Things to consider when using managed identities 

Now you're ready to think about how you're going to implement managed identities for your Tailwind Traders VMs on Azure.

- **Consider your Azure services and your targets**: Build your Tailwind Traders apps with Azure App Service and access Azure Storage, and by using managed identities, you won't have to manage any credentials.

   | Build your app with an Azure service | Access a target without managing credentials |
   | --- | --- |
   | Azure Resources <br> Azure Virtual Machines <br> Azure App Service <br> Azure Functions <br> Azure Container Instances <br> Azure Kubernetes Service <br> Azure Logic Apps <br > Azure Storage | _Access any target that supports Microsoft Entra authentication_: <br> - Your applications <br> - Azure services, such as Azure Key Vault, Azure Storage, Azure SQL, and so on <br><br><br> |

- **Consider using system-assigned managed identities**. Implement system-assigned managed identities for Tailwind Traders workloads that are contained within a single Azure resource, or for workloads that need independent identities.

- **Consider choosing user-assigned managed identities**. Choose user-assigned managed identities for workloads that run on multiple resources that can share a single identity. This type of identity is also good for workloads that need pre-authorization to a secure resource as part of a provisioning flow. User-assigned identities are suited for workloads with resources that are recycled frequently, but where permissions should stay consistent.

- **Consider the benefits of managed identities for VMs in Azure**. Review these scenarios that highlight the benefits to being able to use managed identities for VMs that are hosted in Azure:

   - You decide to run the Tailwind Traders stock-tracking apps inside an Azure-hosted VM that has an assigned managed identity. This setup allows the app to use an Azure key vault to authenticate without having to store a username and password in code.
   - Now that your company has migrated your VM from on-premises to Azure, you can remove the hard-coded authentication details from the application code. You want to use the more secure managed identity token for access to Azure resources.

- **Consider Azure Key Vault authentication for Azure resources**. Authenticate managed identities for Azure resources by integrating with Azure Key Vault.

   Your Tailwind Traders app requires service passwords, connection strings, and other secret configuration values to do its job. Storing and handling secret values is risky, and every usage introduces the possibility of leakage. Use Azure Key Vault with managed identities for Azure resources to enable your Azure web app to access secret configuration values easily and securely. You won't need to store any secrets in your source control or configuration.

   Key Vault uses Microsoft Entra ID to authenticate users and apps that try to access a vault. To grant your web app access to a vault, register your app with Microsoft Entra ID to create an identity for the app. After the app has an identity, you can assign it vault permissions. Apps and users authenticate to Key Vault by using a Microsoft Entra authentication token. Getting a token from Microsoft Entra ID requires a secret or certificate because anyone with a token could use the app identity to access all the secrets in the vault.
