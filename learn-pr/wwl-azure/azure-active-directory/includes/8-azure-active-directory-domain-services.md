Microsoft Entra Domain Services provides managed domain services such as domain join, group policy, lightweight directory access protocol (LDAP), and Kerberos/New Technology LAN Manager (NTLM) authentication. You use these domain services without the need to deploy, manage, and patch domain controllers (DCs) in the cloud.

A Microsoft Entra Domain Services managed domain lets you run legacy applications in the cloud that can't use modern authentication methods or where you don't want directory lookups to always go back to an on-premises AD DS environment. You can lift and shift those legacy applications from your on-premises environment into a managed domain without needing to manage the AD DS environment in the cloud.

Microsoft Entra Domain Services integrates with your existing Microsoft Entra tenant. This integration lets users sign in to services and applications connected to the managed domain using their existing credentials. You can also use existing groups and user accounts to secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure.

<a name='how-does-azure-ad-ds-work'></a>

## How does Microsoft Entra Domain Services work?

When you create a Microsoft Entra Domain Services managed domain, you define a unique namespace. This namespace is the domain name, such as *aaddscontoso.com*. Two Windows Server domain controllers (DCs) are then deployed into your selected Azure region. This deployment of DCs is known as a replica set.

You don't need to manage, configure, or update these DCs. The Azure platform handles the DCs as part of the managed domain, including backups and encryption at rest using Azure Disk Encryption.

A managed domain is configured to perform a one-way synchronization from Microsoft Entra ID to provide access to a central set of users, groups, and credentials. You can create resources directly in the managed domain, but they aren't synchronized back to Microsoft Entra ID. Applications, services, and VMs in Azure that connect to the managed domain can then use common AD DS features such as domain join, group policy, LDAP, and Kerberos/NTLM authentication.

In a hybrid environment with an on-premises AD DS environment, Microsoft Entra Connect synchronizes identity information with Microsoft Entra ID, which is then synchronized to the managed domain.

:::image type="content" source="../media/azure-active-directory-synchronization-b5f2169a.png" alt-text="Screenhot showing how Microsoft Entra Domain Services works.":::


Microsoft Entra Domain Services replicates identity information from Microsoft Entra ID, so it works with Microsoft Entra tenants that are cloud-only or synchronized with an on-premises AD DS environment. The same set of Microsoft Entra Domain Services features exists for both environments.

 -  If you have an existing on-premises AD DS environment, you can synchronize user account information to provide a consistent identity for users.
 -  For cloud-only environments, you don't need a traditional on-premises AD DS environment to use the centralized identity services of Microsoft Entra Domain Services.

You can expand a managed domain to have more than one replica set per Microsoft Entra tenant. Replica sets can be added to any peered virtual network in any Azure region that supports Microsoft Entra Domain Services. Additional replica sets in different Azure regions provide geographical disaster recovery for legacy applications if an Azure region goes offline.

<a name='azure-ad-ds-features-and-benefits'></a>

## Microsoft Entra Domain Services features and benefits

To provide identity services to applications and VMs in the cloud, Microsoft Entra Domain Services is fully compatible with a traditional AD DS environment for operations such as domain-join, secure LDAP (LDAPS), Group Policy, DNS management, and LDAP bind and read support. LDAP write support is available for objects created in the managed domain but not resources synchronized from Microsoft Entra ID.

The following features of Microsoft Entra Domain Services simplify deployment and management operations:

 -  Simplified deployment experience: Microsoft Entra Domain Services is enabled for your Microsoft Entra tenant using a single wizard in the Azure portal.
 -  Integrated with Microsoft Entra ID: User accounts, group memberships, and credentials are automatically available from your Microsoft Entra tenant. New users, groups, or changes to attributes from your Microsoft Entra tenant or your on-premises AD DS environment are automatically synchronized to Microsoft Entra Domain Services.
     -  Accounts in external directories linked to your Microsoft Entra ID aren't available in Microsoft Entra Domain Services. Credentials aren't available for those external directories, so they can't be synchronized into a managed domain.
 -  Use your corporate credentials/passwords: Passwords for users in Microsoft Entra Domain Services are the same as in your Microsoft Entra tenant. Users can use their corporate credentials to domain-join machines, sign in interactively or over a remote desktop, and authenticate against the managed domain.
 -  NTLM and Kerberos authentication: With support for NTLM and Kerberos authentication, you can deploy applications that rely on Windows-integrated authentication.
 -  High availability: Microsoft Entra Domain Services includes multiple domain controllers, which provide high availability for your managed domain. This high availability guarantees service uptime and resilience to failures.
     -  In regions that support Azure Availability Zones, these domain controllers are distributed across zones for additional resiliency.
     -  Replica sets can also be used to provide geographical disaster recovery for legacy applications if an Azure region goes offline.

Some key aspects of a managed domain include the following:

 -  The managed domain is a stand-alone domain. It isn't an extension of an on-premises domain.
     -  If needed, you can create one-way outbound forest trusts from Microsoft Entra Domain Services to an on-premises AD DS environment.
 -  Your IT team doesn't need to manage, patch, or monitor domain controllers for this managed domain.

For hybrid environments that run AD DS on-premises, you don't need to manage AD replication to the managed domain. User accounts, group memberships, and credentials from your on-premises directory are synchronized to Microsoft Entra ID via Microsoft Entra Connect. These user accounts, group memberships, and credentials are automatically available within the managed domain.

> [!IMPORTANT]
> Microsoft Entra Domain Services integrates with Microsoft Entra ID, which can synchronize with an on-premises AD DS environment. This ability extends central identity use cases to traditional web applications that run in Azure as part of a lift-and-shift strategy.
