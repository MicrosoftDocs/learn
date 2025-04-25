Downloading multiple files to an unmanaged device might trigger a policy violation. But what if the same user also shared sensitive documents externally or bypassed a policy warning earlier that day? Viewing alerts one at a time can make it hard to spot these broader patterns. Microsoft Defender XDR helps security teams connect the dots by grouping related alerts into incidents and surfacing risky behavior across data sources.

## Why use Microsoft Defender XDR to investigate data loss prevention alerts?

Microsoft Defender XDR helps you move from isolated alerts to a broader view of incidents. Defender XDR:

- Automatically correlates related data loss prevention (DLP) alerts into incidents
- Extends investigation capabilities across endpoints, email, cloud apps, and identities
- Enables response actions like disabling accounts or revoking access

If your organization needs a central view of data risk signals and security events, Microsoft Defender XDR brings that visibility together.

## Licensing and permissions

To investigate DLP alerts in Microsoft Defender XDR or Microsoft Sentinel, your organization must have eligible Microsoft 365 licensing. Most capabilities are available to organizations with Microsoft 365 E5 or equivalent compliance licensing.

Role-based access control also applies. Users must be assigned appropriate Defender or compliance roles to view and act on DLP incidents.

## Investigate alerts in Defender XDR

### Step 1: Open the incidents queue

1. Go to the [Microsoft Defender portal](https://security.microsoft.com).
1. In the left navigation pane, select **Incidents & alerts** > **Incidents**.
1. Use the **Service/detection source** filter to select **Data Loss Prevention**.

:::image type="content" source="../media/investigate-alert-defender.png" alt-text="Screenshot showing the Microsoft Defender XDR filtering for data loss prevention alerts." lightbox="../media/investigate-alert-defender.png":::

This view shows incidents that include one or more DLP alerts. Each incident can contain multiple related alerts grouped together.

## Step 2: Investigate a DLP alert

After an incident is identified in the queue, the next step is to examine the details of an individual alert. This helps you confirm what happened, determine whether the alert is valid, and decide what to do next.

- Review the **Alert story** to understand what triggered the policy match.
- Use the **Related events** section to explore user activity like downloads, shares, or overrides.
- Open the **Sensitive info types** tab to see what types of sensitive content were detected.
- If permissions allow, access the **Source tab** to inspect the file involved in the alert.

You can copy the summary, regenerate it, or open the Security Copilot pane for deeper insights. The summary includes:

- Alert title and severity
- Matched policy and rule
- File details and access path
- User identity and associated activities

You can copy or refresh the summary, or open it in the Security Copilot pane for more context.

:::image type="content" source="../media/investigate-alert-defender.png" alt-text="Screenshot showing the Microsoft Defender XDR alert details page with attack story and Security Copilot pane." lightbox="../media/investigate-alert-defender.png":::

### Step 3: Take response actions

Based on your investigation, you can take action directly from the alert view:

- **Download email** (for Exchange alerts)
- **Apply sensitivity label**, **Unshare**, **Delete**, or **Download** (for SharePoint or OneDrive files)
- **Apply retention label**
- **Send email notification**
- **Withdraw feedback** if the alert was marked incorrectly

To respond at the user level, select the **User card** to view profile details and take actions like resetting passwords or disabling accounts.

For device-based DLP alerts, select the **Device card** to view device details and isolate or manage the device.

### Step 4: Manage the incident

To complete incident handling, return to the incident summary page and select **Manage incident**. You can:

- Set the incident **Severity**
- Add or create **Incident tags**
- Assign the incident to an analyst or response team
- Update the **Status** to reflect progress (for example: In Progress, Resolved)
- Choose a **Classification**, such as True Positive or False Positive, and specify a reason (like Malicious user activity or Security testing)

:::image type="content" source="../media/defender-manage-incident.png" alt-text="Screenshot showing the Manage incident flyout page in Microsoft Defender." lightbox="../media/defender-manage-incident.png":::

These fields help organize and close out the investigation for future reference and auditing.

## Use advanced hunting for deeper investigation

Advanced hunting lets you query user, file, and activity data across workloads using the **CloudAppEvents** table. This table contains audit logs from across Microsoft 365 workloads, including:

- Exchange
- SharePoint
- OneDrive
- Devices

To start hunting:

1. In the Defender portal, select **Advanced hunting**.
1. Use a built-in query, or select **Go Hunt** from an event in the alert details.
1. Defender provides contextual queries based on the event source, such as:
   - File shared with
   - File activities
   - Site activity
   - User DLP violations (last 30 days)

You can run, customize, or save the query to track related activity.

## Extend your investigation with Microsoft Sentinel

While Defender XDR offers deep alert-level investigation, Microsoft Sentinel adds cross-platform correlation and automation. Microsoft Sentinel can bring DLP insights into broader investigations and workflows alongside other Microsoft and non-Microsoft data sources.

If your organization uses Microsoft Sentinel, you can integrate DLP alerts from Microsoft Defender XDR into Microsoft Sentinel for:

- Cross-platform investigation
- Custom correlation rules
- Automated response using SOAR (security orchestration, automation, and response)

To get started:

1. Use the [Microsoft Defender XDR connector](https://learn.microsoft.com/azure/sentinel/connect-microsoft-365-defender) in Microsoft Sentinel to import DLP alerts and incidents.
1. Enable the **CloudAppEvents** connector to ingest audit logs.
1. Use KQL queries in Microsoft Sentinel to correlate alerts and investigate root causes.

Example query:

```kusto
let Alert = SecurityAlert
| where TimeGenerated > ago(30d)
| where SystemAlertId == "INSERT_ALERT_ID"; // insert the systemAlertID here
CloudAppEvents
| extend correlationId1 = parse_json(tostring(RawEventData.Data)).cid
| extend correlationId = tostring(correlationId1)
| join kind=inner Alert on $left.correlationId == $right.AlertType
| where RawEventData.CreationTime > StartTime and RawEventData.CreationTime < EndTime
```

This query identifies activity related to a specific alert using the **CloudAppEvents** table.

Microsoft Defender XDR helps security teams respond to data loss incidents by grouping alerts, enriching them with context, and enabling fast investigation. With integrated advanced hunting and response actions, DLP alert handling becomes part of a broader security operations workflow.

Whether you're managing alerts in Microsoft Defender or extending your investigation with Microsoft Sentinel, these tools help bring clarity to complex data loss events. With capabilities for alert correlation, activity analysis, and automated response, security teams can act faster and with greater confidence to reduce data risk.
