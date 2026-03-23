Microsoft Entra ID is Microsoft's cloud-based identity and access management service. It lets you sign in and access both Microsoft cloud applications and cloud applications that you develop.

If you've worked with on-premises Active Directory, Microsoft Entra ID will feel familiar. The key difference is that you control the identity accounts while Microsoft ensures the service is available globally.

Connecting the two unlocks extra protection. On its own, on-premises Active Directory doesn't monitor sign-in behavior. Once connected to Microsoft Entra ID, Microsoft can detect suspicious sign-in attempts at no extra cost — for example, sign-ins from unexpected locations or unknown devices.

## Who uses Microsoft Entra ID?

Microsoft Entra ID is for:

 -  **IT administrators**. Administrators can use Microsoft Entra ID to control access to applications and resources based on workload and security requirements.
 -  **App developers**. Developers can use Microsoft Entra ID to provide a standards-based approach for adding functionality to applications that they build, such as adding SSO functionality to an app or enabling an app to work with a user's existing credentials.
 -  **Users**. Users can manage their identities and take maintenance actions like self-service password reset.
 -  **Online service subscribers**. Microsoft 365, Microsoft Office 365, Azure, and Microsoft Dynamics CRM Online subscribers are already using Microsoft Entra ID to authenticate into their account.

## What does Microsoft Entra ID do?

Microsoft Entra ID provides services such as:

 -  **Authentication** — Verifies identity before granting access. Includes self-service password reset, multifactor authentication, banned password lists, and smart lockout.
 -  **Single sign-on (SSO)** — Lets one identity access multiple applications. SSO benefits and behavior are covered in the authentication methods unit.
 -  **Application management** — Manages cloud and on-premises apps through features like Application Proxy, SaaS app integration, and the My Apps portal.
 -  **Device management** — Supports device registration and management through tools like Microsoft Intune. Enables device-based Conditional Access policies that restrict access to known devices.

:::image type="content" source="../media/directory-services-option-entra-capabilities-hub.png" alt-text="Diagram showing Microsoft Entra ID at the center with spokes connecting to Authentication, Single Sign-On, App Management, and Device Management capabilities.":::

## Can I connect my on-premises AD with Microsoft Entra ID?

Without a connection, an on-premises Active Directory deployment and a cloud Microsoft Entra ID deployment require you to maintain two separate identity sets. Microsoft Entra Connect bridges that gap.

Microsoft Entra Connect synchronizes user identities between on-premises Active Directory and Microsoft Entra ID. Because changes flow between both systems, users get a consistent experience — including SSO, multifactor authentication, and self-service password reset — whether they're accessing on-premises or cloud resources.

## What is Microsoft Entra Domain Services?

Microsoft Entra Domain Services provides managed domain services — domain join, group policy, LDAP, and Kerberos/NTLM authentication — without requiring you to deploy or maintain domain controllers in the cloud.

This is especially useful for legacy applications that can't use modern authentication. You can lift and shift those applications from on-premises into a managed domain without managing an AD DS environment in the cloud.

Because Microsoft Entra Domain Services integrates with your existing Microsoft Entra tenant, users can sign in to the managed domain with their existing credentials. Existing groups and user accounts also carry over, providing a smoother migration path.

### How does Microsoft Entra Domain Services work?

When you create a Microsoft Entra Domain Services managed domain, you define a unique namespace. This namespace is the domain name. Two Windows Server domain controllers are then deployed into your selected Azure region. This deployment of DCs is known as a replica set.

You don't need to manage, configure, or update these DCs. The Azure platform handles the DCs as part of the managed domain, including backups and encryption at rest using Azure Disk Encryption.

### Is information synchronized?

A managed domain is configured to perform a one-way synchronization from Microsoft Entra ID to Microsoft Entra Domain Services. You can create resources directly in the managed domain, but they aren't synchronized back to Microsoft Entra ID. In a hybrid environment with an on-premises AD DS environment, Microsoft Entra Connect synchronizes identity information with Microsoft Entra ID, which is then synchronized to the managed domain.

:::image type="content" source="../media/directory-services-option-sync-architecture.png" alt-text="Diagram showing the identity sync flow from on-premises Active Directory through Microsoft Entra Connect to Microsoft Entra ID and Domain Services.":::


Applications, services, and VMs in Azure that connect to the managed domain can then use common Microsoft Entra Domain Services features such as domain join, group policy, LDAP, and Kerberos/NTLM authentication.

