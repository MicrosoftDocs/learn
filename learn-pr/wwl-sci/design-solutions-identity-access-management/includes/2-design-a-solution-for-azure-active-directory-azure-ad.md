A critical design decision for enterprise organizations adopting Azure is whether to extend current on-premises identity domains into Azure or to create new identity domains.

Most Azure environments use Azure Active Directory (Azure AD) for Azure fabric authentication. On-premises environments use Active Directory Domain Services (AD DS) local host authentication and group policy management.

<!--[](https://learn.microsoft.com//azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity#azure-ad-azure-ad-ds-and-ad-ds-on-windows-server)-->

## Azure AD, Azure AD DS, and AD DS on Windows Server

When evaluating which type of Active Directory solution to adopt, understand the capabilities and differences of Azure AD, Azure AD Domain Services (Azure AD DS), and AD DS on Windows Server.

<!--[](https://learn.microsoft.com//azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity#design-considerations)-->

### Design considerations

-   Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone. For more information, see [Centralize management operations](https://learn.microsoft.com//azure/cloud-adoption-framework/manage/centralize-operations).
    
-   Applications that rely on domain services and use older protocols might be able to use [Azure AD Domain Services (Azure AD DS)](https://learn.microsoft.com//azure/active-directory-domain-services).
    
-   Evaluate your application needs by understanding and documenting the authentication provider that each application uses. Use the reviews to help plan the type of Active Directory your organization should use. For more information, see [Compare Active Directory to Azure Active Directory](https://learn.microsoft.com/azure/active-directory/fundamentals/active-directory-compare-azure-ad-to-ad) and [Identity decision guide](https://learn.microsoft.com//azure/cloud-adoption-framework/decision-guides/identity/).
    
-   Evaluate scenarios that involve setting up external users, customers, or partners to secure access to resources. Determine whether these scenarios involve [Azure AD B2B](https://learn.microsoft.com/azure/active-directory/external-identities/what-is-b2b) or [Azure AD B2C](https://learn.microsoft.com/azure/active-directory-b2c/overview) configurations. For more information, see [Azure AD External Identities](https://learn.microsoft.com/azure/active-directory/external-identities/external-identities-overview).
    
-   If you use [Azure AD Application Proxy](https://learn.microsoft.com/azure/active-directory/app-proxy/application-proxy), consider not using intranet access, because it could add latency to the user experience. For more information about Azure AD Application Proxy, see [Azure AD Application Proxy planning](https://learn.microsoft.com/azure/active-directory/app-proxy/application-proxy-deployment-plan#plan-your-implementation) and [Azure AD Application Proxy security considerations](https://learn.microsoft.com/azure/active-directory/app-proxy/application-proxy-security).
    

<!--[](https://learn.microsoft.com//azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity#design-recommendations)-->

### Design recommendations

-   Use centralized and delegated responsibilities based on role and security requirements to manage resources inside the landing zone. For more information, see [Establish operational management practices in the cloud](https://learn.microsoft.com//azure/cloud-adoption-framework/manage/best-practices).
    
-   The following types of privileged operations require special permissions. Consider which users will be handling such requests, and how to adequately secure and monitor their accounts.
    
    -   Creating service principal objects.
    -   Registering applications in Azure AD.
    -   Procuring and handling certificates or wildcard certificates.
-   To access applications that use on-premises authentication remotely through Azure AD, use [Azure AD Application Proxy](https://learn.microsoft.com//azure/active-directory/app-proxy/application-proxy).
    
-   Evaluate the compatibility of workloads for Azure AD DS and for AD DS on Windows Server.
    
-   Make sure to design your network so resources that require AD DS on Windows Server for local authentication and management can access their domain controllers. For AD DS on Windows Server, consider shared service environments that offer local authentication and host management in a larger enterprise-wide network context.
    
-   When you deploy Azure AD DS or integrate on-premises environments into Azure, use locations with [Availability Zones](https://learn.microsoft.com//azure/availability-zones/az-overview) for increased availability.
    
-   Deploy Azure AD DS within the primary region, because you can only project this service into one subscription. You can expand Azure AD DS to further regions with [replica sets](https://learn.microsoft.com//azure/active-directory-domain-services/concepts-replica-sets).
    
-   Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft. For more information, see [Managed identities for Azure resources](https://learn.microsoft.com//azure/active-directory/managed-identities-azure-resources/overview).
    

<!--[](https://learn.microsoft.com//azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity#azure-and-on-premises-hybrid-identity)-->

## Azure and on-premises hybrid identity

For hosting infrastructure as a service (IaaS) hybrid identity solutions, evaluate the following considerations and recommendations:

<!--[](https://learn.microsoft.com//azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-active-directory-hybrid-identity#design-considerations-1)-->

### Design considerations

-   For options to meet organizational requirements when integrating on-premises Active Directory with Azure, see [Integrate on-premises AD with Azure](https://learn.microsoft.com//azure/architecture/reference-architectures/identity).
    
-   Authentication can occur in the cloud and on-premises, or on-premises only. As part of your identity planning, explore the authentication methods Azure AD offers. For more information, see [Authentication for Azure AD hybrid identity solutions](https://learn.microsoft.com//azure/active-directory/hybrid/choose-ad-authn?toc=/azure/architecture/toc.json&bc=/azure/architecture/bread/toc.json).
    
-   If you have Active Directory Federation Services (AD FS) federation with Azure AD, you can use password hash synchronization as a backup. AD FS doesn't support seamless single sign-on (SSO).
    
-   Determine the right synchronization tool for your cloud identity. For more information, see [Determine directory synchronization requirements](https://learn.microsoft.com//azure/active-directory/hybrid/plan-hybrid-identity-design-considerations-directory-sync-requirements).
    
### Design recommendations

-   For applications that are hosted partly on-premises and partly in Azure, verify which integration makes sense based on your scenario. For more information, see [Deploy AD DS in an Azure virtual network](https://learn.microsoft.com//azure/architecture/reference-architectures/identity/adds-extend-domain).
    
-   If you have AD FS, move to the cloud to centralize identity and reduce operational effort. If AD FS is still part of your identity solution, install and use [Azure AD Connect](https://learn.microsoft.com//azure/active-directory/hybrid/whatis-azure-ad-connect).

## Identity for Azure platform resources

Azure identity services, including Azure Active Directory (Azure AD), manage access to resources in the Azure platform. This article describes design considerations for platform access and workflow access. We offer design recommendations for platform access.

<!--[](https://learn.microsoft.com//azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access-platform-access#design-consideration-for-platform-access) -->

### Design consideration for platform access

You need to decide which resources are manged centrally and which are federated.

Shared resources or any aspect of the environment that implements or enforces a security boundary, such as the network, must be managed centrally. This requirement is part of many regulatory frameworks. It's a standard practice for any organization that grants or denies access to confidential or critical business resources.

Managing application resources that don't violate security boundaries can be delegated to application teams. Consider delegating other aspects that are required to maintain security and compliance as well. Letting users provision resources within a securely managed environment lets organizations take advantage of the agile nature of the cloud and prevent violation of any critical security or governance boundary.

Depending on the definition of the centralized or federated resource ownership, custom roles might differ. The custom roles for the centralized resource ownership are limited. Those roles might need extra rights depending on the responsibility model. For example, in some organizations a NetOps role might only need to manage and configure global connectivity. In organizations that need a more centralized approach, you can enrich the NetOps role with more allowed actions. That role might allow creating peering between the hub and the spokes.

As part of the guidelines for best practices enabling multifactor authentication, you can use a tool called [Azure Active Directory (Azure AD) Identity Protection](https://learn.microsoft.com//azure/active-directory/identity-protection/). This tool can require users to enroll in multifactor authentication from day one with Conditional Access policy. Additionally, the multifactor authentication is used as part of the self-remediation methods for any flagged risky event. For more information, see [License requirements](https://learn.microsoft.com//azure/active-directory/identity-protection/overview-identity-protection).

### Design recommendations for platform access

A _centralized identity_ uses a single location in the cloud and the integration of the Active Directory Service, control access, authentication, and applications. This approach provides better management from the IT team. For centralized Directory services, the best practice is to have only one Azure AD tenant.

When you grant access to resources, use Azure AD-only groups for Azure control-plane resources and Azure AD Privileged Identity Management. Add on-premises groups to the Azure AD-only group if a group management system is already in place. Note that _Azure AD-only_ is also known as _cloud only_.

By using Azure AD-only groups, you can add both users and groups that are synchronized from on-premises by using Azure AD Connect. You can also add Azure AD-only users and groups to a single Azure AD-only group, including guest users.

Groups that are synchronized from on-premises can only be managed and updated from the identity source of truth, which is the on-premises Active Directory. These groups can only contain members from the same identity source, which doesn't provide flexibility the way that Azure AD-only groups do.

Integrate Azure AD logs with the platform-central [Log Analytics workspace](https://learn.microsoft.com//azure/azure-monitor/logs/data-platform-logs). This approach allows for a single source of truth around log and monitoring data in Azure. This source gives organizations cloud-native options to meet requirements for log collection and retention.

Custom user policies can enforce any data sovereignty requirements for the organization.

If identity protection is used as part your identity solution, make sure you exclude the _break-glass_ admin account. For more information, see [Manage emergency access accounts in Azure AD](https://learn.microsoft.com//azure/active-directory/roles/security-emergency-access).

### Design considerations for workload access

For workflow access design, answer the following questions:

-   Based on your cloud operating model, which teams require access to workloads within the landing zone?
-   What roles or functions do the teams with access carry out?
-   What is the minimum level of privilege the teams need to carry out their responsibilities?