Defender for Cloud detects suspicious activity across your AI workloads, containers, and data services. When those detections are correlated with other identity, endpoint, or data signals, they appear as incidents in **Microsoft Defender XDR**.

Defender XDR provides a unified view of your organization's security posture, bringing together alerts from multiple Defender solutions, including those related to AI workloads. By investigating incidents here, you can see how a potential AI attack fits into a broader pattern of activity. You can also review captured prompt segments that show what triggered the alert.

## View AI incidents in Microsoft Defender XDR

AI-related alerts from Defender for Cloud automatically surface in Defender XDR as part of correlated incidents. These incidents can include threats such as prompt injections, data exfiltration, or misuse of model endpoints.

To view AI incidents:

1. In the **[Microsoft Defender portal](https://security.microsoft.com)**, expand **Investigation & response** > **Incidents & alerts** , then select**Incidents**.
1. Use the **Filter** option and select **Service/detection source**.
1. Set the filter for **Microsoft Defender for Cloud** > **Microsoft Defender for AI Services**.

   :::image type="content" source="../media/xdr-defender-ai-filter.png" alt-text="Screenshot showing the Service source filter in Microsoft Defender XDR with Microsoft Defender for AI Services selected." lightbox="../media/xdr-defender-ai-filter.png":::

1. Review the filtered alerts to identify incidents related to AI workloads and prompt activity.

   :::image type="content" source="../media/xdr-incident-list-filtered.png" alt-text="Screenshot of the Microsoft Defender portal showing incidents filtered by Microsoft Defender for Cloud, with AI-related alerts included in the list." lightbox="../media/xdr-incident-list-filtered.png":::

Selecting an incident opens a detailed view with correlated alerts, affected assets, and timeline data. This view helps you understand whether an AI security alert is isolated or part of a larger attack pattern.

## Review prompt segments in Defender XDR

Some AI-related alerts include captured **prompt segments** that show the input associated with suspicious model activity, such as an attempted prompt injection or data exfiltration request. These segments appear in both **Defender for Cloud** and **Microsoft Defender XDR** as part of the alert's evidence details.

In Defender XDR:

1. Open an AI-related alert within an incident.
1. On the **Alerts** tab, select a specific alert, for example a jailbreak alert.
1. In the alert details, under the **Activities** section, select **Related activities**.
1. Choose an event, then review the **Prompt Suspicious Segment** field in the **Related activity event details** pane.

   :::image type="content" source="../media/xdr-prompt-suspicious-segment.png" alt-text="Screenshot showing the Related activity event details pane in Microsoft Defender XDR with a Prompt Suspicious Segment field displaying captured prompt text from an AI alert." lightbox="../media/xdr-prompt-suspicious-segment.png":::

   This view displays the captured prompt text or API payload that led to the detection. Use it to confirm whether a model received a malicious prompt, an unexpected API request, or an attempt to extract sensitive data.

## Investigate and respond to incidents

From the **Incident details** page, you can continue investigating related alerts, review affected entities, and manage the incident's lifecycle. These actions help coordinate response efforts and maintain visibility across your environment.

To manage an incident:

1. Select **Manage incident** at the top of the incident page.
1. In the **Manage incident** pane, update fields such as:

   - **Severity**: Adjust to reflect impact or urgency.
   - **Assign to**: Specify an owner for follow-up.
   - **Status**: Track progress as _Active_, _In Progress_, or _Resolved_.
   - **Classification**: Mark whether the incident is a _True positive_, _Informational, expected activity_, or _False positive_.
   - **Incident tags**: Add context for filtering or reporting.

   :::image type="content" source="../media/xdr-manage-incident.png" alt-text="Screenshot showing the Manage incident pane in Microsoft Defender XDR with fields to update severity, assignment, status, and classification." lightbox="../media/xdr-manage-incident.png":::

You can also use other tabs, such as **Evidence and Response** or **Alerts**, to explore correlated signals and supporting data that explain how the incident unfolded.

These capabilities let you investigate and respond to AI-related alerts in the same way as other Defender incidents, maintaining a consistent and structured response process across all workloads.

Together, Defender for Cloud and Defender XDR give you end-to-end visibility into AI threats, from runtime detections to incident investigation and response.
