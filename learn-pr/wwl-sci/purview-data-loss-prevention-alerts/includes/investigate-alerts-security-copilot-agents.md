Investigating data loss prevention (DLP) alerts often involves sorting through large volumes of activity to find what matters most. The Microsoft Purview DLP triage agent, powered by Microsoft Security Copilot, automates that process. It reviews alerts, prioritizes those with the highest potential risk, and surfaces the ones that need attention first.

In a typical week, a DLP policy might generate alerts for external file shares, email attachments, and cloud uploads. Most are low risk. A few contain sensitive financial data that needs immediate review. Rather than opening each one to make that determination manually, the triage agent analyzes content, assesses policy risk, and ranks alerts by severity. Security Copilot then summarizes context and suggests next steps.

## Understand how the DLP triage agent works

The DLP triage agent uses AI to evaluate and prioritize alerts that your DLP policies generate in Microsoft Purview. It examines content, policy actions, and potential exfiltration behavior to identify which alerts pose the greatest risk.

You can fine-tune how the agent interprets alerts by writing custom instructions in plain language. For example:

> Focus on alerts containing tax or finance information with more than five credit card or Social Security numbers.

When configured, the agent can:

- Interpret your instructions and convert them into logical conditions
- Prioritize alerts that meet those conditions
- Apply your criteria automatically each time it runs
- Allow manual reruns or adjustments when needed

The agent handles the sorting, but you still decide what to act on.

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

Alerts most likely to involve sensitive data exposure rise to the top.

## Run the DLP triage agent

The agent must be deployed and configured before you can use it. Deployment involves provisioning Security Compute Units (SCUs), enabling the Purview plugin in Security Copilot, and assigning an agent identity. For full setup steps, see [Get started with the Microsoft Purview Triage Agent in Data Loss Prevention](/purview/copilot-in-purview-triage-dlp-agent-get-started?azure-portal=true).

To view and act on triaged alerts, you need the Information Protection Analyst or Investigator role, Purview Agent Analysis, and Security Copilot Contributor. For device-based alerts, the Data Classification Content Viewer and Content Downloader roles are also required.

Once the agent is deployed, it can run in two modes:

- **Automatically**, on a fixed schedule, to continuously review alerts from a selected timeframe
- **Manually**, on one alert at a time, when you want to evaluate a specific case more closely

The timeframe controls how far back the agent looks. You can set it to cover the past 24 hours up to 30 days. When running automatically, it processes existing alerts in that window and triages new ones as they appear.

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

- The agent triages alerts from **Exchange, SharePoint, OneDrive, Teams, and devices (Endpoint)**. For device alerts, [evidence collection for file activities on devices](/purview/dlp-copy-matched-items-learn?azure-portal=true) must be enabled.
- Alerts triggered solely by **custom sensitive information types** or **custom trainable classifiers** aren't included.
- Files larger than **2 MB** aren't analyzed.
- When an alert includes more than 10 files, the agent analyzes the 10 most relevant based on policy matches and risk score.
- Simulation-mode policies and administrative unit scoping aren't supported.

For alerts that aren't fully triaged, continue your investigation in the standard DLP Alerts dashboard or Microsoft Defender XDR.
