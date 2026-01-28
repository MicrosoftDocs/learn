Security architects designing solutions for cloud tenant administration must address the unique challenges of securing privileged access across diverse environments. This unit provides design guidance for securing administrative access to Azure tenants, Microsoft 365 tenants, SaaS applications, and multicloud infrastructure.

## Key design considerations for securing privileged access

When designing solutions for securing cloud tenant administration, consider these fundamental requirements aligned with Zero Trust principles and the [Microsoft Cloud Security Benchmark (MCSB) v2](/security/benchmark/azure/mcsb-privileged-access):

### Administrative boundary separation

Different cloud services require different administrative boundaries. Determine:

- Which administrative roles need access to which tenants and services
- How to prevent lateral movement between administrative boundaries
- Whether to use separate identities for different administrative functions (MCSB PA-1)

### Cross-tenant and cross-cloud access patterns

Organizations often manage multiple tenants or cloud platforms. Consider:

- Centralized vs. distributed identity management for administrators
- Delegation models that maintain customer control while enabling managed services
- Audit and accountability across tenant boundaries

### Least-privilege and just-in-time access across tenant and cloud boundaries

Multi-tenant and multicloud environments introduce complexity for just-in-time access that goes beyond single-environment implementations (MCSB PA-2, PA-7):

- Design approval workflows that account for administrators managing resources in customer tenants they don't own
- Address time zone and availability challenges when approvers span multiple organizations or geographies
- Determine how JIT elevation in one tenant or cloud affects access in federated environments
- Plan for scenarios where emergency access is needed to customer tenants outside normal business hours

### Unified visibility across administrative boundaries

When administrators operate across multiple tenants or cloud platforms, visibility requirements expand significantly:

- Determine where administrative logs should reside—customer tenants, managing tenants, or both—to meet compliance and sovereignty requirements
- Design correlation strategies that connect an administrator's identity across federated systems (Microsoft Entra ID to AWS IAM Identity Center to GCP Cloud Identity)
- Establish how to detect anomalous administrative patterns that span multiple tenants, such as an administrator suddenly accessing resources in tenants they've never managed
- Define alerting responsibilities when suspicious activity originates from a managing tenant but affects customer resources

## Azure tenant management with Azure Lighthouse

[Azure Lighthouse](/azure/lighthouse/overview) addresses multi-tenant administration challenges by enabling secure, delegated access to customer Azure resources from a managing tenant.

### How Azure Lighthouse addresses design considerations

| Design consideration | Azure Lighthouse capability |
|----------------------|----------------------------|
| **Administrative boundary separation** | Delegated resource management keeps customer resources in the customer tenant while granting scoped access to managing tenant users |
| **Cross-tenant access** | Managing tenant users access customer resources without switching directories or using separate credentials |
| **Least privilege** | Customers control exactly which subscriptions, resource groups, and roles are delegated |
| **Visibility and monitoring** | Activity logs remain in customer tenants; managing tenants can view cross-tenant activity in "My customers" |

:::image type="content" source="../media/azure-lighthouse-overview.jpg" alt-text="Diagram showing an overview of Azure Lighthouse." lightbox="../media/azure-lighthouse-overview.jpg":::

### Key capabilities

- **Azure delegated resource management**: [Manage customer Azure resources securely from your own tenant](/azure/lighthouse/concepts/architecture) without switching context. Customer subscriptions and resource groups are delegated to specified users and roles.
- **Cross-tenant management experiences**: Work with Azure services like Azure Policy, Microsoft Sentinel, and Azure Arc across multiple tenants from a single view.
- **Customer control**: Customers maintain precise control over delegated scopes and permissions, with the ability to [audit service provider actions](/azure/lighthouse/how-to/view-service-provider-activity) and revoke access at any time.

For enterprise organizations managing resources across multiple tenants, see [Azure Lighthouse for enterprise scenarios](/azure/lighthouse/concepts/enterprise).

## Microsoft 365 tenant management

A Microsoft 365 tenant represents a dedicated instance of Microsoft 365 services linked to a Microsoft Entra tenant. Securing administrative access requires attention to both the Microsoft 365 workloads and the underlying identity infrastructure.

:::image type="content" source="../media/tenant-management-example-tenant.png" alt-text="Diagram showing an example Microsoft 365 tenant with its Microsoft Entra tenant." lightbox="../media/tenant-management-example-tenant.png":::

### How Microsoft 365 addresses design considerations

| Design consideration | Microsoft 365 capability |
|----------------------|-------------------------|
| **Administrative boundary separation** | Separate admin roles for Exchange, SharePoint, Teams, and security functions; administrative units for scoped management |
| **Just-in-time access** | Microsoft Entra PIM for directory roles; Microsoft Purview Privileged Access Management for task-level JIT |
| **Least privilege** | Granular built-in roles; custom roles for specific administrative functions |
| **Visibility and monitoring** | Unified audit log; Microsoft Defender XDR for administrative activity monitoring |

### Attributes of well-secured tenant administration

Securing privileged access to Microsoft 365 tenants requires:

- **Strong authentication**: Require phishing-resistant MFA (FIDO2, Windows Hello) for all administrative access
- **Conditional Access**: Enforce device compliance, trusted locations, and risk-based policies for admin sign-ins
- **Role separation**: Use dedicated admin accounts separate from daily productivity accounts
- **Emergency access**: Maintain break-glass accounts with appropriate monitoring and controls

:::image type="content" source="../media/tenant-management-tenant-config.png" alt-text="Diagram showing an example Microsoft 365 tenant." lightbox="../media/tenant-management-tenant-config.png":::

## SaaS application administration

Organizations use numerous SaaS applications, each with its own administrative interface. A centralized approach to SaaS administrative security reduces risk and improves governance.

### How Microsoft solutions address SaaS administration

| Design consideration | Solution approach |
|----------------------|-------------------|
| **Administrative boundary separation** | Integrate SaaS apps with Microsoft Entra ID; use app-specific admin roles |
| **Cross-application access patterns** | Single sign-on with Microsoft Entra ID eliminates separate SaaS credentials |
| **Just-in-time access** | Extend PIM to SaaS app roles through Microsoft Entra ID Governance |
| **Visibility and monitoring** | Microsoft Defender for Cloud Apps provides cross-SaaS administrative activity monitoring |

### Implementation guidance

- **Centralized identity**: Use Microsoft Entra ID as the identity provider for all SaaS applications through SAML, OpenID Connect, or SCIM integration
- **Conditional Access**: Apply Conditional Access policies requiring compliant devices and strong authentication for administrative access
- **Application governance**: Use Microsoft Defender for Cloud Apps to detect and respond to anomalous administrative activities

For more information, see [Secure access practices for administrators in Microsoft Entra ID](/entra/identity/role-based-access-control/security-planning).

## Multicloud infrastructure administration

Organizations managing infrastructure across Azure, AWS, and GCP need consistent privileged access controls. The [Cloud Adoption Framework](/azure/cloud-adoption-framework/) provides guidance for multicloud security governance.

### How Microsoft solutions address multicloud administration

| Design consideration | Solution approach |
|----------------------|-------------------|
| **Administrative boundary separation** | Separate identities and roles per cloud; use cloud-native IAM integrated with Microsoft Entra ID |
| **Cross-cloud access patterns** | Federate Microsoft Entra ID with AWS IAM Identity Center and Google Cloud Identity |
| **Just-in-time access** | Permissions Management in Microsoft Defender for Cloud provides cross-cloud JIT capabilities |
| **Visibility and monitoring** | Microsoft Sentinel collects and correlates administrative logs from all cloud platforms |

### Implementation guidance

- **Identity federation**: Establish Microsoft Entra ID as the primary identity provider with federation to other cloud platforms
- **Consistent policies**: Define administrative policies that translate across cloud providers while respecting platform-specific capabilities
- **Centralized monitoring**: Aggregate administrative activity logs in Microsoft Sentinel for unified threat detection

## Secure privileged access to AI workloads

AI services introduce unique privileged access challenges due to their access to potentially sensitive training data, autonomous decision-making capabilities, and the high-value nature of trained models.

### Design considerations for AI privileged access

| Consideration | Security requirement |
|---------------|---------------------|
| **Model training access** | Administrators accessing training data and compute resources need carefully scoped, time-limited permissions |
| **Model deployment** | Separation between who can train models and who can deploy them to production |
| **AI service configuration** | Changes to content filters, rate limits, and data connections require approval workflows |
| **AI agent permissions** | Autonomous agents that take actions need least-privilege access with comprehensive logging |

### Implementation guidance

- **Model administrators**: Apply PIM for just-in-time access to Azure AI Foundry, Azure Machine Learning, and Azure OpenAI administrative roles
- **Training data access**: Use time-limited permissions for data scientists accessing sensitive training datasets
- **AI agent identities**: Use managed identities with minimal required permissions; avoid shared credentials
- **Monitoring**: Ensure AI administrative activities flow to Microsoft Sentinel for correlation with other security events

For more information on securing AI workloads, see [Azure AI services security baseline](/security/benchmark/azure/baselines/azure-ai-services-security-baseline).