As a security architect, you need to evaluate identity governance solutions that protect privileged access while enabling productivity. Microsoft Entra ID Governance helps you answer critical questions: Who should have access to which resources? What are those users doing with that access? Are your controls working effectively?

This unit establishes architectural principles for identity governance, then examines how Privileged Identity Management (PIM), Privileged Access Management (PAM), entitlement management, and access reviews address those principles.

## Architectural principles for identity governance

When designing identity governance for your organization, apply these principles:

**Minimize standing privileges**: Configure eligible rather than active assignments for administrative roles. Require approval for highly sensitive roles. Use time-bound assignments rather than permanent access.

**Separate administrative accounts**: Ensure administrators use dedicated accounts for privileged tasks, separate from their daily productivity accounts. This separation limits the impact of phishing attacks and credential theft.

**Implement layered controls**: Combine role-level protection with task-level protection. Add access reviews to continuously validate that access remains appropriate.

**Enable visibility**: Configure notifications for privileged role changes. Download audit history for compliance reporting. Monitor for accounts accumulating excessive privileges.

With these principles in mind, let's examine how each governance capability addresses them.

## Evaluate Privileged Identity Management

[Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) directly addresses the principle of minimizing standing privileges. Instead of granting permanent administrative access, PIM enables you to manage, control, and monitor access to critical resources across Microsoft Entra ID, Azure, and Microsoft 365.

PIM addresses standing privilege risks through:

- **Just-in-time access**: Users receive privileges only when needed, reducing the attack surface
- **Time-bound assignments**: Access automatically expires based on configured start and end dates
- **Approval workflows**: Sensitive role activations require designated approvers
- **Multifactor authentication enforcement**: Additional verification before role activation
- **Justification requirements**: Users must document why they need elevated access
- **Audit trails**: All role activations are logged for compliance and forensic analysis

When designing your PIM implementation, you define two assignment types. **Eligible** assignments require users to perform an action—such as requesting approval or completing MFA—before using the role. **Active** assignments provide immediate access without additional steps. For most privileged roles, eligible assignments provide a stronger security posture.

> [!TIP]
> Configure notification alerts for privileged role activations. These alerts support the visibility principle by providing early warning when users activate highly privileged roles like Global Administrator or Privileged Role Administrator.

## Compare PIM and Privileged Access Management

The layered controls principle suggests combining protections at multiple levels. Understanding where PIM and Privileged Access Management (PAM) apply helps you design comprehensive protection.

**Microsoft Entra PIM** applies protection at the **role level**. You use PIM to manage access to Microsoft Entra roles, Azure resource roles, and role groups. A single role assignment might enable multiple administrative tasks.

**Microsoft Purview PAM** applies protection at the **task level** within Microsoft 365. Users request just-in-time access to complete specific privileged tasks through time-bounded approval workflows. This granular approach enables zero standing privileges for sensitive Microsoft 365 operations.

:::image type="content" source="../media/layered-protection.png" alt-text="Diagram showing how PIM and PAM provide layered protection at role and task levels in Microsoft 365.":::

When you deploy both, you achieve defense in depth: PIM controls who can hold administrative roles, while PAM controls which specific tasks those administrators can perform.

## Evaluate entitlement management

[Entitlement management](/entra/id-governance/entitlement-management-overview) extends the minimize standing privileges principle beyond administrative roles to general resource access. It addresses the challenge of managing access at scale, particularly when collaborating with external partners.

Organizations struggle when users don't know what access they need or who can approve it. Once granted, access often persists longer than necessary. These challenges multiply with external collaboration—you might not know which partner employees need access, and partners might not understand your resource structure.

Entitlement management introduces **access packages** that bundle related resources together. You define:

- Which groups, applications, and SharePoint sites the package includes
- Which users can request access (internal users, specific partner organizations, or anyone)
- Required approval workflows and access duration
- Automatic expiration and recertification requirements

For architects, the key evaluation criteria include whether entitlement management can automate your current manual provisioning processes and whether access packages align with your business roles and collaboration patterns.

## Design access reviews

[Access reviews](/entra/id-governance/access-reviews-overview) provide the recertification mechanism that validates whether granted access remains appropriate—directly supporting the visibility and minimize standing privileges principles.

Access reviews help you answer these questions:

- Do users still need their current access assignments?
- Have any privileged roles accumulated excessive members?
- Are guest accounts being removed when collaboration ends?
- Can resource owners verify who should access their resources?

Within PIM, you can configure access reviews specifically for privileged role assignments. Reviewers—whether administrators, role members themselves, or designated business owners—periodically confirm that assignments remain necessary. Reviews can be one-time or recurring, and you can configure automatic actions when reviews complete.

> [!IMPORTANT]
> For highly privileged roles like Global Administrator, schedule regular access reviews to ensure only authorized users retain these assignments. Configure reviews to require justification for continued access.

The governance capabilities in Microsoft Entra ID work together as part of the identity lifecycle. Entitlement management automates access requests. PIM protects how privileged roles are used. Access reviews validate that access remains appropriate. Together, they enable you to design solutions that balance security with operational efficiency.
