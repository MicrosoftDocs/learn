Identity provides the basis for a large part of security assurance. It enables access based on identity authentication and authorization controls in cloud services to protect data and resources and to decide which requests should be permitted.

Identity and access management (IAM) is a security boundary in the public cloud. The foundation of any secure and fully compliant public cloud architecture. Azure offers a comprehensive set of services, tools, and reference architectures to help organizations build highly secure, operationally efficient environments as outlined here.

This unit examines design considerations and recommendations related to IAM in an enterprise environment.

## Plan for identity and access management

Enterprise organizations typically follow a least-privileged approach to operational access. This model should be considered for Azure through the Azure Active Directory (Azure AD) role-based access control (RBAC) and custom role definitions. It's critical to plan how to govern control-plane and data-plane access to resources in Azure. Any design for IAM and RBAC must meet regulatory, security, and operational requirements before it can be accepted.

Identity and access management is a multistep process that involves careful planning for identity integration and other security considerations, such as blocking legacy authentication and planning for modern passwords. Staging planning also involves the selection of business-to-business or business-to-consumer identity and access management. While these requirements vary, there are common design considerations and recommendations to consider for an enterprise landing zone.

:::image type="content" source="../media/3-identity-access-management.png" alt-text="Diagram that shows identity and access management." lightbox="../media/3-identity-access-management-large.png":::

When you plan for role-based access, use custom RBAC role definitions within the Azure AD tenant and consider the following key roles:

- **Azure platform owner**: Used for management group and subscription lifecycle management.

  ```json
  {
    "Name": "Azure platform owner",
    "Id": "88888888-8888-8888-8888-888888888888",
    "IsCustom": true,
    "Description": "Used for management group and subscription lifecycle management.",
    "Actions": [
      "*"
    ],
    "NotActions": [],
    "DataActions": [],
    "NotDataActions": [],
    "AssignableScopes": [
      "/"
    ]
  }
  ```

- **Network management (NetOps)**: Used for platform-wide global connectivity management of virtual networks, user data repositories, network security groups, network virtual appliances, virtual private networks, Azure ExpressRoute, and others.

  ```json
  {
    "Name": "NetOps",
    "Id": "88888888-8888-8888-8888-888888888888",
    "IsCustom": true,
    "Description": "Used for platform-wide global connectivity management of network resources.",
    "Actions": [
      "*/read",
      "Microsoft.Authorization/*/write",
      "Microsoft.Network/vpnGateways/*",
      "Microsoft.Network/expressRouteCircuits/*",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Network/vpnSites/*"
    ],
    "NotActions": [],
    "DataActions": [],
    "NotDataActions": [],
    "AssignableScopes": [
      "/"
    ]
  }
  ```

- **Security operations (SecOps)**: Security administrator role with a horizontal view across the entire Azure estate.

  ```json
  {
    "Name": "SecOps",
    "Id": "88888888-8888-8888-8888-888888888888",
    "IsCustom": true,
    "Description": "Used for platform-wide visibility of security resources.",
    "Actions": [
      "*/read",
      "*/register/action",
      "Microsoft.KeyVault/locations/deletedVaults/purge/action",
      "Microsoft.Insights/alertRules/*",
      "Microsoft.Authorization/policyDefinitions/*",
      "Microsoft.Authorization/policyAssignments/*",
      "Microsoft.Authorization/policySetDefinitions/*",
      "Microsoft.PolicyInsights/*",
      "Microsoft.Security/*"
    ],
    "NotActions": [],
    "DataActions": [],
    "NotDataActions": [],
    "AssignableScopes": [
      "/"
    ]
  }
  ```

- **Subscription owner**: A delegated role for subscription owner derived from subscription owner role.

  ```json
  {
    "Name": "Subscription owner",
    "Id": "88888888-8888-8888-8888-888888888888",
    "IsCustom": true,
    "Description": "A delegated role for subscription owner derived from subscription owner role.",
    "Actions": [
      "*"
    ],
    "NotActions": [
      "Microsoft.Authorization/*/write",
      "Microsoft.Network/vpnGateways/*",
      "Microsoft.Network/expressRouteCircuits/*",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Network/vpnSites/*"
    ],
    "DataActions": [],
    "NotDataActions": [],
    "AssignableScopes": [
      "/"
    ]
  }
  ```

- **Application owners (DevOps/AppOps)**: Contributor role granted for application/operations team.

  ```json
  {
    "Name": "Application owners",
    "Id": "88888888-8888-8888-8888-888888888888",
    "IsCustom": true,
    "Description": "Contributor role granted for application/operations team.",
    "Actions": [
      "*"
    ],
    "NotActions": [
      "Microsoft.Network/publicIPAddresses/write",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.KeyVault/locations/deletedVaults/purge/action"
    ],
    "DataActions": [],
    "NotDataActions": [],
    "AssignableScopes": [
      "/subscriptions/{applicationSubscriptionId1}",
      "/subscriptions/{applicationSubscriptionId2}",
      "/providers/Microsoft.Management/managementGroups/{applicationGroupId1}"
    ]
  }
  ```

### Design recommendations and considerations for identity and access management

There are limits around the number of custom roles and role assignments that must be considered when you lay down a framework around IAM and governance. For more information, see Azure RBAC service limits.

- There's a limit of 2,000 custom RBAC role assignments per subscription.
- There's a limit of 500 custom RBAC role assignments per management group.

Consider the differences between centralized versus federated resource ownership:

- Shared resources or any aspect of the environment that implements or enforces a security boundary, such as the network, must be managed centrally. This requirement is part of many regulatory frameworks. It's standard practice for any organization that grants or denies access to confidential or critical business resources.
- Managing application resources that don't violate security boundaries or other aspects required to maintain security and compliance can be delegated to application teams. Allowing users to provision resources within a securely managed environment allows organizations to take advantage of the agile nature of the cloud while preventing the violation of any critical security or governance boundary.

We recommend the use of Azure AD RBAC to manage data-plane access to resources, where possible. Examples are Azure Key Vault, a storage account, or a SQL database.

Deploy Azure AD conditional-access policies for any user with rights to Azure environments. Doing so provides another mechanism to help protect a controlled Azure environment from unauthorized access. Enforce multifactor authentication for any user with rights to the Azure environments. Multifactor authentication enforcement is a requirement of many compliance frameworks. It greatly lowers the risk of credential theft and unauthorized access.

Use Azure AD Privileged Identity Management (PIM) to establish zero standing access and least privilege. Map your organization's roles to the minimum level of access needed. Azure AD PIM can extend existing tools and processes, use Azure native tools as outlined, or do both as needed. Use Azure AD PIM access reviews to periodically validate resource entitlements. Access reviews are part of many compliance frameworks. Many organizations already have a process in place to address this requirement. Use Azure AD-only groups for Azure control-plane resources in Azure AD PIM when you grant access to resources. Add on-premises groups to the Azure AD-only group if a group management system is already in place.

Integrate Azure AD logs with the platform-central Azure Monitor. Azure Monitor allows for a single source of truth around log and monitoring data in Azure, which gives organizations cloud-native options to meet requirements around log collection and retention.

If any data sovereignty requirements exist, custom user policies can be deployed to enforce them.

Use Azure Security Center just-in-time access for all infrastructure as a service (IaaS) resources to enable network-level protection for ephemeral user access to IaaS virtual machines.

Use Azure AD managed identities for Azure resources to avoid authentication based on user names and passwords. Because many security breaches of public cloud resources originate with credential theft embedded in code or other text sources, enforcing managed identities for programmatic access greatly reduces the risk of credential theft.

Use privileged identities for automation runbooks that require elevated access permissions. Automated workflows that violate critical security boundaries should be governed by the same tools and policies that users of equivalent privilege are.

Don't add users directly to Azure resource scopes. This lack of centralized management greatly increases the management required to prevent unauthorized access to restricted data.

## Plan for authentication inside a landing zone

A critical design decision that an enterprise organization must make when adopting Azure is whether to extend an existing on-premises identity domain into Azure or to create a brand new one. Requirements for authentication inside the landing zone should be thoroughly assessed and incorporated into plans to deploy Active Directory Domain Services (AD DS) in Windows Server, Azure AD DS, or both. Most Azure environments will use at least Azure AD for Azure fabric authentication and AD DS localhost authentication and group policy management.

### Design recommendations and considerations for authentication inside a landing zone

Consider centralized and delegated responsibilities to manage resources deployed inside the landing zone. Also consider the applications that rely on domain services and use older protocols, which can use Azure AD DS.

Use centralized and delegated responsibilities to manage resources deployed inside the landing zone based on role and security requirements. Privileged operations such as creating service principal objects, registering applications in Azure AD, and procuring and handling certificates or wildcard certificates require special permissions. Consider which users will be handling such requests and how to secure and monitor their accounts with the degree of diligence required.

If an organization has a scenario where an application that uses integrated Windows authentication must be accessed remotely through Azure AD, consider using Azure AD Application Proxy.

Remember, there's a difference between Azure AD, Azure AD DS, and AD DS running on Windows Server. Evaluate your application needs, and understand and document the authentication provider that each one will be using. Plan accordingly for all applications. Evaluate the compatibility of workloads for AD DS on Windows Server and for Azure AD DS. Ensure that your network design allows resources that require AD DS on Windows Server for local authentication and management to access the appropriate domain controllers. For AD DS on Windows Server, consider shared services environments that offer local authentication and host management in a larger enterprise-wide network context.

Deploy Azure AD DS within the primary region because this service can only be projected into one subscription.

Use managed identities instead of service principals for authentication to Azure services. This approach reduces exposure to credential theft.
