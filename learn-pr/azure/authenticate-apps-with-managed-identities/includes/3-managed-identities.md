Azure managed identity is a feature of Azure Active Directory (Azure AD) that you can use free of charge. This feature automatically creates identities to allow apps to authenticate with Azure resources and services.

Imagine that your company has moved all of its applications from on-premises servers to Azure-hosted virtual machines (VMs). The on-premises applications authenticated to Azure by using service principals. Now that you host the applications on VMs in Azure, you can use managed identities.

In this unit, you'll explore the managed identity feature. You'll see how it works and what resources you can access in Azure.

## What are managed identities in Azure?

You use managed identities to authenticate any Azure service that supports a feature. To use managed identities, you don't need to provide authentication credentials in your code. The managed identity feature solves the credential problem by granting an automatically managed identity. You use this service principal to authenticate to Azure services.

A managed identity combines Azure AD authentication and Azure role-based access control (RBAC). For system-assigned identities, setting up a managed identity is as easy as toggling a switch.

When you use managed identities, you don't need to rotate credentials or worry about expiring certifications. Azure handles credential rotation and expiration in the background. To configure an application to use a managed identity, you use the provided token to call the service.

The term *Managed Service Identity* (MSI), which is still used in some client libraries, has been replaced by *managed identities for Azure resources*.

## How managed identities work

When you work with managed identities, you should be familiar some common terms:

- **Client ID**: A unique ID that's linked to the Azure AD application and service principal that was created when you provisioned the identity.
- **Object ID**: The service principal object of the managed identity.
- **Azure Instance Metadata Service**: A REST API that's enabled when Azure Resource Manager provisions a VM. The endpoint is accessible only from within the VM.

You can create two types of managed identity: *system-assigned managed identity* and *user-assigned managed identity*. These types are similar, but they're used differently.

### System-assigned managed identity

You enable system-assigned managed identity directly on an Azure service instance, such as a VM. When you enable that identity, Azure creates a service principal through Azure Resource Manager.

The service principal is for the resource that's connected to the information about the managed identity on the Azure AD tenant. For example, if you have two VMs, managed identity has to be enabled on each VM.

The status of the managed identity is directly linked to the status of the resource. If the resource is deleted, so is the managed identity. A resource can have only one system-assigned managed identity.

### User-assigned managed identity

User-assigned managed identity is created as a standalone Azure resource. It's independent of any app. When user-assigned managed identity is provisioned, Azure creates a service principal just as it does for a system-assigned managed identity.

However, a user-assigned managed identity isn't tied to a specific resource, so you can assign it to more than one application. For example, if your web app is deployed on 10 front-end VMs, you create a user-assigned managed identity for the app, and then associate it with all 10 VMs. If you used system-assigned managed identity, you would need 10 identities, and then you would have to manage access for each one.

## Use managed identities with Azure resources

Your stock-tracking application retrieves database credentials from an Azure Key Vault. When the application ran on-premises, it used a service principal and certificates to access credentials in the vault. Now that you host the VM on Azure, you can use a system-assigned managed identity instead.

To set up a managed identity:

1. In the Azure portal, go to the VM that hosts the app.
1. On the overview page, in the left menu pane, under **Settings**, select **Identity**.
1. Choose a system-assigned identity or a user-assigned identity. To do so, change the status to **On**.
1. Save the changes.

Next, the system reminds you that the server will be registered with Azure AD, and that you can grant permissions to resources there.

You can always see the current managed identities for the subscription in Azure AD on the **Enterprise applications** pane. On the overview page, you can assign users and change permissions.

:::image type="content" source="../media/3-managed-identity.png" alt-text="Screenshot of the Azure portal, showing the overview page for a managed identity." loc-scope="azure-active-directory-b2c":::
