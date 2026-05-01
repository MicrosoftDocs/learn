The dashboard, objectives, and asset explorer each show a dimension of posture at a point in time. Reports go deeper, surfacing trends, coverage details, policy deployment status, and user-level activity patterns. Together, these signals show whether posture is improving, stalling, or eroding. Data Security Posture Management (DSPM) adds new reports over time. What matters is knowing how to find the right one, how to read it, and how to reason about what the data means.

## Start with the question, not the report

The **Reports** page in DSPM presents a library of report cards, each focused on a specific security concern. Rather than browsing through every report, start with category filters to narrow the view to what you're investigating.

Six category tags map to the core questions DSPM reports are designed to answer:

| Category | What it helps you assess |
| --- | --- |
| **Exfiltration** | Is sensitive data leaving the organization, and where? |
| **Oversharing** | Is sensitive data exposed to broader access than it should have, including through AI tools? |
| **AI** | How are AI tools interacting with sensitive data, and are those interactions governed? |
| **Data discovery** | Where does sensitive data exist, and how well is it identified? |
| **Labeling Protection** | Are sensitivity labels applied consistently, and are autolabeling policies effective? |
| **Data Loss Protection** | Which data loss prevention (DLP) policies are active, and are they covering the right workloads? |

Reports can carry more than one tag. A report tagged both **Oversharing** and **AI** addresses AI-related oversharing specifically. If you're investigating whether Copilot interactions expose sensitive data, filtering to AI and Oversharing together narrows the list quickly.

Identify the security question first, then use the category filters to find the report that answers it. As DSPM adds new reports over time, this approach scales in a way that memorizing a report catalog doesn't.

## Recognize common report structures

Once you open a report, you'll find familiar building blocks across most of them. Recognizing these structures means you can read any DSPM report effectively, even one you haven't seen before.

**Key metrics cards** appear near the top of most reports. Each card highlights a single measure, like unique users involved in DLP policy triggers or total autolabeled items. A 7-day trend indicator next to the measure shows percentage change. Read these first to determine whether the metric is improving or declining.

**Trend charts** show activity patterns over 30 days, broken down by app, workload, or policy type. Look for spikes, sustained upward or downward movement, and flat lines. A flat line after a new policy deployment signals the same finding a spike would. It indicates the policy isn't reaching the content or workloads it was scoped to.

**Coverage breakdowns** show how completely a control is deployed. An auto-labeling report shows how many policies are enforced versus still in simulation. A Copilot report shows how much scanned data carries sensitivity labels versus how much is unlabeled. Gaps between "identified" and "protected" are the most actionable findings here.

**Detail tables** list the individual policies, users, assets, or activities behind the aggregated numbers. When a metric card shows an unexpected value, the detail table is where you find the specifics.

## Reason about what the data tells you

The same data can mean different things depending on context. Three patterns come up repeatedly across DSPM reports, and recognizing them helps you draw the right conclusions.

### Trends that confirm or contradict your actions

When you deploy a policy or expand labeling coverage, the corresponding trend should respond. A declining trend in unprotected sensitive data interactions after a labeling push confirms progress. A flat or rising trend after the same action means something didn't work as expected. The policy scope is too narrow, or the content it targets doesn't match what's actually at risk.

Compare trends across related areas. Picture AI interaction volume dropping while unprotected data exposure rises. That divergence means the organization is making progress on AI governance but falling behind on broader data protection, and it affects how you prioritize next steps.

### Coverage gaps between intent and enforcement

Coverage reports frequently reveal a gap between policies that exist and policies that protect. A DLP policy list might show several policies in Testing mode, monitoring without blocking. An autolabeling report might show policies still in simulation rather than enforcement. These aren't failures, but they're gaps between what the organization intends and what it currently enforces.

When you see policies in test or simulation states, the question isn't whether they should all be enforced immediately. It's whether the ones that matter most for your highest-risk areas are enforced. Connect what you see in coverage reports back to the priority gaps identified through objectives and asset explorer.

### Activity concentration versus distribution

Some reports surface user-level data, like which users trigger DLP policies most frequently or who performs the riskiest activities on sensitive assets. The distinction that matters is whether risky activity is concentrated in a few accounts or spread broadly.

Concentrated activity in a few accounts points to a specific workflow, role, or behavioral pattern that needs targeted investigation. Broadly distributed activity suggests a systemic issue, like policies that are too permissive or sensitive data that's too widely accessible.

## Connect reports to the broader assessment

Reports add depth to what's already visible on the dashboard, in objectives, and in asset explorer. A DLP coverage report shows exactly which workloads lack active policies behind a low data protection score. An AI-focused report breaks down an accelerating Copilot risk by interaction type and shows which apps or users are driving it. Reports identify the workloads, policies, users, or trends behind a gap surfaced elsewhere.

DSPM also includes **data risk assessments** under **Discover > Data risk assessments**, which surface oversharing risk at the SharePoint site level. Findings from those assessments validate the oversharing signals shown in objectives and reports.
