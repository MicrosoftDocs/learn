When a single user downloads multiple files to an unmanaged device, that might be a policy violation. But what if they also shared sensitive documents externally or bypassed a policy warning earlier in the day? Viewing alerts one at a time can make it hard to see the bigger picture. Microsoft Defender XDR helps security teams by grouping DLP alerts into incidents, correlating them across sources, and surfacing suspicious patterns.

## Why use Microsoft Defender XDR to investigate DLP alerts?

Microsoft Defender XDR helps you move from isolated alerts to a broader view of incidents. Defender XDR:

- Automatically correlates related DLP alerts into incidents
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

When you open a DLP incident, select an individual alert to investigate. From the alert details view, you can:

- Review the **Alert story** to understand what triggered the alert, including the matched policy and detected sensitive information types
- Explore the **Related Events** section to examine user activity, such as downloads or shares
- View the **Sensitive info types** tab to see what types of sensitive data were involved
- If permissions allow, use the **Source** tab to review the file involved in the alert

If your tenant has access to Security Copilot (preview), select **Summarize** to generate an AI-based alert summary. This summary includes:

- Alert title and severity
- Matched policy and rule
- File details and access path
- User identity and associated activities

You can copy or refresh the summary, or open it in the Security Copilot pane for additional context.

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

To complete incident handling, return to the incident summary page and select **Manage Incident** to:

- Add tags
- Assign ownership
- Set the incident status

## Use advanced hunting for deeper investigation

Advanced hunting lets you query user, file, and activity data across workloads using the **CloudAppEvents** table. This table includes logs from:

- Exchange
- SharePoint
- OneDrive
- Devices

To start hunting:

1. In the Defender portal, select **Advanced hunting**.
2. Use a built-in query, or select **Go Hunt** from an event in the alert details.
3. Defender provides contextual queries based on the event source, such as:
   - File shared with
   - File activities
   - Site activity
   - User DLP violations (last 30 days)

You can run, customize, or save the query to track related activity.

## Extend your investigation with Microsoft Sentinel (optional)

If your organization uses Microsoft Sentinel, you can integrate DLP alerts from Defender XDR into Sentinel for:

- Cross-platform investigation
- Custom correlation rules
- Automated response using SOAR (security orchestration, automation, and response)

To get started:

1. Use the [Microsoft Defender XDR connector](https://learn.microsoft.com/azure/sentinel/connect-microsoft-365-defender) in Microsoft Sentinel to import DLP alerts and incidents.
2. Enable the **CloudAppEvents** connector to ingest audit logs.
3. Use KQL queries in Sentinel to correlate alerts and investigate root causes.

### Example query

```kusto
let Alert = SecurityAlert
| where TimeGenerated > ago(30d)
| where SystemAlertId == "INSERT_ALERT_ID";
CloudAppEvents
| extend correlationId1 = parse_json(tostring(RawEventData.Data)).cid
| extend correlationId = tostring(correlationId1)
| join kind=inner Alert on $left.correlationId == $right.AlertType
| where RawEventData.CreationTime > StartTime and RawEventData.CreationTime < EndTime
```

This query identifies activity related to a specific alert using the **CloudAppEvents** table.

## Summary

Microsoft Defender XDR helps security teams respond to data loss incidents by grouping alerts, enriching them with context, and enabling fast investigation. With integrated advanced hunting and response actions, DLP alert handling becomes part of a broader security operations workflow.

For extended correlation and automation, DLP alerts can be imported into Microsoft Sentinel. Whether you investigate in Defender or Sentinel, both tools give you the visibility and control needed to reduce data risk.
