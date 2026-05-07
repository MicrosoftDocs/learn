Agent governance doesn't stop after approval—it's an ongoing cycle of monitoring, reviewing, and remediating as usage patterns evolve. At Contoso, three months after deploying Microsoft Agent 365, the compliance team's document analysis agent shows usage spikes every Sunday night that weren't part of the original approval scope. Here, you learn how to monitor agent activity and enforce governance controls to ensure agents remain aligned with organizational policies over time.

| Monitoring focus | Key indicator | Governance action |
|-----------------|---------------|-------------------|
| Anomalous usage | 500% increase over baseline | Investigate for automation or misuse |
| Inactive agents | Zero interactions for 60+ days | Review for decommissioning |
| Policy violations | Data Loss Prevention (DLP) alerts or unauthorized access attempts | Block agent pending investigation |

## Monitor agent activity in Microsoft Agent 365

Microsoft Agent 365 tracks key activity metrics for every approved agent, including interaction volumes, active user counts, and usage trends over time. To view activity data, navigate to the **Agents** page, select an agent, and open the **Usage** or **Activity** tab. The usage view displays total interactions since approval, the number of unique users who interacted with the agent, and a time-series chart showing interactions per day over the past 30 days.

Risk signals—such as policy violations flagged by Microsoft Entra, Defender, or Purview—are aggregated into the Agent overview's **Agents at risk** card, giving you a single place to identify and act on cross-platform governance signals.

A closely related governance card is **Agents without owners**. When the person who created or submitted an agent leaves the organization, that agent becomes ownerless—there's no longer a designated person responsible for its lifecycle, compliance, or ongoing maintenance. The Agent overview surfaces ownerless agents as an actionable governance gap. Assigning an owner to each agent ensures accountability and prevents approved agents from persisting in production without anyone responsible for reviewing them during governance cycles.

These metrics help you identify patterns that indicate successful adoption or potential problems. An agent with steadily increasing interactions and expanding user adoption likely delivers value and operates within its intended scope. An agent with erratic usage patterns—such as thousands of interactions in a single day followed by weeks of inactivity—can indicate automation, misuse, or a business process that no longer requires the agent.

Peak usage times also provide governance insights. If an agent designed for interactive user assistance shows most of its activity between midnight and 6:00 AM, someone can be using it in a batch automation workflow rather than the intended ad-hoc query scenario. This doesn't automatically mean the usage is inappropriate, but it signals a need to verify that the actual use case aligns with the approved purpose.

## Identify anomalous usage and governance risks

Anomalous usage often indicates changes in how users interact with an agent or unexpected adoption beyond the original scope. An agent with 500 percent more interactions than its 30-day baseline could indicate successful viral adoption within a department, integration into an automated workflow, or misuse by a few power users. Each scenario has different governance implications.

To investigate anomalous usage, compare the unique user count to total interactions. If an agent shows 10,000 interactions but only five unique users, a small group is generating most of the activity. Review whether those users are using the agent as intended or whether they integrated it into processes that weren't part of the approval scope. If the usage aligns with organizational policies, update the agent's documentation to reflect the new use case. If it doesn't, block the agent and work with the users to modify their workflow.

Unused agents present a different risk. Agents with zero interactions for 60 or more days should be reviewed for decommissioning. Inactive agents still consume license resources, appear in the agent catalog where they create clutter, and expand your organization's attack surface. When you add in the fact the agent's permissions or connectors aren't actively monitored, there could be more challenges. During quarterly governance reviews, filter for agents with no recent activity. Work with the original submitters to determine whether to decommission the agents or whether they serve a seasonal business need.

## Enforce governance through remediation actions

When monitoring reveals that an agent no longer meets governance standards, Microsoft Agent 365 provides several enforcement actions. **Blocking an agent** removes it from user access immediately—no user in the organization can interact with the blocked agent. Blocking is reversible: select **Unblock** at any time to restore access. Use block during investigations—such as when an agent triggers Data Loss Prevention policy alerts and you need time to determine whether the alerts indicate legitimate usage or policy violations—then unblock once the investigation is resolved.

**Updating user scope** allows you to narrow the audience for an agent that expanded beyond its intended user base. If you approved an agent for a 20-person pilot group and discover through monitoring that 200 users now have access because the pilot group expanded into a distribution list, reduce the scope back to the original intended audience. Alternatively, work with stakeholders to justify the broader rollout and update the approval documentation.

**Revoking approval** moves an agent back to pending status, requiring a new approval before users can access it again. Revocation is appropriate when an agent's publisher updates the agent and adds new permissions or data connections that weren't part of the original approval. Some agent platforms notify administrators when published agents change, but monitoring activity patterns can also reveal functional changes—such as an agent that suddenly starts accessing SharePoint sites it didn't query during the first 90 days of deployment.

:::image type="content" source="../media/agent-enforcement-actions.png" alt-text="Three enforcement action cards showing Block and Unblock, Narrow Scope, and Revoke Approval with guidance on when to use each." lightbox="../media/agent-enforcement-actions.png":::

## Establish a continuous governance cycle

Effective agent governance follows a repeating cycle: approve based on initial criteria, monitor for changes in usage or risk, review agents against current policies, and remediate when deviations occur. This cycle ensures that agents approved six months ago under one set of business requirements don't persist unchanged when those requirements evolve.

Set a governance cadence that matches your organization's risk tolerance and regulatory requirements. A monthly review of usage anomalies catches unexpected changes quickly. A quarterly review of all active agents against current organizational policies ensures that older agents remain compliant as your AI governance framework matures. An annual reapproval process for high-access agents—those with broad permission scopes or access to sensitive data—provides a formal checkpoint to verify that business justification remains valid.

:::image type="content" source="../media/agent-governance-cycle.png" alt-text="Circular diagram showing the four phases of continuous agent governance: Approve, Monitor, Review, and Remediate." lightbox="../media/agent-governance-cycle.png":::

At Contoso, the Sunday night usage spikes in the compliance team's document analysis agent prompt an investigation. The compliance team explains that they integrated the agent into a weekend batch process that analyzes regulatory filings submitted during the week. This workflow wasn't included in the original approval request, which described the agent as an interactive tool for ad-hoc policy research. The Microsoft 365 administrator blocks the agent, reviews the batch processing workflow with the compliance team to ensure it aligns with data retention policies. Then it unblocks the agent with updated approval documentation reflecting the expanded scope.
