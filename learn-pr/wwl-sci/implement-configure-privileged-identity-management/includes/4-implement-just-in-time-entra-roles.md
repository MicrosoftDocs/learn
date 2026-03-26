Now that you explored the controls that Microsoft Entra Privileged Identity Management (PIM) provides, you're ready to apply them. This unit focuses on Microsoft Entra roles—the tenant-directory plane—walking you through eligibility assignments, role settings, and activation. The next unit covers Azure resource roles.

> [!NOTE]
> PIM requires a Microsoft Entra ID P2 or Microsoft Entra ID Governance license for each user whose access it manages.

## Identify Microsoft Entra roles that should never be permanent

Not every role in your tenant demands just-in-time (JIT) treatment. Most users require only standard permissions with no elevated directory role. However, a specific tier of high-privileged roles carries enough blast radius that permanent assignment creates unacceptable risk. Those roles belong in the JIT-only tier, and the table below names each one alongside the reason it requires that protection.

| Role | Why it must be JIT |
|---|---|
| Global Administrator | Broadest blast radius in the tenant—full control over all directory settings and services |
| Privileged Role Administrator | Can modify any role assignment, including its own |
| Security Administrator | Controls security policy configuration across the tenant |
| Exchange Administrator | Has full access to email and calendar infrastructure |
| Application Administrator | Can register apps and modify application credentials |
| Authentication Policy Administrator | Controls authentication methods policy, tenant-wide multifactor authentication (MFA) settings, and password protection policy |

> [!IMPORTANT]
> Before you make Global Administrator eligible in PIM, verify that at least two emergency access (break-glass) accounts hold a permanent active assignment to the role. Store the break-glass credentials securely offline. Without this safeguard, a misconfiguration or an identity provider outage could lock every administrator out of the tenant with no recovery path.

## Assign eligible access to a Microsoft Entra role

When you assign a user to a role as eligible, you convert them from always holding the role to holding only the entitlement. The role grants no active permissions until the user initiates an activation. The procedure makes that conversion for any Microsoft Entra ID role in PIM.

1. Sign in to the Microsoft Entra admin center and open **ID Governance** > **Privileged Identity Management**.
2. Under **Manage**, select **Microsoft Entra roles**.
3. Select the target role—for example, **Global Administrator**.
4. Select **Assignments** > **Add assignments**.
5. Set **Assignment type** to **Eligible**.
6. Select the member and set the assignment duration (permanent or time-bound).
7. Select **Assign** to complete the assignment.

This change converts standing access to a JIT entitlement—the role now appears in the user's eligible assignments but grants no active privileges until they complete an activation.

## Configure role settings for activation

**Role settings** are the per-role configuration in PIM that governs the conditions any eligible user must satisfy before PIM grants access to that role. For example, settings determine whether MFA verification is enforced, whether the user must enter a justification, whether an approver must authorize the request, and how long an activation can last. These settings apply uniformly to all eligible users of a given role, and they're entirely separate from the individual assignments you create for specific users. Configuring role settings doesn't create any assignments—it only determines what conditions must be met when an eligible user activates.

:::image type="content" source="../media/privileged-entra-roles-operations.png" alt-text="Mindmap showing PIM split into role settings (MFA, justification, approval, duration) and assignments (eligible or active).":::

The following table shows recommended activation controls organized by privilege tier.

| Privilege tier | Example roles | MFA | Justification | Approval | Max duration |
|---|---|---|---|---|---|
| Critical | Global Admin, Privileged Role Admin | Required | Required | Required | 1–2 hours |
| High | Security Admin, Privileged Authentication Admin | Required | Required | Recommended | 4–8 hours |
| Moderate | Exchange Admin, App Admin | Required | Required | Optional | 8 hours |

To reach the settings for a specific role, navigate to **PIM** > **Microsoft Entra roles**, select the role, select **Role settings**, and select **Edit**.

## Activate an eligible Microsoft Entra role

From your perspective, activation is the step that converts an eligible assignment into a live, time-limited session. That session grants the role's full permissions for the duration you specify, capped by the maximum set in role settings.

1. In PIM, select **My roles** > **Eligible assignments**.
2. Find the role and select **Activate**.
3. Set the activation duration (within the maximum configured in role settings).
4. Enter a justification describing the task requiring elevated access.
5. If approval is required, submit the request and wait for approver action.
6. Confirm the role appears under **Active assignments** with a duration countdown.

> [!NOTE]
> For roles that require approval, activation could be delayed depending on approver availability. For emergency response scenarios, use a dedicated break-glass account rather than an approval-gated activation.

When the duration elapses, the role session expires and the assignment automatically reverts to eligible—no manual cleanup required.

Microsoft Entra roles are tenant-scoped: they govern identities and configurations at the directory level. Azure resource roles work at a narrower scope—a specific subscription, resource group, or individual resource. PIM secures both planes, but the assignment path shifts when you move to the resource layer, which is what you configure in the next unit.
