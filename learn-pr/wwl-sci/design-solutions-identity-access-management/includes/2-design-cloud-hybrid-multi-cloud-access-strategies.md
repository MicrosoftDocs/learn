This unit summarized design recommendations related to identity and access management in a cloud environment, based on the [Azure identity and access management design area of the Cloud Adoption Framework](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). For more detailed discussion of all relevant design discussions, see the following articles:

- [Microsoft Entra ID and Hybrid Identity](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity)
- [Platform access](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access)
- [Prerequisites for a landing zone](/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones)

## Comparing identity solutions

<a name='active-directory-vs-azure-ad-user-management'></a>

### Active Directory vs Microsoft Entra ID: user management

|Concept|Active Directory (AD)|Microsoft Entra ID |
|:-|:-|:-|
|**Users**|||
|Provisioning: users | Organizations create internal users manually or use an in-house or automated provisioning system, such as the Microsoft Identity Manager, to integrate with an HR system.|Existing AD organizations use Microsoft Entra Connect to sync identities to the cloud.</br> Microsoft Entra ID adds support to automatically create users from cloud HR systems. </br>Microsoft Entra ID can provision identities in SCIM enabled SaaS apps to automatically provide apps with the necessary details to allow access for users. |
|Provisioning: external identities| Organizations create external users manually as regular users in a dedicated external AD forest, resulting in administration overhead to manage the lifecycle of external identities (guest users)| Microsoft Entra ID provides a special class of identity to support external identities. Microsoft Entra B2B will manage the link to the external user identity to make sure they are valid. |
| Entitlement management and groups| Administrators make users members of groups. App and resource owners then give groups access to apps or resources.| Groups are also available in Microsoft Entra ID and administrators can also use groups to grant permissions to resources. In Microsoft Entra ID, administrators can assign membership to groups manually or use a query to dynamically include users to a group. </br> Administrators can use Entitlement management in Microsoft Entra ID to give users access to a collection of apps and resources using workflows and, if necessary, time-based criteria. |
| Admin management|Organizations will use a combination of domains, organizational units, and groups in AD to delegate administrative rights to manage the directory and resources it controls.| Microsoft Entra ID provides built-in roles with its Microsoft Entra role-based access control (Microsoft Entra RBAC) system, with limited support for creating custom roles to delegate privileged access to the identity system, the apps, and resources it controls.</br>Managing  roles can be enhanced with Privileged Identity Management (PIM) to provide just-in-time, time-restricted, or workflow-based access to privileged roles. |
| Credential management| Credentials in Active Directory are based on passwords, certificate authentication, and smartcard authentication. Passwords are managed using password policies that are based on password length, expiry, and complexity.|Microsoft Entra ID uses intelligent password protection for cloud and on-premises. Protection includes smart lockout plus blocking common and custom password phrases and substitutions. </br>Microsoft Entra ID significantly boosts security through Multi-factor authentication and passwordless technologies, like FIDO2. </br>Microsoft Entra ID reduces support costs by providing users a self-service password reset system. |

<a name='active-directory-based-services-in-azure-ad-ds-azure-ad-and-azure-ad-ds'></a>

### Active Directory-based services in Azure: AD DS, Microsoft Entra ID and Microsoft Entra Domain Services

To provide applications, services, or devices access to a central identity, there are three common ways to use Active Directory-based services in Azure. This choice in identity solutions gives you the flexibility to use the most appropriate directory for your organization's needs. For example, if you mostly manage cloud-only users that run mobile devices, it may not make sense to build and run your own Active Directory Domain Services (AD DS) identity solution. Instead, you could just use Microsoft Entra ID.

Although the three Active Directory-based identity solutions share a common name and technology, they're designed to provide services that meet different customer demands. At high level, these identity solutions and feature sets are:

* **Active Directory Domain Services (AD DS)** - Enterprise-ready lightweight directory access protocol (LDAP) server that provides key features such as identity and authentication, computer object management, group policy, and trusts.
    * AD DS is a central component in many organizations with an on-premises IT environment, and provides core user account authentication and computer management features.
* **Microsoft Entra ID** - Cloud-based identity and mobile device management that provides user account and authentication services for resources such as Microsoft 365, the Azure portal, or SaaS applications.
    * Microsoft Entra ID can be synchronized with an on-premises AD DS environment to provide a single identity to users that works natively in the cloud.
* **Microsoft Entra Domain Services (Microsoft Entra Domain Services)** - Provides managed domain services with a subset of fully compatible traditional AD DS features such as domain join, group policy, LDAP, and Kerberos / NTLM authentication.
    * Microsoft Entra Domain Services integrates with Microsoft Entra ID, which itself can synchronize with an on-premises AD DS environment. This ability extends central identity use cases to traditional web applications that run in Azure as part of a lift-and-shift strategy.

For a more extensive discussion comparing these three options, see [Compare self-managed Active Directory Domain Services, Microsoft Entra ID, and managed Microsoft Entra Domain Services](/azure/active-directory-domain-services/compare-identity-solutions).

## Cross cutting Design recommendations

- Use centralized and delegated responsibilities based on role and security requirements to manage resources inside the landing zone. 
- The following types of privileged operations require special permissions. Consider which users will be handling such requests, and how to adequately secure and monitor their accounts.
    - Creating service principal objects.
    - Registering applications in Microsoft Entra ID.
    - Procuring and handling certificates or wildcard certificates.
    - To access applications that use on-premises authentication remotely through Microsoft Entra ID, use Microsoft Entra application proxy.
- Evaluate the compatibility of workloads for Microsoft Entra Domain Services and for AD DS on Windows Server.
- Make sure to design your network so resources that require AD DS on Windows Server for local authentication and management can access their domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.
- When you deploy Microsoft Entra Domain Services or integrate on-premises environments into Azure, use locations with Availability Zones for increased availability.
- Deploy Microsoft Entra Domain Services within the primary region, because you can only project this service into one subscription. You can expand Microsoft Entra Domain Services to further regions with replica sets.
- Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft. 

## Azure and on-premises hybrid identity - Design recommendations

For hosting infrastructure as a service (IaaS) hybrid identity solutions, evaluate the following recommendations:

- For applications that are hosted partly on-premises and partly in Azure, verify which integration makes sense based on your scenario. For more information, see Deploy AD DS in an Azure virtual network.
- If you have AD FS, move to the cloud to centralize identity and reduce operational effort. If AD FS is still part of your identity solution, install and use Microsoft Entra Connect.

## Identity for Azure platform resources - design recommendations

A centralized identity uses a single location in the cloud and the integration of the Active Directory Service, control access, authentication, and applications. This approach provides better management for the IT team. For centralized Directory services, the best practice is to have only one Microsoft Entra tenant.

When you grant access to resources, use Microsoft Entra-only groups for Azure control-plane resources and Microsoft Entra Privileged Identity Management. Add on-premises groups to the Microsoft Entra-only group if a group management system is already in place. Note that Microsoft Entra-only is also known as cloud only.

By using Microsoft Entra-only groups, you can add both users and groups that are synchronized from on-premises by using Microsoft Entra Connect. You can also add Microsoft Entra-only users and groups to a single Microsoft Entra-only group, including guest users.

Groups that are synchronized from on-premises can only be managed and updated from the identity source of truth, which is the on-premises Active Directory. These groups can only contain members from the same identity source, which doesn't provide flexibility the way that Microsoft Entra-only groups do.

Integrate Microsoft Entra logs with the platform-central Log Analytics workspace. This approach allows for a single source of truth around log and monitoring data in Azure. This source gives organizations cloud-native options to meet requirements for log collection and retention.

Custom user policies can enforce any data sovereignty requirements for the organization.

If identity protection is used as part your identity solution, make sure you exclude the break-glass admin account. 

## Design recommendations - Azure identity and access for landing zones

Deploy Microsoft Entra Conditional Access policies for users with rights to Azure environments. Conditional Access provides another mechanism to help protect a controlled Azure environment from unauthorized access. 

Enforce multifactor authentication (MFA) for users with rights to the Azure environments. Many compliance frameworks require multifactor authentication enforcement. Multifactor authentication greatly lowers the risk of credential theft and unauthorized access.

Consider using service principals for non-interactive resource sign-ins, so multifactor authentication and token refreshes won't affect operations.

Use Microsoft Entra managed identities for Azure resources to avoid credential-based authentication. Many security breaches of public cloud resources originate with credential theft embedded in code or other text. Enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

Use Microsoft Defender for Cloud for just-in-time access to all infrastructure as a service (IaaS) resources. Defender for Cloud lets you enable network-level protection for ephemeral user access to IaaS virtual machines.

### Privileged Identity Management (PIM)

Use Microsoft Entra Privileged Identity Management (PIM) to establish zero-trust and least privilege access. Map your organization's roles to the minimum access levels needed. Microsoft Entra PIM can use Azure native tools, extend current tools and processes, or use both current and native tools as needed.

Use Microsoft Entra PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks, so many organizations already have an access review process in place.

Use privileged identities for automation runbooks that require elevated access permissions. Use the same tools and policies to govern automated workflows that access critical security boundaries as you use to govern users of equivalent privilege.

### RBAC recommendations

Use Azure RBAC to manage data plane access to resources, if possible. Examples of data plane endpoints are Azure Key Vault, a storage account, or an SQL Database.

Don't add users directly to Azure resource scopes. Direct user assignments circumvent centralized management, making it more difficult to prevent unauthorized access to restricted data. Instead, add users to defined roles, and assign the roles to resource scopes.

Use Microsoft Entra built-in roles to manage the following identity settings:

| Role | Usage | Note
|---|---|---|
| Global Admin | | Don't assign more than five people to this role.
| Hybrid Environment | Hybrid Identity Administrator | |
| Authentication | Security Administrator | |
| Enterprise Application or Application Proxy | Application Administrator | No consent global admin.|

If the Azure built-in roles don't meet your organization's specific needs, you can create your own custom roles. 
