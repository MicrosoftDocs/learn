Recommendations in Microsoft Defender for Cloud represent missing or misconfigured security controls. The Cloud and AI Security Engineer's job is deploying those controls to resources at scale—not investigating why the gap exists or analyzing security incidents. Control implementation work focuses on deployment, not analysis. You use four mechanisms to deploy security controls across subscriptions: Fix operations, policy remediation tasks, governance rules, and exemptions.

## The security engineer's remediation workflow

A recommendation in Defender for Cloud identifies a specific security gap on one or more resources. The remediation workflow is straightforward:

- Review the recommendation
- Select the deployment mechanism that fits the control type
- Execute the deployment
- Verify the control is active and the recommendation is resolved

Four mechanisms deploy security controls at scale:

- **Fix** - Deploy a security configuration automatically to selected resources using Defender for Cloud's built-in remediation logic
- **Policy remediation task** - Trigger a DeployIfNotExists or Modify policy to configure resources that match the policy condition
- **Governance rule** - Assign ownership and a compliance deadline to the team responsible for a group of resources
- **Exemption** - Formally document that a resource is excluded from a specific control with a justified reason

Use this table to choose the right mechanism when you open a recommendation:

| Situation | Mechanism |
|-----------|-----------|
| The recommendation shows a **Fix** button and the change is safe to automate | **Fix** |
| The recommendation is backed by a DeployIfNotExists or Modify policy and requires deploying a resource or extension | **Policy remediation task** |
| The control requires a decision by the resource owner, or the fix involves custom application configuration | **Governance rule** |
| A compensating control already addresses the risk, or leadership has formally accepted the risk | **Exemption** |

Most organizations use all four mechanisms—automated deployment for standard controls, governance rules for application-specific configurations, and exemptions for documented exceptions.

## Fix bulk automated control deployment

The **Fix** action deploys a security configuration automatically to resources where Defender for Cloud knows the exact configuration changes required. Fix is available on recommendations where the remediation is standardized and doesn't require business logic or custom values.

Examples of Fix-eligible recommendations include:

- Enable encryption for Azure SQL databases
- Enable diagnostic settings on storage accounts
- Configure Azure Key Vault to use RBAC permission model
- Enable secure transfer (HTTPS only) on storage accounts
- Disable public network access on Azure SQL servers

Fix operations work like this:

1. Open a recommendation in Defender for Cloud → select the **Affected resources** tab. The tab lists all resources that violate the control.

2. Select the resources you want to remediate. You can filter by subscription or resource group, or select all resources to deploy the control across the entire scope.

3. Select **Fix** at the top of the affected resources pane.

4. Review the fix logic. Defender for Cloud shows exactly what configuration it deploys—for example, setting `properties.supportsHttpsTrafficOnly` to `true` on storage accounts.

5. Confirm the fix operation.

Fix runs asynchronously. Defender for Cloud deploys the configuration to each selected resource in parallel. Resources move from "Unhealthy" to "Healthy" as the configuration is applied and the next policy evaluation cycle runs. For newly changed resources, evaluation typically triggers within 30–60 minutes. A full compliance scan across all resources in a subscription runs on a 24-hour cycle, so expect dashboard-wide reflection within 24 hours.

After Fix runs for Contoso's 47 storage accounts with secure transfer disabled, all 47 accounts have `supportsHttpsTrafficOnly` set to `true` within 5 minutes. The recommendation disappears from the active list on the next evaluation cycle, and Contoso's secure score improves by the recommendation's point value.

> [!NOTE]
> Fix deploys the configuration shown in the fix preview. Review the fix logic before confirming—some fixes deploy configurations that affect resource connectivity. For example, disabling HTTP access on a storage account used by a legacy application that doesn't support HTTPS breaks that application's access until the application is updated.

## Policy remediation tasks—trigger DeployIfNotExists at scale

Some recommendations are backed by Azure Policy definitions with DeployIfNotExists or Modify effects. For these recommendations, the security control is deployed by creating a policy remediation task—the same mechanism you used in Module 1 Unit 3, but initiated from the Defender for Cloud recommendation view rather than the Azure Policy portal.

DeployIfNotExists policies are common for recommendations that require deploying a child resource or configuration alongside the primary resource. Examples include:

- Deploy Azure Monitor Agent to virtual machines
- Configure diagnostic settings to send logs to the central Log Analytics workspace
- Deploy the Defender for Endpoint agent to Windows VMs
- Enable vulnerability assessment on SQL servers

To create a policy remediation task from a Defender for Cloud recommendation:

1. Open the recommendation and locate the **Policy definition** section. The section shows the backing Azure Policy definition.

2. Select **View policy definition** to open the policy in the Azure Policy portal.

3. Select **Remediate** from the policy assignment page.

4. Configure the remediation task scope—select which subscriptions or resource groups to include.

5. Create the remediation task.

The remediation task deploys the required configuration (diagnostic settings, agent extensions, and security settings) across all noncompliant resources within the scope. Progress appears in the Azure Policy remediation task status page. When the task completes, the resources move to compliant status, and the Defender for Cloud recommendation resolves on the next evaluation cycle.

Policy remediation tasks work well for recommendations where the deployment requires multiple steps or creates new resources. Contoso's security team uses policy remediation tasks to deploy Azure Monitor Agent to 200+ VMs and configure diagnostic settings to send activity logs from all subscriptions to the central SIEM workspace.

## Governance rules—assign ownership and enforce a compliance deadline

**Governance rules** assign each recommendation a responsible owner and a due date for remediation. Governance rules ensure recommendations don't sit unactioned for months—the owner receives email notifications, the recommendation appears in their "My items" dashboard in Defender for Cloud, and overdue items are escalated.

Governance rules operate at the recommendation level, not the resource level. A single governance rule can cover hundreds of resources across multiple subscriptions if they share the same recommendation. The rule assigns ownership based on conditions—for example, all High severity recommendations on resources in the "Production" resource group are assigned to the platform team with a 14-day remediation deadline.

To create a governance rule:

1. Go to **Defender for Cloud** → **Environment settings** → select the target subscription or management group → **Governance rules**.

2. Select **+ Create rule**.

3. Enter a rule name and description. The rule name appears in governance reports and email notifications.

4. Configure the scope—select which subscriptions or management groups the rule applies to.

5. Set the conditions that determine which recommendations the rule covers. Conditions include:
   - Severity (Critical, High, Medium, Low)
   - Resource type (Virtual machines, Storage accounts, SQL databases, etc.)
   - Owner tag (use an Azure tag on resources to automatically assign ownership)

6. Set the **Remediation timeframe** - how many days the owner has to remediate the recommendation. Options are 7, 14, 30, or 90 days.

7. Assign the **Owner**. You can assign a specific user or use an Azure tag on the resource. Using tags is more scalable—Contoso tags all resources with `Owner: teamname@contoso.com`, and the governance rule assigns recommendations to the team email alias automatically.

8. Configure escalation settings. Defender for Cloud can notify a manager if recommendations become overdue.

9. Save the rule.

Once the governance rule is active, Defender for Cloud assigns every matching recommendation to the specified owner with the configured deadline. The owner receives an email notification listing their assigned recommendations and the due date. The recommendation appears in the owner's personalized view in Defender for Cloud, where they track progress and mark items as resolved.

Governance rules let the security team operate at scale without manually triaging every recommendation. The rule enforces accountability automatically, and the governance report shows which teams are meeting deadlines, and which teams have overdue items.

## Create Exemptions - formal documentation of excluded controls

Exemptions remove a resource from the compliance calculation for a specific control without changing the policy or standard for other resources. Exemptions require documented justification and fall into two categories:

- **Waiver**: The risk is accepted. No compensating control exists. Leadership signed off on the exception. The resource doesn't comply with the control, and the organization acknowledges the risk.

- **Mitigated**: A compensating control provides equivalent protection. The resource doesn't comply with the specific control, but the underlying risk is addressed through an alternative mechanism.

Both categories require security-justified rationale and support an optional expiration date. Exemptions aren't for dismissing recommendations—they require explicit justification that withstands audit scrutiny.

To set an exemption:

1. Open the recommendation in Defender for Cloud.

2. Select the **Affected resources** tab and locate the resource you want to exempt.

3. Select the resource → **Exempt**.

4. Select the exemption category: **Waiver** or **Mitigated**.

5. Enter justification. For a waiver, document the business reason and risk acceptance. For a mitigated exemption, describe the compensating control that addresses the underlying risk.

6. (Optional) Set an expiration date. The exemption automatically expires on this date, and the resource returns to noncompliant status unless the exemption is renewed.

7. Save the exemption.

The exempted resource no longer appears in the "Unhealthy resources" list for that recommendation. The exemption is documented in the compliance report and visible in audit logs, so security reviewers, and auditors can verify that exemptions are justified.

> [!IMPORTANT]
> Exemptions affect the secure score calculation. A waiver exemption removes the resource from the denominator, improving the score without the control being deployed. Use exemptions only when genuinely justified—overuse creates a misleading compliance picture and undermines trust in the secure score metric.

## Track remediation progress

After Fix operations, governance rules, and policy remediation tasks are running, you track progress through Defender for Cloud's built-in reporting:

**Secure score trend** shows week-over-week improvement as controls are deployed and resources become compliant. The trend graph visualizes the impact of remediation efforts—Contoso's secure score increased from 42% to 68% over six weeks as the security team deployed controls using the mechanisms in this unit.

**Recommendation age** identifies recommendations open the longest. Governance rules with 30-day deadlines make old recommendations visible as overdue. The security team prioritizes overdue items and investigates why certain recommendations aren't being remediated—often the issue is that a resource owner lacks the permissions or tooling to deploy the required control.

**Governance report** shows the status of governance rule assignments across the organization. The report lists how many recommendations are on track, overdue, or completed. This gives leadership visibility into accountability—teams that consistently meet deadlines demonstrate effective security ownership, while teams with high overdue counts need more support or resources.

Once the security engineer configures standards and deploys remediation controls, the next question is how well the organization meets its regulatory obligations. Module 3 covers evaluating that compliance posture using the regulatory compliance dashboard.
