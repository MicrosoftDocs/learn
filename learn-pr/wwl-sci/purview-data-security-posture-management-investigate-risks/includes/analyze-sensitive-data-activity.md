When a data loss prevention (DLP) alert fires or sensitive data activity raises concern, you need to determine what happened and whether it requires action. Data Security Posture Management (DSPM) provides four investigation surfaces for this. Each answers a different investigation question.

## Investigation surfaces in Data Security Posture Management

Without DSPM, answering investigation questions means switching between audit log search, activity reports, DLP alert queues, and Insider Risk Management (IRM) dashboards independently. DSPM brings these starting points together so you can move between surfaces without losing context.

| Surface | What it answers | When to use it |
| --- | --- | --- |
| Activity explorer | What specific events occurred involving sensitive data? | Tracing individual events for specific users, time windows, or labels |
| AI activities tab | What happened during AI interactions with sensitive data? | Investigating prompts, responses, and DLP matches in AI contexts |
| Audit logs | What's the authoritative chronological record? | Reconstructing event sequences, building compliance records, tracing agent activity |
| Reports | What patterns exist across many events over time? | Identifying trends, comparing periods, spotting behavioral shifts |

A typical investigation might start in reports because a trend catches your attention, move to activity explorer to filter for the specific condition, then consult the audit log to get the authoritative record for a specific event.

### Activity explorer

Use activity explorer when you need to investigate a specific event involving sensitive data. It's accessible from **DSPM (preview)** > **Discover** > **Activity explorer** and shows activity related to content that contains sensitive information or has sensitivity labels applied.

You filter activities by:

- **Activity type**: File access, file copy, print, email send, cloud upload, sharing link creation
- **Workload**: SharePoint, OneDrive, Exchange, Teams, Endpoint devices
- **User**: Specific user principal name (UPN) or user groups
- **Time range**: Narrow to the period around a suspected event
- **Sensitivity labels**: Activities involving specific labels

A DLP alert about sensitive data shared externally becomes an investigation when you filter to that user, that time window, and that label. You then see not just the flagged event but the full sequence of events surrounding it.

:::image type="content" source="../media/activity-explorer-all-activity-types.png" alt-text="Screenshot showing activity explorer with the All activity types tab, filters, and a bar chart of sensitive data events." lightbox="../media/activity-explorer-all-activity-types.png":::

### AI activities tab

The **AI activities** tab within activity explorer shows events specific to AI interactions. AI interactions include prompts, data retrieval, responses, and DLP evaluation, all of which matter when reconstructing what happened.

If a DLP alert fires during a Copilot session, this tab shows the full interaction context including which sensitive data the AI accessed and what it returned.

:::image type="content" source="../media/activity-explorer-ai-activities.png" alt-text="Screenshot showing the AI activities tab in activity explorer with AI-specific filters and a bar chart of AI interactions." lightbox="../media/activity-explorer-ai-activities.png":::

> [!NOTE]
> Activity explorer in DSPM (preview) is distinct from activity explorer in DSPM for AI (classic). Events in the AI activities tab originate from the preview version specifically. If you're investigating AI-related activity, confirm you're working in DSPM (preview) rather than the classic version.

### Audit logs

The unified audit log captures a chronological record of user and agent interactions. Each entry includes timestamps, user identity, the exact operation performed, and the result. Where activity explorer shows you filtered views of events, the audit log provides the authoritative compliance-grade record.

For Agent 365 specifically, the audit log captures agent-to-human, human-to-agent, agent-to-tools, and agent-to-agent interactions. This is the only surface that provides the full sequence of what an agent did during a specific time window.

Use audit logs when you need:

- A chronological reconstruction of events for formal reporting
- The authoritative record for compliance or legal purposes
- Details about agent interactions not visible in activity explorer
- Correlation between multiple related events across services

### Reports

DSPM reports provide aggregated views across sensitive data usage and posture trends. Navigate to **DSPM (preview)** > **Reports** to access:

- Sensitive data usage patterns over time
- Labeling progress and gaps
- Policy usage and match frequency
- Risky behavior patterns for users and AI agents

Reports answer "is this getting better or worse?" and "where is risk concentrating?" A rising DLP match rate for a specific sensitive information type might be concentrated in one workload or spread across many. Reports show you that distribution before you drill into individual events.

A behavioral shift in reports gives you the filter criteria to take into activity explorer.

## Escalating to Data Security Investigations

Escalate when filtering and correlation don't explain the pattern or when deeper analysis is required. Data Security Investigations provides deeper analysis and collaborative remediation beyond what DSPM surfaces offer.

To escalate from DSPM:

1. Navigate to **DSPM (preview)** > **Objectives**.
1. Select the **Prevent exfiltration to risky destinations** objective.
1. Select **View objective** to view exfiltration details and proactive insights.
1. On the **Exfiltration risk patterns** card, select **Create investigation**.
1. Provide a name, optional description, and optional AI context.
1. Select **Create investigation** to open the case in Data Security Investigations.

The investigation is automatically scoped to all sensitive data exfiltrated from your organization in the last 30 days.

> [!NOTE]
> Data Security Investigations is a separate Purview solution with its own workflows. The escalation from DSPM creates the starting point. The investigation itself continues in that solution.
