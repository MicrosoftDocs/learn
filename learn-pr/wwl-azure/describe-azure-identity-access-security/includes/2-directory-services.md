Microsoft Entra ID is Microsoft's cloud-based identity and access management service. You use it to sign in and access both Microsoft cloud applications and applications that you develop.

If you've worked with on-premises Active Directory, Microsoft Entra ID will feel familiar. The key difference is that you control the identity accounts while Microsoft ensures the service is available globally.

Connecting on-premises Active Directory to Microsoft Entra ID adds security. On its own, on-premises Active Directory doesn't monitor sign-in behavior. After the connection, Microsoft Entra ID can detect suspicious sign-in attempts at no extra cost — for example, sign-ins from unexpected locations or unknown devices.

## Who uses Microsoft Entra ID?

Microsoft Entra ID is for:

 -  **IT administrators**. Administrators can use Microsoft Entra ID to control access to applications and resources based on workload and security requirements.
 -  **App developers**. Developers can use Microsoft Entra ID as a standards-based way to add functionality to their applications, such as SSO or support for existing user credentials.
 -  **Users**. Users can manage their identities and perform tasks like self-service password reset.
 -  **Online service subscribers**. Microsoft 365, Azure, and Dynamics 365 subscribers already use Microsoft Entra ID to sign in to their accounts.

## What does Microsoft Entra ID do?

Microsoft Entra ID provides services such as:

 -  **Authentication** — Verifies identity before granting access. Includes self-service password reset, multifactor authentication, banned password lists, and smart lockout.
 -  **Single sign-on (SSO)** — Lets one identity access multiple applications. SSO benefits and behavior are covered in the authentication methods unit.
 -  **Application management** — Manages cloud and on-premises apps through features like Application Proxy, SaaS app integration, and the My Apps portal.
 -  **Device management** — Supports device registration and management through tools like Microsoft Intune. Enables device-based Conditional Access policies that restrict access to known devices.

:::image type="content" source="../media/directory-services-option-entra-capabilities-hub.png" alt-text="Diagram showing Microsoft Entra ID at the center with spokes connecting to Authentication, Single Sign-On, App Management, and Device Management capabilities.":::

## Can I connect my on-premises AD with Microsoft Entra ID?

Without a connection, you must maintain two separate identity sets: one in on-premises Active Directory and one in Microsoft Entra ID. Microsoft Entra Connect bridges that gap.

Microsoft Entra Connect synchronizes user identities between on-premises Active Directory and Microsoft Entra ID. Because changes flow between both systems, users have a consistent experience — including SSO, multifactor authentication, and self-service password reset — whether they access on-premises or cloud resources.

## What is Microsoft Entra Domain Services?

Microsoft Entra Domain Services provides managed domain services — domain join, group policy, LDAP, and Kerberos/NTLM authentication — without requiring you to deploy or maintain domain controllers in the cloud.

Managed domain services are especially useful for legacy applications that can't use modern authentication. You can lift and shift those applications from on-premises into a managed domain without managing an AD DS environment in the cloud.

Because Microsoft Entra Domain Services integrates with your existing Microsoft Entra tenant, users can sign in to the managed domain with their existing credentials. Existing groups and user accounts also transfer, which simplifies migration.

### How does Microsoft Entra Domain Services work?

When you create a Microsoft Entra Domain Services managed domain, you define a unique namespace. This namespace is the domain name. Azure then deploys two Windows Server domain controllers into your selected region. This pair of DCs is called a replica set.

You don't need to manage, configure, or update these DCs. The Azure platform handles the DCs as part of the managed domain, including backups and encryption at rest using Azure Disk Encryption.

### Is information synchronized?

A managed domain performs one-way synchronization from Microsoft Entra ID to Microsoft Entra Domain Services. You can create resources directly in the managed domain, but they don't synchronize back to Microsoft Entra ID. In a hybrid environment, Microsoft Entra Connect synchronizes on-premises AD DS identity information with Microsoft Entra ID, which then synchronizes to the managed domain.

:::image type="content" source="../media/directory-services-option-sync-architecture.png" alt-text="Diagram showing the identity sync flow from on-premises Active Directory through Microsoft Entra Connect to Microsoft Entra ID and Domain Services.":::


Applications, services, and VMs in Azure that connect to the managed domain can then use common Microsoft Entra Domain Services features such as domain join, group policy, LDAP, and Kerberos/NTLM authentication.

