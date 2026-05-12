Assigning roles correctly is only half of RBAC governance. The harder problem is finding and fixing the overprivileged assignments that already exist. Contoso's security team discovers 37 Owner assignments at subscription scope, with 12 of those accounts dormant for 90 days. Here, you learn how to identify overprivileged role assignments and remediate them using Defender for Cloud CSPM's CIEM capabilities and Microsoft Entra access reviews.

| Overprivilege Category | Risk Profile | Detection Method |
|------------------------|--------------|------------------|
| Standing privilege at excessive scope | Active user with Owner at subscription when they need Contributor at resource group | Defender CSPM CIEM over-provisioned identity analysis |
| Dormant assignments | Account with role assignment but no authentication in 90+ days | Defender CSPM CIEM dormant identity recommendations |
| Guest accounts with elevated access | External users holding Contributor or higher at subscription scope | Defender CSPM identity recommendations + Azure Advisor |

## The overprivilege problem - why it persists

Role assignments are rarely revoked once granted. When someone's job changes, their old access usually stays. A developer who briefly needed Owner to set up an environment still has it six months later, even though they moved to a different project entirely.

Over time, identities accumulate permissions rather than shed them. This accumulation creates two categories of overprivilege in Contoso's estate: standing privilege at excessive scope and dormant assignments. Standing privilege at excessive scope means someone has Owner at subscription level when they need at most Contributor at resource group scope. Dormant assignments are role assignments for accounts that didn't use Azure in 90 or more days—former employees, contractors, or service accounts no longer in use.

Dormant assignments are especially risky. A credential for an account with Owner access that unused in 90 days is a high-value target for attackers. The dormancy means the account likely not monitored, but the permissions remain fully active. If that account is compromised, the attacker inherits all the privileges the legitimate user never even used.

## Defender for Cloud CSPM - CIEM for identity insights

Defender for Cloud's cloud security posture management (CSPM) includes cloud infrastructure entitlement management (CIEM) capabilities that surface identity-related risk as security recommendations. With the Defender CSPM plan enabled, Defender for Cloud analyzes actual usage patterns and surfaces identities that have permissions they don't use.

One common recommendation is "Remove unused role assignments for subscription Owners." This recommendation lists specific accounts that don't use their Owner permissions in the evaluation window. Unlike simple role assignment audits that only show who has what role, CIEM recommendations correlate the assignment with actual authentication and operation data. An account might have Owner assigned, but if they never performed any Owner-specific action, CIEM flags it for review.

Defender CSPM also detects dormant identities—both user accounts and service principals with role assignments but no authentication activity in the past 90 days. Additionally, it identifies guest accounts with elevated access, surfacing external user accounts holding Contributor or higher at subscription scope.

You access these recommendations in Defender for Cloud by going to **Recommendations**, then filtering by category "Identity" or searching for "over-provisioned". Each recommendation lists the specific identities and their assignments, with a direct link to the affected subscription's IAM screen for immediate remediation.

> [!NOTE]
> Defender CSPM's CIEM recommendations require the Defender CSPM plan to be enabled. Foundational CSPM (free) includes basic identity recommendations but not the full entitlement analysis.

## Azure Advisor RBAC recommendations

Azure Advisor provides complementary identity insights in the Security category. While Defender CSPM analyzes usage patterns, Advisor flags structural risks based on assignment count and account status.

The "Azure subscriptions shouldn't contain multiple Owners" recommendation flags subscriptions with more than three Owner assignments. This threshold acknowledges that some subscriptions legitimately need multiple owners for continuity, but more than three suggests loose access control. The "Deprecated accounts should be removed from your subscription" recommendation identifies accounts that exist in Microsoft Entra but are disabled or deleted—the role assignment still exists even though the account is deprovisioned.

You access Advisor by going to the Azure portal, selecting **Advisor**, choosing **Security**, and filtering by "Identity" issues category. Advisor recommendations export to CSV, which you can use to create a remediation work list. Unlike Defender CSPM's usage-based analysis, Advisor's recommendations are configuration-based and appear immediately when the conditions are met.

## Microsoft Entra access reviews - structured evidence-based remediation

Access reviews are the formal mechanism for evaluating whether existing role assignments are still justified. An **access review** asks designated reviewers—typically managers, resource owners, or the assigned users themselves—to confirm or deny that each role assignment is still needed.

To create an access review:

1. Go to **Microsoft Entra admin center** → **Identity Governance** → **Access reviews** → **+ New access review**.
2. Set **Review type** to **Azure resource roles** or **Microsoft Entra roles** depending on what you're reviewing.
3. Select the scope: the subscriptions with the suspicious assignments.
4. Select the roles to review: Owner, Contributor, or your specific roles of concern.
5. Set **Reviewers**: manager (automatic from HR data), specific people, or the users themselves (self-review).
6. Set **Duration** to 14–30 days (recommended for the first review).
7. Under **Upon completion settings**, set **Apply results automatically** to **Yes** and set **If reviewers don't respond** to **Remove access**.
8. Start the review.

When reviewers approve an assignment, it remains. When they deny, or don't respond, the assignment is revoked automatically when the review period closes. The "If reviewers don't respond" → "Remove access" setting is critical for least-privilege enforcement. It makes removal the default when a reviewer doesn't actively confirm the access is still needed, rather than requiring explicit action to remove access.

Access reviews create an audit trail for compliance purposes. Each approval or denial is logged with the reviewer's identity and timestamp. The audit entry provides evidence that the organization actively manages role assignments rather than letting them accumulate indefinitely.

## Right-sizing outcomes—what to do with the findings

After Defender for Cloud CSPM recommendations and access review results are available, you apply specific remediation actions based on the assignment's status and business justification.

- **Remove entirely**: Dormant accounts with no active use fall into this category—former employees, contractors, or deprovisioned service accounts. If the account didn't authenticate in 90+ days and has no active work in Azure, remove the role assignment immediately.

- **Downgrade to a less-permissive role**: Active users who need some access but not at Owner level needs their assignments adjusted. Remove the Owner assignment and assign Contributor (or a service-specific role like Virtual Machine Contributor) at resource group scope instead of subscription scope.

- **Convert to PIM-eligible**: Users who occasionally need elevated access but don't need it standing fall into this pattern. Remove the standing Contributor or Owner assignment and create a Privileged Identity Management (PIM)-eligible assignment instead. The user requests activation when needed, and the access automatically expires. PIM configuration is covered in the implement-configure-privileged-identity-management module.

- **Retain with documentation**: Assignments that are confirmed as still needed at the current permission level remain in place. The access review approval creates the audit trail that justifies the elevated access during compliance audits.

Contoso's remediation result after applying these categories: 12 dormant Owner assignments removed (accounts last active 90+ days ago), 18 Owner assignments downgraded to Contributor or service-specific roles at resource group scope, and 7 retained with access review approval documented.

> [!TIP]
> Schedule access reviews on a recurring cadence—quarterly for Owner and Contributor at subscription scope, semi-annually for resource group-level assignments. Recurring reviews prevent the assignment backlog from accumulating again.
