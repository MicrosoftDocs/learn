
In any environment, whether on-premises, hybrid, or cloud-only, IT needs to control which administrators, users, and groups have access to resources. Identity and access management (IAM) services enable you to manage access control in the cloud.

Several options are available for managing identity in a cloud environment. These options vary in cost and complexity. A key factor in structuring your cloud-based identity services is the level of integration required with your existing on-premises identity infrastructure.

:::image type="content" source="../media/hybrid-cloud-entra-access-considerations.png" lightbox="../media/hybrid-cloud-entra-access-considerations.png" alt-text="Diagram showing identity options relative to the level of integration required with existing on-premises identity infrastructure.":::

Microsoft Entra ID provides a cloud, baseline level of access control and identity management for Azure resources, which is standalone and for which there's no integration with an on-premises Active Directory. If your organization's on-premises Active Directory infrastructure has a complex forest structure or customized organizational units (OUs), your cloud-based workloads might require directory synchronization with Microsoft Entra ID for a consistent set of identities, groups, and roles between your on-premises and cloud environments. Additionally, support for applications that depend on legacy authentication mechanisms might require the deployment of Active Directory Domain Services (AD DS) in the cloud.

Cloud-based identity management is an iterative process. You could start with a cloud-native solution with a small set of users and corresponding roles for an initial deployment. As your migration matures, you might need to integrate your identity solution using directory synchronization or add domains services as part of your cloud deployments. Revisit your identity strategy in every iteration of your migration process.

## Determine identity integration requirements

As stated at the beginning of this unit, a key factor in structuring your cloud-based identity services is the level of integration required with your existing on-premises identity infrastructure.

| Question | Cloud baseline | Directory synchronization | Cloud-hosted domain services | Active Directory Federation Services |
|------|------|------|------|------|
| Do you currently lack an on-premises directory service? | Yes | No | No | No |
| Do your workloads need to use a common set of users and groups between the cloud and on-premises environment? | No | Yes | No | No |
| Do your workloads depend on legacy authentication mechanisms, such as Kerberos or NTLM? | No | No | Yes | Yes |
| Do you require single sign-on across multiple identity providers? | No | No | No | Yes |

As part of planning your migration to Azure, you'll need to determine how best to integrate your existing identity management and cloud identity services. The following are common integration scenarios.

### Cloud baseline

Microsoft Entra ID is the native identity and access management (IAM) system for granting users and groups access to management features on the Azure platform. If your organization lacks a significant on-premises identity solution, and you plan to migrate workloads to be compatible with cloud-based authentication mechanisms, you should begin developing your identity infrastructure using Microsoft Entra ID as a base.

Cloud baseline assumptions: Using a purely cloud-native identity infrastructure assumes the following:

- Your cloud-based resources will not have dependencies on on-premises directory services or Active Directory servers, or workloads can be modified to remove those dependencies.
- The application or service workloads being migrated either support authentication mechanisms compatible with Microsoft Entra ID or can be modified easily to support them. Microsoft Entra ID relies on internet-ready authentication mechanisms such as SAML, OAuth, and OpenID Connect. Existing workloads that depend on legacy authentication methods using protocols such as Kerberos or NTLM might need to be refactored before migrating to the cloud using the cloud baseline pattern.

### Directory synchronization

For organizations with existing on-premises Active Directory infrastructure, directory synchronization is often the best solution for preserving existing user and access management while providing the required IAM capabilities for managing cloud resources. This process continuously replicates directory information between Microsoft Entra ID and on-premises directory services, allowing common credentials for users and a consistent identity, role, and permission system across your entire organization.

Directory synchronization assumptions: Using a synchronized identity solution assumes the following:

- You need to maintain a common set of user accounts and groups across your cloud and on-premises IT infrastructure.
- Your on-premises identity services support replication with Microsoft Entra ID.

One of the solutions Microsoft offers to support directory synchronization, is Microsoft Entra Sync.

**Microsoft Entra Connect Sync** is designed to meet and accomplish your hybrid identity goals for synchronization of users, groups, and contacts to Microsoft Entra ID. It accomplishes this by using the Microsoft Entra cloud provisioning agent.  

:::image type="content" source="../media/microsoft-entra-connect-sync-titled.png" lightbox="../media/microsoft-entra-connect-sync-titled.png" alt-text="Diagram showing on-premises Active Directory and Microsoft Entra, with Entra Connect Sync sitting in th middle and serving as a bridge between the two.":::

Microsoft Entra Connect Sync provides the following benefits:

- Support for synchronizing to a Microsoft Entra tenant from a multi-forest disconnected Active Directory forest environment: The common scenarios include merger and acquisition. In these cases, the acquired company's AD forests are isolated from the parent company's AD forests. Another scenario involves companies that historically had multiple AD forests.
- Simplified installation with light-weight provisioning agents: The agents act as a bridge from AD to Microsoft Entra ID, with all the sync configuration managed in the cloud.
- Multiple provisioning agents can be used to simplify high availability deployments. They're critical for organizations relying upon password hash synchronization from AD to Microsoft Entra ID.
- Support for large groups with up to 50,000 members.

See [Microsoft Entra Cloud Sync supported topologies and scenarios](/entra/identity/hybrid/cloud-sync/plan-cloud-sync-topologies) for more information.

#### Cloud-hosted domain services

If you have workloads that depend on claims-based authentication using legacy protocols such as Kerberos or NTLM, and those workloads cannot be refactored to accept modern authentication protocols such as SAML or OAuth and OpenID Connect, you might need to migrate some of your domain services to the cloud as part of your cloud deployment.

This pattern involves deploying virtual machines running Active Directory to your cloud-based virtual networks to provide Active Directory Domain Services (AD DS) for resources in the cloud. Any existing applications and services migrating to your cloud network should be able to use these cloud-hosted directory servers with minor modifications.

It's likely that your existing directories and domain services will continue to be used in your on-premises environment. In this scenario, you should also use directory synchronization to provide a common set of users and roles in both the cloud and on-premises environments.

Cloud-hosted domain services assumptions: Performing a directory migration assumes the following:

- Your workloads depend on claims-based authentication using protocols like Kerberos or NTLM.
- Your workload virtual machines need to be domain-joined for management or application of Active Directory group policy purposes.

There are two ways to provide Active Directory Domain Services in the cloud:
- A self-managed domain that you create and configure using traditional resources such as virtual machines (VMs), Windows Server guest OS, and Active Directory Domain Services (AD DS). You then continue to administer these resources. 
- A managed domain that you create using Microsoft Entra Domain Services. Microsoft creates and manages the required resources. This simplifies deployment, relative to the self-managed, so would sit to the left of the cloud-hosted domain services shown in the diagram shown

**Microsoft Entra Domain Services**. Microsoft Entra Domain Services provides managed domain services such as domain join, group policy, lightweight directory access protocol (LDAP), and Kerberos/NTLM authentication. You use these domain services without the need to deploy, manage, and patch domain controllers (DCs) in the cloud.

Domain Services integrates with your existing Microsoft Entra tenant. This integration lets users sign in to services and applications connected to the managed domain using their existing credentials. You can also use existing groups and user accounts to secure access to resources. These features provide a smoother lift-and-shift of on-premises resources to Azure.

### Active Directory Federation Services

Identity federation establishes trust relationships across multiple identity management systems to allow common authentication and authorization capabilities. You can then support single sign-on capabilities across multiple domains within your organization or identity systems managed by your customers or business partners.

Microsoft Entra ID supports federation of on-premises Active Directory domains using [Active Directory Federation Services (AD FS)](/entra/identity/hybrid/connect/how-to-connect-fed-whatis).

