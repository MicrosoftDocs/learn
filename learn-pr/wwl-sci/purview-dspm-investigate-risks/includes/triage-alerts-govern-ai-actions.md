Your cognitive role shifts in this unit. In direct investigation and Security Copilot, you're the investigator examining data or directing AI as a partner. Now you become a supervisor of AI. The DLP triage agent and the Insider Risk Management triage agent analyze alerts, categorize them by priority, and can take automated actions. Your job is to evaluate whether their decisions are correct and their actions are appropriate for your organizational context.

This governance skill is distinct from investigation. You're not tracing what a user did with sensitive data. You're evaluating whether AI's interpretation of what a user did is accurate and whether AI's response was proportionate.

## What triage agents do

Microsoft Purview provides two triage agents:

- **DLP triage agent**: Evaluates DLP alerts based on sensitivity risk, exfiltration risk, and policy risk
- **Insider Risk Management triage agent**: Evaluates IRM alerts based on user risk, file risk, and activity risk

Both agents categorize alerts into groups:

- **Needs attention**: The agent determined this alert poses the greatest risk to your organization
- **Less urgent**: The agent determined this alert poses a lower risk
- **Not categorized**: The agent couldn't successfully triage the alert (server error, in-process, or unsupported activities)

The agents provide explanations for their categorization logic. This transparency is what makes governance possible: you can evaluate whether the reasoning matches your organizational context.

## Evaluating DLP triage agent categorizations

The DLP triage agent is accessible from the DLP solution's **Alerts** page. Switch to the **Triage Agent** view using the toggle at the top right of the page to see agent-triaged alerts grouped by category.

When you select an alert marked "Needs attention," the details panel shows:

- A summary of the alert context
- The risk factors the agent identified (sensitivity of the data, exfiltration indicators, policy severity)
- The reasoning behind the categorization

Your evaluation questions:

- Does the sensitivity assessment match this data's actual importance in your organization? A "Needs attention" categorization for a low-business-impact label might indicate the agent's weighting doesn't match your risk tolerance.
- Does the exfiltration risk reflect your organization's actual threat model? The agent may flag external sharing in an organization where cross-boundary collaboration is normal and expected.
- Are there contextual factors the agent can't see? An alert about a user downloading sensitive files might look urgent, but if that user is in a role that requires regular access to those files, the categorization may be inappropriate.

## Evaluating IRM triage agent categorizations

The IRM triage agent appears on the **Triage Agent** dashboard within Insider Risk Management. Select **Triage Agent** at the top of the dashboard page to view triaged alerts.

For each alert, the agent provides:

- **Agent categorization**: "Needs attention" or "Less urgent"
- **User info**: Alert history, title, organization, and last working date
- **Risk patterns**: A narrative summary of each risk associated with the alert, detailing the risky activity, the sensitive data involved, and the affected files

Select a risk pattern narrative to see:

- **Summary**: What happened, what data was involved, which files were affected
- **Actors**: The device involved and client IP address

Your evaluation questions:

- Does the risk narrative accurately describe the severity of the behavior? IRM signals can vary in importance based on the user's role, the organization's data handling norms, and recent changes (such as a user's impending departure).
- Does the alert history provide context that changes the categorization? A first-time alert might be less urgent, while a pattern of repeated alerts escalates the actual risk beyond what a single-alert analysis shows.
- Is "Less urgent" actually safe to deprioritize? The agent makes a point-in-time assessment. Patterns across multiple "Less urgent" alerts from the same user could indicate an escalating risk the agent hasn't connected.

## Providing feedback on categorizations

When you disagree with an agent's categorization, select **Is this incorrect?** to provide feedback on why the categorization doesn't match your assessment. This feedback improves the agent's future categorization logic for your organization.

Feedback is appropriate when:

- The agent consistently miscategorizes alerts for a specific data type or user role
- Organizational context (which the agent can't access) changes the risk assessment
- The agent's reasoning is based on factors that aren't relevant in your environment

## Reviewing automated actions

Beyond triage categorization, AI agents in DSPM can take direct actions on detected risks. These automated actions may include:

- Removing public sharing links
- Applying DLP policies
- Revoking permissions

These are higher-consequence decisions than categorization. Your governance responsibility includes:

- Reviewing what actions were taken and whether they were proportionate
- Understanding the scope of each action (how many items affected, which users impacted)
- Determining whether the automated response created unintended consequences (legitimate users losing access, business processes disrupted)

Access the audit trail of AI agent actions through the **View agent activity** options available throughout data security objectives. This shows what the agent did, when, and what triggered the action.

## The distinction between triage and automated action governance

These require different governance reasoning:

| Governance task | What you're evaluating | Consequence of error |
|---|---|---|
| Triage categorization | Whether the priority ranking is correct | An important alert gets deprioritized and response is delayed |
| Automated action | Whether the remediation step was appropriate and proportionate | Legitimate access is disrupted, business processes break, or an action is insufficient for the actual risk |

Triage errors affect your attention allocation. Automated action errors affect operations directly. Both require governance, but automated actions demand closer scrutiny because they have immediate real-world impact.

## When to override or escalate

Override a triage categorization when:

- You have organizational context the agent lacks (user is departing, data is less sensitive than the label suggests, the sharing pattern is authorized)
- Multiple data points contradict the categorization (the "Less urgent" alert is part of a weeks-long pattern the agent assesses individually)
- The alert connects to a broader investigation you're already conducting

Escalate beyond DSPM governance when:

- Automated actions need to be reversed and you lack the permissions
- The pattern suggests the triage agent's configuration needs adjustment (repeated miscategorizations indicate a systemic issue)
- The automated action created compliance implications that require legal or HR involvement

Governance is an ongoing calibration. As your organization changes, the triage agents' assessments may need recalibration. Regular review of categorization accuracy and automated action outcomes helps you maintain appropriate oversight without creating bottlenecks.
