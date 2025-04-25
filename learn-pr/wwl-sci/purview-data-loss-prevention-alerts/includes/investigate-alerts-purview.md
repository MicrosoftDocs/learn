The data loss prevention (DLP) **Alerts dashboard** in Microsoft Purview helps security teams review the details of policy matches, analyze user behavior, and take appropriate actions.

## Where DLP alerts appear

Alerts appear in the **Microsoft Purview Alerts dashboard** when a user action matches a DLP policy condition. The dashboard provides a centralized view of recent alerts and supports filtering, investigation, and triage actions.

By default, alerts remain in the dashboard for **30 days**. If your organization needs longer visibility, audit log retention settings can be adjusted separately in the Microsoft Purview Audit solution.

## Workloads supported

The dashboard displays alerts from DLP policies configured across:

- Exchange email
- SharePoint sites
- OneDrive accounts
- Teams chat and channel messages
- Devices
- Instances
- On-premises repositories
- Fabric and Power BI

## Review and investigate alerts

To begin an investigation, go to the [Microsoft Purview portal](https://purview.microsoft.com/) and go to **Data loss prevention** > **Alerts**. The dashboard shows all recent DLP alerts. You can filter and customize the view to focus on what matters most.

### Step 1: Filter and find relevant alerts

Use the **Filters** panel to narrow down alerts by policy name, severity, user, alert status, or detection time. You can also select **Customize columns** to show or hide specific properties in the list view.

Once you locate an alert you want to investigate, select it to open the alert details.

:::image type="content" source="../media/data-loss-prevention-alerts-dashboard.png" alt-text="Screenshot showing Alerts dashboard in data loss prevention." lightbox="../media/data-loss-prevention-alerts-dashboard.png":::

### Step 2: Review the alert details

When you select an alert, the **Details** tab opens by default. This view shows key metadata, such as:

- Alert ID
- Status
- Severity
- Detection timestamp
- Matched policy and rule

You can also see the workload where the match occurred, such as Exchange, SharePoint, or OneDrive.

:::image type="content" source="../media/data-loss-prevention-alerts-details.png" alt-text="Screenshot showing the details of a data loss prevention alert." lightbox="../media/data-loss-prevention-alerts-details.png":::

### Step 3: View related user activity

If your organization has integrated **Insider Risk Management**, the **User activity summary** tab becomes available. This summary tab provides all the exfiltration activities the user engaged in (up to the past 120 days). It helps analysts identify whether the alert is part of a larger pattern of risky behavior.

:::image type="content" source="../media/data-loss-prevention-activity-summary.png" alt-text="Screenshot showing user activity summary in a data loss prevention alert." lightbox="../media/data-loss-prevention-activity-summary.png":::

### Step 4: Review matched events

You can select **View events** on the **Details** tab, or go to the **Events** tab and select the event directly. This shows a list of actions that matched the DLP policy.

From this view, you can:

- Review detailed metadata such as the file name, location, size, and timestamp
- Confirm whether the user received and overrode a policy tip
- Understand what triggered the alert based on the policy rule that matched

To respond to the event, select **Actions**. From the **Actions** dropdown, you can:

- Download the matched content (requires appropriate role)
- Apply or remove a sensitivity label (if permitted)
- Unshare or delete the file
- Send a notification email
- Copy event link to share with someone else in your organization

  :::image type="content" source="../media/data-loss-prevention-alert-events.png" alt-text="Screenshot showing the Events page of a data loss prevention alert." lightbox="../media/data-loss-prevention-alert-events.png":::

### Step 5: Complete the investigation

After reviewing the alert and any related user activity or events:

- Use the **Overview** panel to summarize what occurred and who was involved
- Add notes or comments
- Assign ownership if needed
- Set the alert **Status** to **Resolved** when the investigation is complete

  :::image type="content" source="../media/data-loss-prevention-alert-overview.png" alt-text="Screenshot showing the Overview page of a data loss prevention alert." lightbox="../media/data-loss-prevention-alert-overview.png":::

## Use Microsoft Security Copilot

Security Copilot is integrated into the DLP Alerts dashboard for organizations with access to the preview feature. It provides AI-generated summaries of alert context, including:

- Triggered policy and rule
- File involved and access path
- User identity and associated Insider Risk level
- Suggested follow-up actions

  :::image type="content" source="../media/data-loss-prevention-alert-security-copilot.png" alt-text="Screenshot showing the Security Copilot pane embedded in the data loss prevention alerts dashboard." lightbox="../media/data-loss-prevention-alert-security-copilot.png":::

You can interact with Security Copilot directly in the DLP alert view. Use the options to copy or regenerate the summary, or open it in the standalone experience for additional context.

## Share alert events

If someone outside your security or compliance role groups needs to review an alert, you can create a **shareable link** to a specific event:

1. Open the alert and navigate to the **Events** tab.
1. Select the event to share.
1. Choose **Actions** > **Copy event link**.
1. Paste the link into a chat, ticket, or email to share it with others.

Shared users only see what's included in the shared view. Permissions to edit or act on the alert aren't granted through the link.

## View matched content and metadata

DLP alerts include detailed information about:

- **Matched content**: Names, labels, and sizes of files or emails
- **User actions**: The behavior that matched the policy (for example, sending, uploading, copying)
- **Policy match details**: The rule, condition, and sensitive information type (SIT) involved

This data can be viewed directly in the Events tab or in **Content explorer** and **Activity explorer**, depending on your role permissions.

## Limitations when downloading emails

From the dashboard, some alerts allow you to download emails involved in the incident. However, emails might be unavailable if:

- An internal sender deleted the message sent to an external recipient
- An external sender's message was deleted by the internal recipient
- Both internal sender and recipient deleted the message

These limitations apply to Exchange-based DLP events.

The DLP Alerts dashboard gives security teams visibility into policy violations across Microsoft 365 services. It supports fast investigation, contextual analysis, and direct resolution, all from one place. With tools like Security Copilot and shareable links, teams can respond to potential risks quickly and collaboratively.
