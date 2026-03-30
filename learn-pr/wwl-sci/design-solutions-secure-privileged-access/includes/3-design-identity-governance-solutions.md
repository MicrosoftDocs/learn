As a security architect, you must evaluate identity governance solutions through two lenses: **security**—do these controls reduce the risk of compromised or misused privileges?—and **governance**—do they provide the visibility, automation, and auditability your organization needs for compliance? Microsoft Entra ID Governance addresses both by answering critical questions: Who should have access to which resources? What are those users doing with that access? Are your controls working effectively?

This unit examines how Privileged Identity Management (PIM), Privileged Access Management (PAM), entitlement management, and access reviews help you evaluate and strengthen both security posture and governance maturity.

## Evaluate Privileged Identity Management

[Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) enables you to manage, control, and monitor access to critical resources across Microsoft Entra ID, Azure, and Microsoft 365. From a **security** perspective, PIM eliminates standing privileges—the persistent administrative access that attackers target. From a **governance** perspective, PIM creates an auditable record of every elevation, providing evidence that privileged access is justified, approved, and time-limited.

PIM addresses these concerns through:

- **Just-in-time access**: Users receive privileges only when needed, reducing the attack surface
- **Time-bound assignments**: Access automatically expires based on configured start and end dates
- **Approval workflows**: Sensitive role activations require designated approvers
- **Multifactor authentication enforcement**: Additional verification before role activation
- **Justification requirements**: Users must document why they need elevated access
- **Audit trails**: All role activations are logged for compliance and forensic analysis

When designing your PIM implementation, you define two assignment types. **Eligible** assignments require users to perform an action—such as requesting approval or completing MFA—before using the role. **Active** assignments provide immediate access without additional steps. For most privileged roles, eligible assignments provide a stronger security posture because they ensure every use of a privilege is deliberate and recorded.

PIM also extends to **PIM for Groups**, which lets you govern membership in security groups and Microsoft 365 groups using the same just-in-time and approval-based model. This capability is valuable when group membership grants access to sensitive resources, such as a group-based Conditional Access exclusion or an application role assignment.

> [!TIP]
> Configure notification alerts for privileged role activations. These alerts provide early warning when users activate highly privileged roles like Global Administrator or Privileged Role Administrator—supporting both security monitoring and governance oversight.

## Compare PIM and Privileged Access Management

Understanding where PIM and Privileged Access Management (PAM) apply helps you design layered protection that strengthens both security and governance at different scopes.

**Microsoft Entra PIM** applies protection at the **role level**. You use PIM to manage access to Microsoft Entra roles, Azure resource roles, and role groups. A single role assignment might enable multiple administrative tasks.

[**Microsoft Purview PAM**](/purview/privileged-access-management) applies protection at the **task level** within Microsoft 365. Users request just-in-time access to complete specific privileged tasks through time-bounded approval workflows. This granular approach enables zero standing privileges for sensitive Microsoft 365 operations.

:::image type="content" source="../media/layered-protection.png" alt-text="Diagram showing how PIM and PAM provide layered protection at role and task levels in Microsoft 365.":::

When you deploy both, you achieve defense in depth: PIM controls who can hold administrative roles (security), while PAM controls which specific tasks those administrators can perform and creates per-task approval records (governance). Evaluate whether your organization's compliance requirements demand task-level auditability—if so, PAM addresses a gap that PIM alone doesn't cover.

## Evaluate entitlement management

[Entitlement management](/entra/id-governance/entitlement-management-overview) extends governance beyond administrative roles to general resource access at scale, particularly when collaborating with external partners.

Organizations struggle when users don't know what access they need or who can approve it. Once granted, access often persists longer than necessary. These challenges multiply with external collaboration—you might not know which partner employees need access, and partners might not understand your resource structure.

Entitlement management introduces **access packages** that bundle related resources together. You define:

- Which groups, applications, and SharePoint sites the package includes
- Which users can request access (internal users, specific connected organizations, or anyone)
- Required approval workflows and access duration
- Automatic expiration and recertification requirements

From a **security** standpoint, evaluate whether entitlement management can replace manual provisioning that bypasses approval controls. From a **governance** standpoint, evaluate whether access packages can model your business roles and collaboration patterns so that every grant is policy-driven, time-limited, and auditable.

## Design access reviews

[Access reviews](/entra/id-governance/access-reviews-overview) provide the recertification mechanism that validates whether granted access remains appropriate. They are the primary tool for **ongoing governance validation**—ensuring that access decisions made weeks or months ago still reflect current business need—and they directly strengthen **security** by identifying stale or excessive privileges before they can be exploited.

Access reviews help you answer these questions:

- Do users still need their current access assignments?
- Have any privileged roles accumulated excessive members?
- Are guest accounts being removed when collaboration ends?
- Can resource owners verify who should access their resources?

Within PIM, you can configure access reviews specifically for privileged role assignments. Reviewers—whether administrators, role members themselves, or designated business owners—periodically confirm that assignments remain necessary. Reviews can be one-time or recurring, and you can configure automatic actions when reviews complete, such as removing access for unresponsive reviewers. Access reviews also surface **machine-learning-based recommendations** that flag inactive users, helping reviewers make informed decisions efficiently.

> [!IMPORTANT]
> For highly privileged roles like Global Administrator, schedule recurring access reviews and configure them to require justification for continued access. This practice satisfies both security requirements (reducing persistent privilege risk) and governance requirements (demonstrating periodic recertification to auditors).

## How these capabilities work together

The governance capabilities in Microsoft Entra ID form an integrated lifecycle. Entitlement management automates access requests with built-in policies. PIM protects how privileged roles are activated and used. Access reviews validate that all granted access—whether from entitlement management or PIM—remains appropriate over time. When you use these solutions to evaluate your organization's security and governance posture, assess whether they close existing gaps in **security** (reducing attack surface, enforcing least privilege) and **governance** (providing auditability, policy enforcement, and compliance evidence).
