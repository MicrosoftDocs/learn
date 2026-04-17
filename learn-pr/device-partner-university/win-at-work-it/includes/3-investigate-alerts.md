Microsoft Security Copilot is an AI-powered assistant that helps SOC analysts investigate security alerts, summarize activity, and identify potential threats.

> [!IMPORTANT]
> To use Microsoft Security Copilot, you need an eligible Microsoft 365 subscription and access to Copilot features in Microsoft Security. How Copilot functions might depend on your license and permissions.

For the content in this module, an eligible Microsoft 365 Copilot subscription is required. Copilot can pull context from organizational data sources such as Microsoft Entra ID sign-ins, Defender alerts, and related device logs (permissions allowing).

## How Copilot can help

Here’s how Security Copilot can assist during an investigation:

- **Understanding the alert**: Summarize the anomalous sign-in or impossible travel activity.
- **Gathering context**: Retrieve recent sign-ins, device logs, and related alerts for the impacted user.
- **Correlating data**: Identify patterns across users, devices, or alerts to pinpoint suspicious activity.
- **Documenting findings**: Generate summaries or reports of the investigation for escalation or remediation.
- **Suggesting next steps**: Recommend actions, such as monitoring, remediation, or further analysis.

## Create targeted prompts

Be specific with your Copilot prompts to get the best results.

| Prompt Style        | Example |
|--------------------|---------|
| Goal-based          | `Summarize anomalous sign-ins for user <username> in the last 24 hours.` |
| Context-specific    | `Show all devices associated with <username> and their recent sign-ins.` |
| Step guidance       | `Provide a step-by-step investigation checklist for this alert.` |
| Summary request     | `Draft a report highlighting findings and recommended next steps for this alert.` |

> [!TIP]
> Clear, specific prompts help Copilot provide actionable and accurate results. Include relevant details such as usernames, timeframes, and affected devices whenever possible.
