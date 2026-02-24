The Enterprise Access Model, which provides a comprehensive framework for organizing access control across your entire organization, shows how privileged access fits into an overall enterprise access strategy.

## Understanding access planes

The primary stores of business value that an organization must protect are in the Data/Workload plane:

:::image type="content" source="../media/data-workload-plane.png" alt-text="Diagram showing the data/workload plane." lightbox="../media/data-workload-plane.png":::

The applications and data typically store a large percentage of an organization's:

- **Business processes** in applications and workloads
- **Intellectual property** in data and applications

The enterprise IT organization manages and supports the workloads and the infrastructure they're hosted on, whether it's on-premises, on Azure, or a third-party cloud provider, creating a **management plane**. Providing consistent access control to these systems across the enterprise requires a **control plane** based on centralized enterprise identity system(s), often supplemented by network access control for older systems like operational technology (OT) devices.

:::image type="content" source="../media/control-management-data-workload-planes-v2.png" alt-text="Diagram showing the control, management, and data/workload planes." lightbox="../media/control-management-data-workload-planes-v2.png":::

Each of these planes has control of the data and workloads by virtue of their functions, creating an attractive pathway for attackers to abuse if they can gain control of either plane.

For these systems to create business value, they must be accessible to internal users, partners, and customers using their workstations or devices (often using remote access solutions) - creating **user access** pathways. They must also frequently be available programmatically via application programming interfaces (APIs) to facilitate process automation, creating **application access** pathways.

:::image type="content" source="../media/user-app-control-management-data-workload-planes-v2.png" alt-text="Diagram showing adding user and application access pathways." lightbox="../media/user-app-control-management-data-workload-planes-v2.png":::

Finally, these systems must be managed and maintained by IT staff, developers, or others in the organizations, creating **privileged access** pathways. Because of the high level of control they provide over business critical assets in the organization, these pathways must be stringently protected against compromise.

:::image type="content" source="../media/privileged-access-over-underlying-planes-v2.png" alt-text="Diagram showing privileged access pathway to manage and maintain." lightbox="../media/privileged-access-over-underlying-planes-v2.png":::

## Enforce Zero Trust access controls

Providing consistent access control in the organization that enables productivity and mitigates risk requires you to:

- **Enforce Zero Trust principles on all access**
  - Assume breach of other components
  - Explicit validation of trust
  - Least privilege access

- **Pervasive security and policy enforcement** across internal and external access to ensure consistent policy application for all access methods including users, admins, APIs, service accounts, and more.

- **Mitigate unauthorized privilege escalation** by enforcing hierarchy to prevent control of higher planes from lower planes through attacks or abuse of legitimate processes. Continuously audit for configuration vulnerabilities enabling inadvertent escalation, and monitor and respond to anomalies that could represent potential attacks.

The [Azure Well-Architected Framework security pillar](/azure/well-architected/security/) emphasizes that identity should serve as the primary security perimeter, with privileged access controls as a critical component.

## Design privileged role assignment and delegation

When designing a solution for assigning and delegating privileged roles, apply these principles from the Enterprise Access Model:

| Principle | Design consideration |
|-----------|---------------------|
| **Separation of duties** | No single account should have privileges across multiple planes. A user managing the control plane shouldn't use the same account for data plane access. |
| **Just-in-time activation** | Privileged roles should require explicit activation with time limits, rather than permanent assignment. |
| **Approval workflows** | High-impact roles like Global Administrator should require approval from another privileged user before activation. |
| **Scope limitation** | Assign roles at the minimum scope necessary. Use administrative units in Microsoft Entra ID to limit scope of directory roles. |
| **Emergency access** | Maintain break-glass accounts with permanent Global Administrator access, protected with unique credentials and physical security tokens. |

For more information, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices).

## Evolution from the legacy AD tier model

The enterprise access model supersedes and replaces the legacy tier model that was focused on containing unauthorized escalation of privilege in an on-premises Windows Server Active Directory environment.

:::image type="content" source="../media/legacy-tier-model.png" alt-text="Diagram showing the legacy AD tier model." lightbox="../media/legacy-tier-model.png":::

The enterprise access model incorporates these elements as well as full access management requirements of a modern enterprise that spans on-premises, multiple clouds, internal or external user access, and more.

:::image type="content" source="../media/legacy-tier-model-comparison-new-v2.png" alt-text="Diagram showing the complete enterprise access model from old tiers." lightbox="../media/legacy-tier-model-comparison-new-v2.png":::

### Tier 0 scope expansion

Tier 0 expands to become the control plane and addresses all aspects of access control, including networking where it is the only/best access control option, such as legacy OT options

### Tier 1 splits

To increase clarity and actionability, what was tier 1 is now split into the following areas:

- **Management plane** – for enterprise-wide IT management functions
- **Data/Workload plane** – for per-workload management, which is sometimes performed by IT personnel and sometimes by business units

This split ensures focus for protecting business critical systems and administrative roles that have high intrinsic business value, but limited technical control. Additionally, this split better accommodates developers and DevOps models vs. focusing too heavily on classic infrastructure roles.

### Tier 2 splits

To ensure coverage for application access and the various partner and customer models, Tier 2 was split into the following areas:

- **User access** – which includes all B2B, B2C, and public access scenarios
- **App access** – to accommodate API access pathways and resulting attack surface
