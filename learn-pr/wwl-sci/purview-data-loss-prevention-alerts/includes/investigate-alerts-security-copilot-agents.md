Investigating data loss prevention (DLP) alerts often involves sorting through large volumes of activity to find what matters most. The Microsoft Purview DLP triage agent, powered by Microsoft Security Copilot, helps automate that process. It reviews alerts, prioritizes those with the highest potential risk, and helps analysts focus on what needs attention first.

Imagine you're reviewing several alerts from employees sharing files externally. Some are harmless, but others might contain sensitive financial data. Instead of checking each alert manually, you can enable the DLP triage agent to analyze content, assess policy risk, and surface the alerts that require immediate review. You can then use Security Copilot to summarize context and guide your next steps.

## Understand how the DLP triage agent works

The DLP triage agent uses AI to evaluate and prioritize alerts that your DLP policies generate in Microsoft Purview. It examines content, policy actions, and potential exfiltration behavior to identify which alerts pose the greatest risk.

You can fine-tune how the agent interprets alerts by writing custom instructions in plain language. For example:

> Focus on alerts containing tax or finance information with more than five credit card or Social Security numbers.

When configured, the agent can:

- Interpret your instructions and convert them into logical conditions
- Prioritize alerts that meet those conditions
- Apply your criteria automatically each time it runs
- Allow manual reruns or adjustments when needed

This approach reduces time spent on manual triage while keeping analysts in control of prioritization and decision-making.

## Interpret triaged alerts in Microsoft Purview

After the agent runs, you can interpret the triaged alerts to understand which incidents need attention first and why. You'll see the results in the **Alert triage agent (preview)** view on the **Alerts** page.

The agent automatically groups triaged alerts into categories:

- **Needs attention**: Alerts that present the highest risk and should be reviewed first
- **Less urgent**: Alerts that appear lower in severity or likelihood of data loss
- **Not categorized**: Alerts the agent couldn't evaluate, such as those triggered by unsupported policy types

:::image type="content" source="../media/data-loss-prevention-triage-agent-alerts-view.png" alt-text="Screenshot showing the Alert Triage Agent view in Microsoft Purview with prioritized DLP alerts." lightbox="../media/data-loss-prevention-triage-agent-alerts-view.png":::

Alerts are prioritized using three main factors:

- **Content risk**: Sensitive information types, trainable classifiers, or sensitivity labels detected in files
- **Exfiltration risk**: Activities that suggest data movement outside approved channels, such as external sharing or downloads
- **Policy risk**: Rule mode and actions, including whether a label was removed or downgraded

This prioritization helps analysts focus on the alerts most likely to involve sensitive data exposure.

## Run the DLP triage agent

Before running the agent, confirm that you have the required roles and licensing:

- **Roles**: Information Protection Analyst or Investigator, Purview Content Analyst, Data Classification Content Download (for device DLP alerts), and Security Copilot Contributor
- **Licensing**: Microsoft Purview Data Loss Prevention and provisioned **Security Compute Units (SCUs)** for the agent to run
- **Configuration**: Your tenant must be onboarded to Microsoft Security Copilot with the **Purview plugin** enabled

Agents run under the security context of the user who last saved the configuration. This context must be renewed every 90 days.

You can set the agent to run automatically or manually:

- **Automatically**, on a fixed schedule, to continuously review alerts from your selected timeframe
- **Manually**, on one alert at a time, when you want to review a specific case more closely

You can choose how far back the agent looks, such as the past 24 hours, 7 days, or 30 days. When running automatically, it processes existing alerts in that window and triages new ones as they appear.

The agent only triages alerts from **active DLP policies**. Alerts from policies in **simulation mode** aren't included.

## Use Security Copilot to analyze triaged alerts

After the agent runs, switch to the **Alert triage agent (preview)** view to see how alerts are grouped and prioritized. You can open Security Copilot directly from an alert to summarize findings, review context, or get suggestions for next steps.

Security Copilot can help you:

- Summarize why the alert was triggered and prioritized
- Highlight sensitive data and potential exfiltration risks
- Correlate activity across SharePoint, OneDrive, Exchange, and Teams
- Recommend next actions for investigation or remediation

You can ask Copilot for specific help, such as:

- _Explain why this alert was marked as high risk._
- _Summarize the user's recent activity related to this file._
- _Identify whether this alert is part of a broader data exfiltration pattern._

After reviewing summaries and suggested actions, you can return to the triaged alert queue to take direct action on alerts that require further attention.

## Review and act on triaged alerts

Once alerts are triaged, review the prioritized queue to decide what comes next:

1. In the Microsoft Purview portal, go to **Data Loss Prevention** > **Alerts**.
1. In the upper-right corner, switch to **Alert triage agent (preview)** view.
1. Review **Needs attention** alerts first.
1. Select an alert to open the **Agent summary** pane and review the agent's categorization and triage notes.
1. Use **Summarize** to generate an AI summary of the alert or user activity if you need more context.
1. Select **View details** or update the alert as needed, for example by assigning it or notifying users.

   :::image type="content" source="../media/data-loss-prevention-triage-agent-summary.png" alt-text="Screenshot showing the Agent summary pane in Microsoft Purview with DLP alert categorization and triage notes." lightbox="../media/data-loss-prevention-triage-agent-summary.png":::

You can rerun the agent on a single alert if conditions change or you need a new evaluation.

## Limitations and supported scenarios

- The agent currently triages alerts from **Exchange, SharePoint, OneDrive, and Teams** only.
- Alerts triggered solely by **custom sensitive information types** or **custom trainable classifiers** aren't included.
- Files larger than **2 MB** aren't analyzed.
- When an alert includes more than 10 files, the agent analyzes the 10 most relevant based on policy matches and risk score.
- Simulation-mode policies and administrative unit scoping aren't supported.

For alerts that aren't fully triaged, continue your investigation in the standard DLP Alerts dashboard or Microsoft Defender XDR.

Security Copilot helps you identify and resolve data risks faster while keeping full control over every decision.
