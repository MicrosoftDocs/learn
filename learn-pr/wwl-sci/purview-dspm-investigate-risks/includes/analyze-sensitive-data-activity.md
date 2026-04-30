Once sensitive data is classified, labeled, and governed by DLP policies, the environment starts generating signals. Alerts fire. Users trigger policy matches. AI agents interact with sensitive content. Someone has to determine what happened, whether it's a real problem, and what to do about it.

## Investigation surfaces in DSPM

DSPM provides four investigation surfaces, each designed around a different type of question. Choosing the right one depends on whether you're tracing a single event, examining AI-specific interactions, building a compliance record, or identifying patterns across time.

| Surface | What it answers | When to use it |
| --- | --- | --- |
| Activity explorer | What specific events occurred involving sensitive data? | Tracing individual events for specific users, time windows, or labels |
| AI activities tab | What happened during AI interactions with sensitive data? | Investigating prompts, responses, and DLP matches in AI contexts |
| Audit logs | What's the authoritative chronological record? | Reconstructing event sequences, building compliance records, tracing agent activity |
| Reports | What patterns exist across many events over time? | Identifying trends, comparing periods, spotting behavioral shifts |

A typical investigation might start in reports because a trend catches your attention, move to activity explorer to filter for the specific condition, then consult the audit log to get the authoritative record for a specific event.

### Activity explorer

Activity explorer is accessible from **DSPM (preview)** > **Discover** > **Activity explorer**. It shows activity related to content that contains sensitive information or has sensitivity labels applied.

You filter activities by:

- **Activity type**: File access, file copy, print, email send, cloud upload, sharing link creation
- **Workload**: SharePoint, OneDrive, Exchange, Teams, Endpoint devices
- **User**: Specific user principal name (UPN) or user groups
- **Time range**: Narrow to the period around a suspected event
- **Sensitivity labels**: Activities involving specific labels

A DLP alert about sensitive data shared externally becomes an investigation when you filter to that user, that time window, and that label. You then see not just the flagged event but the full sequence of events surrounding it.

Activity explorer is the right starting point when you already have a specific user, time, or event to examine. It's less useful when you're looking for patterns across the organization or trying to understand whether something is an isolated event or a trend.

### AI activities tab

The **AI activities** tab within activity explorer shows events specific to AI interactions. It captures user prompts to AI apps, AI responses that contained or referenced sensitive data, sensitive information types detected during the interaction, DLP rule matches, and references to files accessed.

These events flow from the unified audit log into the AI activities tab in DSPM (preview). The tab exists because AI interactions have a different structure than traditional file operations. A user copying a file to USB is one event. A user prompting Copilot involves a prompt, a data retrieval, a response, and possibly a DLP evaluation, all of which matter when reconstructing what happened.

Use the AI activities tab when your investigation involves AI interactions specifically. If a DLP alert fires during a Copilot session, this surface shows the full interaction context that activity explorer alone doesn't provide.

> [!NOTE]
> Activity explorer in DSPM (preview) is distinct from activity explorer in DSPM for AI (classic). Events in the AI activities tab originate from the preview version specifically. If you're investigating AI-related activity, confirm you're working in DSPM (preview) rather than the classic version.

### Audit logs

The unified audit log captures a chronological record of user and agent interactions, including timestamps, user identity, the exact operation performed, and the result. Where activity explorer shows you filtered views of events, the audit log provides the authoritative compliance-grade record.

For Agent 365 specifically, the audit log captures agent-to-human, human-to-agent, agent-to-tools, and agent-to-agent interactions. This is the only surface that provides the full trace of what an agent did during a specific time window.

Use audit logs when you need:

- A chronological reconstruction of events for formal reporting
- The authoritative record for compliance or legal purposes
- Details about agent interactions not visible in activity explorer
- Correlation between multiple related events across services

The audit log is not the right starting point for exploratory investigation. Its value is precision and authority, not discoverability. Use activity explorer or reports to find what's interesting, then consult the audit log for the definitive record.

### Reports

DSPM reports provide aggregated views across sensitive data usage and posture trends. Navigate to **DSPM (preview)** > **Reports** to access:

- Sensitive data usage patterns over time
- Labeling progress and gaps
- Policy usage and match frequency
- Risky behavior patterns for users and AI agents

Reports answer "is this getting better or worse?" and "where is risk concentrating?" If you notice a rising DLP match rate for a specific sensitive information type, reports help you determine whether it's concentrated in specific workloads, user groups, or time periods before you drill into individual events.

Use reports when you don't yet know what to investigate. A behavioral shift in reports gives you the filter criteria to take into activity explorer. A stable flat line after a policy change tells you the policy might be scoped too narrowly.

## Escalating to Data Security Investigations

Sometimes DSPM investigation surfaces reveal patterns that exceed what filtering and tracing can resolve. Exfiltration patterns that need deeper AI-powered content analysis or collaborative remediation require escalation to Data Security Investigations.

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
