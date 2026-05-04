After you enable the Defender for AI Services plan, you need a way to confirm protection is active and verify that alerts are flowing. The Data and AI security dashboard in Microsoft Defender for Cloud provides that visibility across both data resources and AI workloads in a single view.

> [!NOTE]
> Full access to the Data and AI security dashboard requires more than the AI services plan alone. The dashboard's data sections are populated by **Defender CSPM** (with the sensitive data discovery extension enabled), **Defender for Storage**, and **Defender for Databases**. The AI sections populate when the AI services plan is enabled. Without the other plans, the dashboard opens but shows partial data. The minimum required role to view the dashboard is **Security reader**.

## Navigate to the Data and AI security dashboard

To access the dashboard, navigate to **Microsoft Defender for Cloud** in the Azure portal and select **Data and AI security** from the left navigation menu.

The dashboard has four sections:

| Dashboard section | What it shows |
|---|---|
| **Data and AI security overview** | All data and AI resources across your subscriptions, with protection status by plan (Defender Cloud Security Posture Management (CSPM), Defender for Storage, Defender for Databases, AI threat protection) |
| **Top issues** | Highest-severity alerts, recommendations, and attack paths that need immediate attention |
| **Data closer look** | Sensitive data findings, storage and database alerts, security explorer queries, and internet-exposed data resources |
| **AI closer look** | AI resource discovery, AI threat protection metrics (prompts scanned, alerts by severity), AI security explorer queries, and internet-exposed grounding resources |

:::image type="content" source="../media/data-ai-security-dashboard-layout.png" alt-text="Data and AI security dashboard in Microsoft Defender for Cloud showing the overview, top issues, data, and AI sections." lightbox="../media/data-ai-security-dashboard-layout.png":::

## Verify AI protection status

The **Data and AI security overview** section shows your full data and AI estate. For each resource, you can see protection status: fully protected, partially protected, or unprotected across the relevant plans. AI services resources that have the Defender for AI Services plan enabled appear as protected for AI threat protection.

Start by confirming that every subscription hosting Azure AI services workloads shows AI threat protection as active. Resources in subscriptions without the plan enabled have no AI threat detection—even if Defender for Servers, Storage, or other plans are active on that subscription. If you discover a gap, navigate directly to that subscription's Environment settings to enable the plan.

> [!TIP]
> Bookmark the Data and AI security dashboard as part of your regular security review cadence. Checking protection status weekly ensures new subscriptions provisioned for AI workloads don't go unprotected.

## Review AI threat protection alerts

The **AI closer look** section is the starting point for reviewing AI threat protection activity. It shows the total number of prompts scanned and all alerts detected, grouped by severity. Select an alert from the alert count or navigate to the Defender for Cloud alerts view to see full alert details, including:

- **Alert title and severity** - the threat category and risk level
- **Affected resource** - the Azure AI services resource where the threat was detected
- **Prompt evidence** - if suspicious prompt evidence is enabled, the redacted prompt or response snippet that triggered the detection
- **Recommended actions** - investigation steps specific to the alert type

Alerts also flow into Microsoft Defender XDR, where they correlate into incidents alongside identity and endpoint signals. The security engineer's role is to confirm alerts are flowing, verify severity classifications are appropriate, and configure notification rules—the detailed investigation and response work falls to the SOC team.

## Confirm alert delivery and structure

When an alert fires, your job is to confirm it reached the right tools and contains the fields a SOC analyst needs to act. Open the [Microsoft Defender portal](https://security.microsoft.com) and navigate to **Incidents and alerts** > **Alerts**, then filter by **Service source: Microsoft Defender for Cloud**. AI threat protection alerts appear here tagged with their source resource and threat category.

If your organization routes Defender for Cloud alerts to Microsoft Sentinel, verify the alert also appears in the Microsoft Sentinel **Incidents** view. Alerts flow from Defender XDR to Microsoft Sentinel through the Microsoft Defender XDR data connector—if AI alerts are missing from Microsoft Sentinel, confirm that connector is active.

Select an alert and verify it contains the following fields:

- **Alert title and severity** - confirms the threat category and risk level were classified correctly
- **Affected resource** - identifies the specific Azure AI services resource where the detection occurred
- **Prompt evidence** - if suspicious prompt evidence is enabled, this field shows a redacted snippet of the user prompt or model response that triggered the detection; if this field is empty, return to Environment settings and enable the prompt evidence toggle
- **Recommended actions** - the investigation steps Defender for Cloud surfaces for this alert type, which the SOC team uses to begin their response

When the SOC team confirms an alert is a false positive—such as from a penetration test or an authorized red team exercise—set the alert **Classification** to **False positive** in the Defender portal and add a comment. You can also create suppression rules in Defender for Cloud to automatically suppress recurring false positives from specific resources, reducing noise for the SOC team.

## Configure alert notifications

To ensure the security team is aware of high-severity AI threats promptly, configure email notifications for AI-related alerts. In Microsoft Defender for Cloud, navigate to **Environment settings** > select the subscription > **Email notifications**. Configure the notification recipients and severity threshold. For AI workloads, set the threshold to **High** severity at minimum so the team is notified of jailbreak attempts and data leakage events.

You can also configure alert rules in Microsoft Defender XDR to route AI-specific incidents to dedicated response queues or Microsoft Sentinel playbooks for automated triage.

## Apply monitoring to Contoso's scenario

Contoso's security engineer adds the Data and AI security dashboard to the team's weekly security review. During the first review, the Data and AI security overview section confirms both Foundry subscriptions show AI threat protection as active. The AI closer-look section shows zero alerts in the first week, confirming detection is running but no threats fired. The engineer configures email notifications for high-severity alerts on both subscriptions, with the security operations team as the recipient group. When a jailbreak attempt alert fires two days later against the document analysis model, the SOC team receives the notification, reviews the prompt evidence in Defender XDR, and confirms it was a penetration test conducted by the red team—no action required. The alert validates that detection is working end-to-end.
