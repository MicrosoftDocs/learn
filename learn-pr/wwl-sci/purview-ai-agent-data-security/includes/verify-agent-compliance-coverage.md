With protection and detection configured, the remaining work is compliance governance. Agent interaction data needs to be preserved for legal holds, searchable for investigations, and retained according to regulatory requirements. eDiscovery and data retention still need configuration. Auditing, data classification, and Compliance Manager are already active because they activate automatically when agent instances are created.

## Include agent instances in eDiscovery

Agent interaction data exists in the audit log, but eDiscovery won't find it unless you explicitly identify agent instances as sources.

To include agent interactions in eDiscovery cases:

1. In the Microsoft Purview portal, create an eDiscovery case or open an existing case.
1. When selecting sources for a search query, identify the agent instance as you would a user. Agent prompts and responses are stored in a mailbox structure that eDiscovery can search.
1. In the query builder, add the condition **Type** > **Contains any of** > **Copilot activity** to capture AI application interactions.
1. Run the search to retrieve agent-to-human and human-to-agent interaction data.
1. Export results or add to a review set for further analysis.

If an agent instance isn't identified as a source, its interaction data won't appear in eDiscovery searches even though the data exists in the audit log. Legal hold also requires explicitly identifying agent instances.

## Apply retention policies to agent interaction data

To apply retention or deletion policies to agent interaction data:

1. In the Microsoft Purview portal, create or edit a retention policy.
1. Include the locations where agent interactions are stored: Microsoft Teams, OneDrive and SharePoint, and emails.
1. Ensure the policy scope includes agent instances, either directly or through a group.
1. Configure the retention duration and deletion behavior appropriate for your regulatory requirements.

Agent interactions stored across Teams, OneDrive, SharePoint, and emails are subject to the same retention principles that govern user data. When multiple retention policies apply to the same agent interaction data, the principles of retention resolve conflicts. Data is retained for the longest duration of all applied policies or eDiscovery holds.

## Verify audit log coverage

To confirm that agent interactions are being captured:

1. In the Microsoft Purview portal, go to the **Audit** solution.
1. Search the audit log for Agent 365 activities or filter activity explorer by the **AI activities** tab.
1. Confirm that agent-to-human, human-to-agent, agent-to-tools, and agent-to-agent interactions appear for your active agent instances.
1. Verify that the events include relevant details: timestamps, interaction type, referenced files, and sensitivity labels if applicable.

All four interaction types should be visible. If an interaction type is missing, verify that the agent instance is actively being used and that audit logging is enabled for your tenant.

## Verify full coverage across agent types

Review your active agent landscape and confirm coverage across all three compliance areas:

- **Automatic controls working**: Audit events appearing, data classification detecting sensitive information, Compliance Manager assessments including agent instances.
- **eDiscovery configured**: Agent instances identified as searchable sources, legal hold applied where required.
- **Retention configured**: Retention policies scoped to include agent interaction locations and agent instances.

For each active agent type, verify that you can:

1. Find audit records of the agent's recent activity
1. Include the agent's interactions in an eDiscovery search
1. Confirm a retention policy applies to the agent's interaction data

If any of these checks fail for an active agent, you have a compliance gap. Before remediating, check the coverage matrix to confirm whether the capability is actually available for that agent type or whether you're looking at a structural limitation.
