Microsoft Entra ID serves as the foundational identity platform for organizations operating across hybrid and multicloud environments. Designing a Microsoft Entra ID solution for these scenarios requires decisions about directory synchronization, authentication methods, multicloud federation, and identity governance. This unit covers the key architectural choices for extending Microsoft Entra ID across on-premises Active Directory, Azure, AWS, and GCP environments.

## Hybrid identity architecture

When your organization maintains on-premises Active Directory alongside cloud resources, you need directory synchronization to create a unified identity experience. Microsoft provides two primary synchronization tools.

### Microsoft Entra Cloud Sync

Microsoft Entra Cloud Sync is a lightweight, cloud-managed provisioning service that synchronizes users, groups, and contacts from on-premises Active Directory to Microsoft Entra ID. It uses a provisioning agent that acts as a bridge between AD and the cloud.

Design with Cloud Sync when you need:

- **Multi-forest support**, including disconnected forests from mergers and acquisitions where AD forests are isolated from each other.
- **High availability** through multiple active provisioning agents, without the complexity of staging servers.
- **Cloud-managed configuration** that eliminates the need to maintain synchronization rules on-premises.
- **On-demand provisioning** to test synchronization for individual users before full deployment.

Cloud Sync supports password hash synchronization, group writeback, and synchronization of up to 150,000 objects per AD domain.

### Microsoft Entra Connect Sync

Microsoft Entra Connect Sync is the on-premises synchronization application for scenarios that require capabilities beyond what Cloud Sync currently offers.

Choose Connect Sync when you need:

- **Pass-through authentication** that validates passwords against on-premises AD without storing password hashes in the cloud.
- **Device synchronization** for Microsoft Entra hybrid join or Windows Hello for Business scenarios.
- **Microsoft Entra Domain Services integration**, which requires password hash synchronization through Connect Sync.
- **Large-scale environments** with more than 150,000 objects per domain.
- **Advanced attribute flow customizations** or filtering based on attribute values.

> [!NOTE]
> Microsoft Entra Cloud Sync is the strategic direction for hybrid identity synchronization. Microsoft is replacing Connect Sync with Cloud Sync as it reaches full functional parity. Evaluate Cloud Sync first for new deployments.

## Choose an authentication method

Your authentication method determines where password validation occurs and affects security, resiliency, and user experience.

| Method | Where passwords are validated | Key considerations |
|--------|-------------------------------|-------------------|
| **Password hash synchronization (PHS)** | Microsoft Entra ID | Simplest deployment; enables leaked credential detection through Microsoft Entra ID Protection; provides cloud resiliency if on-premises infrastructure is unavailable |
| **Pass-through authentication (PTA)** | On-premises AD | Passwords never leave on-premises; enforces on-premises password policies in real time; requires on-premises agents to be available |
| **Federation (AD FS or third-party)** | On-premises federation server | Supports complex scenarios requiring on-premises policy evaluation; enables smart card and certificate authentication; adds infrastructure complexity |

For most organizations, **password hash synchronization** is recommended because it provides the strongest cloud security features and the highest resiliency. Consider combining PHS with pass-through authentication or federation for organizations that require on-premises password validation but want cloud-based fallback.

## Enable seamless single sign-on

Microsoft Entra seamless SSO automatically signs users in when they use corporate devices connected to the corporate network. It works with both password hash synchronization and pass-through authentication by using Kerberos tickets to silently authenticate users to Microsoft Entra ID. Seamless SSO reduces sign-in prompts for users accessing cloud resources from domain-joined devices.

## Design for multicloud identity

Organizations that use AWS, GCP, or other cloud providers alongside Azure need a strategy to extend Microsoft Entra ID as the central identity provider.

### Federate AWS with Microsoft Entra ID

Configure Microsoft Entra ID as the identity provider for AWS through AWS IAM Identity Center. This integration provides:

- **Centralized SSO** to AWS accounts and applications through Microsoft Entra ID.
- **Automated provisioning** of users and groups from Microsoft Entra ID to AWS using SCIM-based lifecycle management.
- **Conditional Access enforcement** for every AWS sign-in, requiring MFA, device compliance, and user risk evaluation before granting access.
- **Group-to-role mapping** that automatically assigns AWS IAM roles based on Microsoft Entra ID group memberships, ensuring that users receive appropriate permissions.

### Federate GCP with Microsoft Entra ID

Configure Google Cloud to trust Microsoft Entra ID as an external identity provider. Use workforce identity federation in Google Cloud to enable Microsoft Entra users to access GCP resources with their existing credentials, without creating separate Google accounts.

### Workload identity federation for multicloud

Software workloads running outside Azure, such as applications on AWS or GCP, can use **workload identity federation** to access Azure resources. This approach creates a trust relationship between the external identity provider and Microsoft Entra ID, allowing workloads to exchange their native tokens for Microsoft Entra access tokens without storing secrets.

## Microsoft Entra Domain Services

Some applications require legacy protocols like LDAP, NTLM, or Kerberos that Active Directory provides. Microsoft Entra Domain Services (DS) delivers managed domain services in Azure without deploying or managing domain controllers.

Design with Microsoft Entra Domain Services for:

- **Lift-and-shift scenarios** where legacy applications need domain join, group policy, or LDAP access in the cloud.
- **Environments that need Kerberos or NTLM** authentication but don't require direct access to domain controllers.
- **Azure-hosted workloads** that depend on AD features but where managing domain controller VMs adds unnecessary operational overhead.

Microsoft Entra Domain Services automatically synchronizes users and groups from Microsoft Entra ID, providing a managed directory that applications can join and authenticate against.

> [!IMPORTANT]
> Microsoft Entra Cloud Sync isn't supported with Domain Services. If your environment includes on-premises users that need to authenticate against the managed domain, you must synchronize them using Microsoft Entra Connect Sync with password hash synchronization enabled.

## Identity governance for hybrid and multicloud

Effective governance ensures that the right identities have appropriate access across all environments.

### Access reviews

Use Microsoft Entra access reviews to periodically verify that users still need access to applications, groups, and roles. Access reviews help identify stale permissions across both cloud and synced on-premises identities.

### Entitlement management

Microsoft Entra entitlement management automates access request workflows, approvals, and expiration for access packages. Use it to govern access to groups, applications, and SharePoint sites across hybrid environments, particularly for cross-organizational collaboration scenarios.

### Privileged Identity Management (PIM)

Implement PIM for just-in-time activation of privileged roles in Microsoft Entra ID and Azure resources. PIM reduces the attack surface by eliminating standing administrator access and requiring justification and approval for role activation.

### Cross-cloud security monitoring

Integrate Microsoft Entra sign-in and audit logs with Microsoft Sentinel for centralized security monitoring across all environments. Use Microsoft Defender for Cloud to monitor identity configurations and detect identity-based threats across Azure, AWS, and GCP.

## Design principles for Microsoft Entra ID in hybrid and multicloud

Apply these principles when designing your Microsoft Entra ID solution:

- **Consolidate on Microsoft Entra ID** as the primary identity provider to simplify governance and enable consistent Conditional Access policies across all environments.
- **Evaluate Cloud Sync first** for new hybrid deployments and plan migration from Connect Sync for existing environments.
- **Choose PHS as the default authentication method** unless regulatory or organizational requirements mandate on-premises password validation.
- **Extend Conditional Access to all clouds** by federating AWS, GCP, and other providers with Microsoft Entra ID.
- **Implement identity governance** with access reviews, entitlement management, and PIM to maintain least privilege across all environments.
