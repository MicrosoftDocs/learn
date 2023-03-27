This unit summarized design recommendations related to identity and access management in a cloud environment, based on the [Azure identity and access management design area of the Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access). For more detailed discussion of all relevant design discussions, see the following articles:

- [Azure Active Directory and Hybrid Identity](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity)
- [Platform access](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access)
- [Prerequisites for a landing zone](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-landing-zones)

## Azure AD, Azure AD DS, and AD DS on Windows Server

When evaluating which type of Active Directory solution to adopt, understand the capabilities and differences of Azure AD, Azure AD Domain Services (Azure AD DS), and AD DS on Windows Server.

### Design recommendations

- Use centralized and delegated responsibilities based on role and security requirements to manage resources inside the landing zone. For more information, see Establish operational management practices in the cloud.
- The following types of privileged operations require special permissions. Consider which users will be handling such requests, and how to adequately secure and monitor their accounts.
    - Creating service principal objects.
    - Registering applications in Azure AD.
    - Procuring and handling certificates or wildcard certificates.
    - To access applications that use on-premises authentication remotely through Azure AD, use Azure AD Application Proxy.
- Evaluate the compatibility of workloads for Azure AD DS and for AD DS on Windows Server.
- Make sure to design your network so resources that require AD DS on Windows Server for local authentication and management can access their domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.
- When you deploy Azure AD DS or integrate on-premises environments into Azure, use locations with Availability Zones for increased availability.
- Deploy Azure AD DS within the primary region, because you can only project this service into one subscription. You can expand Azure AD DS to further regions with replica sets.
- Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft. For more information, see Managed identities for Azure resources.

## Azure and on-premises hybrid identity - Design recommendations

For hosting infrastructure as a service (IaaS) hybrid identity solutions, evaluate the following recommendations:

- For applications that are hosted partly on-premises and partly in Azure, verify which integration makes sense based on your scenario. For more information, see Deploy AD DS in an Azure virtual network.
- If you have AD FS, move to the cloud to centralize identity and reduce operational effort. If AD FS is still part of your identity solution, install and use Azure AD Connect.

## Design recommendations for platform access

A centralized identity uses a single location in the cloud and the integration of the Active Directory Service, control access, authentication, and applications. This approach provides better management from the IT team. For centralized Directory services, the best practice is to have only one Azure AD tenant.

When you grant access to resources, use Azure AD-only groups for Azure control-plane resources and Azure AD Privileged Identity Management. Add on-premises groups to the Azure AD-only group if a group management system is already in place. Note that Azure AD-only is also known as cloud only.

By using Azure AD-only groups, you can add both users and groups that are synchronized from on-premises by using Azure AD Connect. You can also add Azure AD-only users and groups to a single Azure AD-only group, including guest users.

Groups that are synchronized from on-premises can only be managed and updated from the identity source of truth, which is the on-premises Active Directory. These groups can only contain members from the same identity source, which doesn't provide flexibility the way that Azure AD-only groups do.

Integrate Azure AD logs with the platform-central Log Analytics workspace. This approach allows for a single source of truth around log and monitoring data in Azure. This source gives organizations cloud-native options to meet requirements for log collection and retention.

Custom user policies can enforce any data sovereignty requirements for the organization.

If identity protection is used as part your identity solution, make sure you exclude the break-glass admin account. For more information, see Manage emergency access accounts in Azure AD.

## Design considerations for workload access

For workflow access design, answer the following questions:

- Based on your cloud operating model, which teams require access to workloads within the landing zone?
- What roles or functions do the teams with access carry out?
- What is the minimum level of privilege the teams need to carry out their responsibilities?

## Design recommendations - Azure identity and access for landing zones

Deploy Azure AD Conditional Access policies for users with rights to Azure environments. Conditional Access provides another mechanism to help protect a controlled Azure environment from unauthorized access. If you use authentication outside of Azure AD, see Custom controls (preview) for information about limitations.

Enforce multifactor authentication (MFA) for users with rights to the Azure environments. Many compliance frameworks require multifactor authentication enforcement. Multifactor authentication greatly lowers the risk of credential theft and unauthorized access.

Consider using service principals for non-interactive resource sign-ins, so multifactor authentication and token refreshes won't affect operations.

Use Azure AD managed identities for Azure resources to avoid credential-based authentication. Many security breaches of public cloud resources originate with credential theft embedded in code or other text. Enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

Use Microsoft Defender for Cloud for just-in-time access to all infrastructure as a service (IaaS) resources. Defender for Cloud lets you enable network-level protection for ephemeral user access to IaaS virtual machines.

## RBAC recommendations

Use Azure RBAC to manage data plane access to resources, if possible. Examples of data plane endpoints are Azure Key Vault, a storage account, or an SQL Database.

Don't add users directly to Azure resource scopes. Direct user assignments circumvent centralized management, making it more difficult to prevent unauthorized access to restricted data. Instead, add users to defined roles, and assign the roles to resource scopes.

Use Azure AD built-in roles to manage the following identity settings:

| Role | Usage | Note
|---|---|---|
| Global Admin | | Don't assign more than five people to this role.
| Hybrid Environment | Hybrid Identity Administrator | |
| Authentication | Security Administrator | |
| Enterprise Application or Application Proxy | Application Administrator | No consent global admin.|

If the Azure built-in roles don't meet your organization's specific needs, you can create your own custom roles. Consider the following key role definitions when you create custom roles within the Azure AD tenant. The wildcard * under Actions means the principal assigned to this role can do all actions. The actions under NotActions are subtracted from Actions.