In Microsoft Entra ID, there are different types of identities that are supported. The terms you're introduced in this unit are user identities, workload identities, device identities, external identities, and hybrid identities.

When you ask the question, to what can I assign an identity in Microsoft Entra ID, there are three categories.

- You can assign identities to people (humans), referred to as user identities.
- You can assign identities to physical devices, such as mobile phones, desktop computers, and IoT devices.
- You can assign identities to software-based objects, such as applications, virtual machines, services, and containers. These types of identities are referred to as workload identities.

:::image type="content" source="../media/identity-types-updated.png" lightbox="../media/identity-types-updated.png" alt-text="A block diagram showing the categories of identity types. The categories consist of Workload identities, device identities, and human identities. Workload and device identities are grouped under machine identities.":::

In this unit, we consider each type of Microsoft Entra identity.

### User

User identities represent people such as employees and external users (customers, consultants, vendors, and partners). In Microsoft Entra ID, user identities are characterized by how they authenticate and the user type property.

How the user authenticates relative to the host organization's Microsoft Entra tenant can be internal or external. Internal authentication means the user has an account on the host organization's Microsoft Entra ID. External authentication means the user authenticates using an external Microsoft Entra account, a social network identity, or other external identity provider.

The user type property describes the user's relationship to the host organization's tenancy. The user can be a guest or a member of the organization's Microsoft Entra tenant. By default, guests have limited privileges relative to members.

:::image type="content" source="../media/entra-id-user-properties-v3-inline.png" lightbox="../media/entra-id-user-properties-v2-expanded.png" alt-text="A four by four matrix showing the types of user identities supported based on whether they're a guest or member user. The matrix also shows type of user based on whether they use internal or external authentication.":::

- Internal member: These users are typically considered employees of your organization. The user authenticates internally via their organization’s Microsoft Entra ID, and the user object created in the resource Microsoft Entra directory has a UserType of Member.
- External guest: External users or guests, including consultants, vendors, and partners, typically fall into this category. The user authenticates using an external Microsoft Entra account or an external identity provider (such as a social identity), and their user object has a UserType of Guest.
- External member: This scenario is common in organizations consisting of multiple tenants. For example, if the Contoso and Fabrikam Microsoft Entra tenants are within one large organization, Contoso users can be configured in the Fabrikam Microsoft Entra directory to authenticate with their Contoso account (external to Fabrikam) but have a UserType of Member, enabling member-level access to Fabrikam's resources.
- Internal guest: This scenario exists when organizations set up internal Microsoft Entra accounts for external users such as distributors or vendors, but designate them as guests by setting the user object UserType to Guest. This is considered a legacy scenario, as it's now more common to use B2B collaboration where users can use their own credentials.

External guests and external members are B2B collaboration users that fall under external identities in Microsoft Entra ID, described in the subsequent unit.

### Workload identities

A workload identity is an identity you assign to a software workload to enable it to authenticate to and access other services and resources.

Securing workload identities is important because a software workload may deal with multiple credentials to access different resources, and those credentials need to be stored securely. It's also hard to track when a workload identity is created or when it should be revoked. Microsoft Entra Workload ID helps resolve these issues.

In Microsoft Entra, workload identities are applications, service principals, and managed identities.

#### Applications and service principals

A service principal is essentially, an identity for an application. For an application to delegate its identity and access functions to Microsoft Entra ID, the application must first be registered with Microsoft Entra ID to enable its integration. Once an application is registered, a service principal is created in each Microsoft Entra tenant where the application is used. The service principal enables core features such as authentication and authorization of the application to resources that are secured by the Microsoft Entra tenant.

For service principals to access resources, application developers must manage and protect the credentials. Managed identities help offload that responsibility from developers.

#### Managed identities

Managed identities are a type of service principal. Managed identities are automatically managed in Microsoft Entra ID and eliminate the need for developers to manage credentials. Managed identities provide an identity for applications to use when connecting to Azure resources that support Microsoft Entra authentication and can be used without any extra cost.

:::image type="content" source="../media/managed-identities-inline.png" lightbox="../media/managed-identities-expanded.png" alt-text="A Diagram that shows how a developer may use managed identities to get access to resources from their code without managing credentials.":::

There are two types of managed identities: system-assigned and user-assigned.

- **System-assigned**. Some Azure resources, such as virtual machines, allow you to enable a managed identity directly on the resource. When you enable a system-assigned managed identity, an identity is created in Microsoft Entra that's tied to the lifecycle of that Azure resource. When the resource is deleted, Azure automatically deletes the identity for you.

- **User-assigned**. You may also create a managed identity as a standalone Azure resource. Once you create a user-assigned managed identity, you can assign it to one or more instances of an Azure service. With user-assigned managed identities, the identity is managed separately from the resources that use it. Deleting the resources that use the user-assigned managed identity doesn't delete the identity; it must be explicitly deleted.

### Agent identities

As AI agents become more prevalent in organizations, securing their access to resources is critical. Microsoft Entra Agent ID extends identity and access management capabilities to AI agents by providing purpose-built agent identities. These are specialized identities in Microsoft Entra, distinct from traditional workload identities, that enable organizations to register agents, enforce conditional access policies based on agent risk, and govern agent lifecycles with designated owners and sponsors for accountability. Agent identities support both attended scenarios, where the agent acts on behalf of a user, and unattended scenarios, where the agent operates autonomously. Microsoft Entra Agent ID is described in more detail in the next unit.

### Device

A device is a piece of hardware, such as mobile devices, laptops, servers, or printers. A device identity gives administrators information they can use when making access or configuration decisions. Device identities can be set up in different ways in Microsoft Entra ID.

- **Microsoft Entra registered devices**. The goal of Microsoft Entra registered devices is to provide users with support for bring your own device (BYOD) or mobile device scenarios. In these scenarios, a user can access your organization's resources using a personal device.
- **Microsoft Entra joined**. A Microsoft Entra joined device is a device joined to Microsoft Entra ID through an organizational account, which is then used to sign in to the device. Microsoft Entra joined devices are generally owned by the organization.
- **Microsoft Entra hybrid joined devices**. Organizations with existing on-premises Active Directory implementations can benefit from the functionality provided by Microsoft Entra ID by implementing Microsoft Entra hybrid joined devices. These devices are joined to both your on-premises Active Directory and Microsoft Entra ID, and require an organizational account to sign in to the device.

Registering and joining devices to Microsoft Entra ID gives users Single Sign-on (SSO) to cloud-based resources and on-premises applications.

IT admins can use tools like Microsoft Intune to control how an organization's devices are used.

### Groups

In Microsoft Entra ID, if you have several identities with the same access needs, you can create a group to give access permissions to all members, instead of assigning access individually. This aligns with the Zero Trust principle of limiting access to only those who need it.

There are two group types:

- Security:  A security group is the most common type of group and it's used to manage user and device access to shared resources. For example, you may create a security group for a specific security policy such as self-service password reset or for use with a conditional access policy. Members of a security group can include users (including external users), devices, other groups, service principals, and agent identities.

- Microsoft 365:  A Microsoft 365 group, which is also often referred to as a distribution group, is used for grouping users according to collaboration needs. For example, you can give members of the group access to a shared mailbox, calendar, files, SharePoint sites, and more. Members of a Microsoft 365 group can only include users, including users outside of your organization.

Groups can be configured to allow members to be assigned, that is manually selected, or they can be configured for dynamic membership. Dynamic membership uses rules to automatically add and remove identities.
