

Students should be familiar with Active Directory Domain Services (AD DS or traditionally called just "Active Directory"). AD DS is a directory service that provides the methods for storing directory data, such as user accounts and passwords, and makes this data available to network users, administrators, and other devices and services. It runs as a service on Windows Server, referred to as a domain controller.

Azure Active Directory (Azure AD) is part of the platform as a service (PaaS) offering and operates as a Microsoft-managed directory service in the cloud. It’s not a part of the core infrastructure that customers own and manage, nor is it an Infrastructure as a service offering. While this implies that you have less control over its implementation, it also means that you don’t have to dedicate resources to its deployment or maintenance.

With Azure AD, you also have access to a set of features that aren’t natively available in AD DS, such as support for multi-factor authentication, identity protection, and self-service password reset.

You can use Azure AD to provide more secure access to cloud-based resources for organizations and individuals by:

 -  Configuring access to applications
 -  Configuring single sign-on (SSO) to cloud-based SaaS applications
 -  Managing users and groups
 -  Provisioning users
 -  Enabling federation between organizations
 -  Providing an identity management solution
 -  Identifying irregular sign-in activity
 -  Configuring multi-factor authentication
 -  Extending existing on-premises Active Directory implementations to Azure AD
 -  Configuring Application Proxy for cloud and local applications
 -  Configuring Conditional Access for users and devices

:::image type="content" source="../media/azure-active-directory-connect-stack-f1aae359.png" alt-text="Diagram that shows the Azure AD Connect Stack.":::


Azure AD constitutes a separate Azure service. Its most elementary form, which any new Azure subscription includes automatically, doesn't incur any extra cost and is referred to as the Free tier. If you subscribe to any Microsoft Online business services (for example, Microsoft 365 or Microsoft Intune), you automatically get Azure AD with access to all the Free features.

> [!NOTE]
> By default, when you create a new Azure subscription by using a Microsoft account, the subscription automatically includes a new Azure AD tenant named Default Directory.

Some of the more advanced identity management features require paid versions of Azure AD, offered in the form of Basic and Premium tiers. Some of these features are also automatically included in Azure AD instances generated as part of Microsoft 365 subscriptions. Differences between Azure AD versions are discussed later in this module.

Implementing Azure AD isn't the same as deploying virtual machines in Azure, adding AD DS, and then deploying some domain controllers for a new forest and domain. Azure AD is a different service, much more focused on providing identity management services to web-based apps, unlike AD DS, which is more focused on on-premises apps.

### Azure AD tenants

Unlike AD DS, Azure AD is multi-tenant by design and is implemented specifically to ensure isolation between its individual directory instances. It’s the world’s largest multi-tenant directory, hosting over a million directory services instances, with billions of authentication requests per week. The term tenant in this context typically represents a company or organization that signed up for a subscription to a Microsoft cloud-based service such as Microsoft 365, Intune, or Azure, each of which uses Azure AD. However, from a technical standpoint, the term tenant represents an individual Azure AD instance. Within an Azure subscription, you can create multiple Azure AD tenants. Having multiple Azure AD tenants might be convenient if you want to test Azure AD functionality in one tenant without affecting the others.

At any given time, an Azure subscription must be associated with one, and only one, Azure AD tenant. This association allows you to grant permissions to resources in the Azure subscription (via RBAC) to users, groups, and applications that exist in that particular Azure AD tenant. 

> [!NOTE]
> You can associate the same Azure AD tenant with multiple Azure subscriptions. This allows you to use the same users, groups, and applications to manage resources across multiple Azure subscriptions.

Each Azure AD tenant is assigned the default Domain Name System (DNS) domain name, consisting of a unique prefix. The prefix, derived from the name of the Microsoft account you use to create an Azure subscription or provided explicitly when creating an Azure AD tenant, is followed by the **onmicrosoft.com** suffix. Adding at least one custom domain name to the same Azure AD tenant is possible and common. This name utilizes the DNS domain namespace that the corresponding company or organization owns. The Azure AD tenant serves as the security boundary and a container for Azure AD objects such as users, groups, and applications. A single Azure AD tenant can support multiple Azure subscriptions.

### Azure AD schema

The Azure AD schema contains fewer object types than that of AD DS. Most notably, it doesn't include a definition of the computer class, although it does include the device class. The process of joining devices to Azure AD differs considerably from the process of joining computers to AD DS. The Azure AD schema is also easily extensible, and its extensions are fully reversible.

The lack of support for the traditional computer domain membership means that you can't use Azure AD to manage computers or user settings by using traditional management techniques, such as Group Policy Objects (GPOs). Instead, Azure AD and its services define a concept of modern management. Azure AD’s primary strength lies in providing directory services; storing and publishing user, device, and application data; and handling the authentication and authorization of the users, devices, and applications. The effectiveness and efficiency of these features are apparent based on existing deployments of cloud services such as Microsoft 365, which rely on Azure AD as their identity provider and support millions of users.

Azure AD doesn't include the organizational unit (OU) class, which means that you can't arrange its objects into a hierarchy of custom containers, which is frequently used in on-premises AD DS deployments. However, this isn't a significant shortcoming, because OUs in AD DS are used primarily for Group Policy scoping and delegation. You can accomplish equivalent arrangements by organizing objects based on their group membership.

Objects of the Application and servicePrincipal classes represent applications in Azure AD. An object in the Application class contains an application definition and an object in the servicePrincipal class constitutes its instance in the current Azure AD tenant. Separating these two sets of characteristics allows you to define an application in one tenant and use it across multiple tenants by creating a service principal object for this application in each tenant. Azure AD creates the service principal object when you register the corresponding application in that Azure AD tenant.