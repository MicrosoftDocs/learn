
Azure AD manages different types of identities: users, service principals, managed identities, and devices. In this unit, we consider each type of Azure AD identity.

### User

A user identity is a representation of something that's managed by Azure AD.  Employees and guests are represented as users in Azure AD. If you have several users with the same access needs, you can create a group. You use groups to give access permissions to all members of the group, instead of having to assign access rights individually.

Azure AD business-to-business (B2B) collaboration, a feature within External Identities, includes the capability to add guest users. With B2B collaboration, an organization can securely share applications and services with guest users from another organization.

In the following interactive guide, you'll add a new user to Azure Active Directory. Select the image below to get started and follow the prompts on the screen.

[![Interactive guide](../media/4-active-directory-interactive-guide.png)](https://edxinteractivepage.blob.core.windows.net/edxpages/sc-900/LP02M02-Create-a-New-User-in-Azure-Active-Directory/index.html?azure-portal=true)

### Service principal

A service principal is, essentially, an identity for an application.  For an application to delegate its identity and access functions to Azure AD, the application must first be registered with Azure AD to enable its integration. Once registered, a service principal is created in each Azure AD tenant where the application is used.  The service principal enables core features such as authentication and authorization of the application to resources that are secured by the Azure AD tenant.  

For the service principals to be able to access resources secured by the Azure AD tenant, application developers must manage and protect the credentials.

### Managed identity

Managed identities are a type of service principal that are automatically managed in Azure AD and eliminate the need for developers to manage credentials.  Managed identities provide an identity for applications to use when connecting to Azure resources that support Azure AD authentication and can be used without any extra cost.

:::image type="content" source="../media/when-use-managed-identities-inline.png" lightbox="../media/when-use-managed-identities-expanded.png" alt-text="How a developer may use managed identities to get access to resources from their code without managing credentials.":::

For a list of Azure Services that support managed identities, refer to the Learn more section of the Summary and resources unit.

There are two types of managed identities: system-assigned and user-assigned.

**System-assigned**. Some Azure services allow you to enable a managed identity directly on a service instance. When you enable a system-assigned managed identity, an identity is created in Azure AD that's tied to the lifecycle of that service instance. When the resource is deleted, Azure automatically deletes the identity for you. By design, only that Azure resource can use this identity to request tokens from Azure AD.

**User-assigned**. You may also create a managed identity as a standalone Azure resource. Once you create a user-assigned managed identity you can assign it to one or more instances of an Azure service. With user-assigned managed identities, the identity is managed separately from the resources that use it.

The following table summarizes the differences between system-assigned and user-assigned managed identities:

|Property  |System-assigned managed identity  |User-assigned managed identity  |
|---------|---------|---------|
|Creation|Created as part of an Azure resource, such as an Azure virtual machine or Azure App Service.|Created as a standalone Azure resource.|
|Lifecycle|Shared lifecycle with the Azure resource. When the parent resource is deleted, the managed identity is also deleted.|Independent life cycle. Must be explicitly deleted.|
|Sharing across Azure resources|Cannot be shared. Associated with a single Azure resource.|Can be shared. A user-assigned managed identity can be associated with more than one Azure resource.|
|Common use cases|Workloads that are contained within a single Azure resource.  Workloads for which you need independent identities, such as an application that runs on a single virtual machine.|Workloads that run on multiple resources and which can share a single identity.  Workloads that need preauthorization to a secure resource as part of a provisioning flow.  Workloads where resources are recycled frequently, but permissions should stay consistent.  For example, a workload where multiple virtual machines need to access the same resource.|

### Device

A device is a piece of hardware, such as mobile devices, laptops, servers, or printers. A device identity gives administrators information they can use when making access or configuration decisions.  Device identities can be set up in different ways in Azure AD.

- **Azure AD registered devices**. The goal of Azure AD registered devices is to provide users with support for bring your own device (BYOD) or mobile device scenarios. In these scenarios, a user can access your organization’s resources using a personal device. Azure AD registered devices register to Azure AD without requiring an organizational account to sign in to the device. Supported operating systems for Azure AD registered devices include Windows 10 and above, iOS, Android, and macOS.  
- **Azure AD joined**. An Azure AD joined device is a device joined to Azure AD through an organizational account, which is then used to sign in to the device. Azure AD joined devices are generally owned by the organization. Supported operating systems for Azure AD joined devices include Windows 10 or greater (except Home edition) and Windows Server 2019 Virtual Machines running in Azure.
- **Hybrid Azure AD joined devices**. Organizations with existing on-premises Active Directory implementations can benefit from the functionality provided by Azure AD by implementing hybrid Azure AD joined devices. These devices are joined to your on-premises Active Directory and Azure AD requiring an organizational account to sign in to the device

Registering and joining devices to Azure AD gives users Single Sign-on (SSO) to cloud-based resources.  Additionally, devices that are Azure AD joined benefit from the SSO experience to resources and applications that rely on on-premises Active Directory.

IT admins can use tools like Microsoft Intune, a cloud-based service that focuses on mobile device management (MDM) and mobile application management (MAM), to control how an organization’s devices are used. Refer to [Microsoft Intune](/mem/intune/fundamentals/what-is-intune) for more information.
