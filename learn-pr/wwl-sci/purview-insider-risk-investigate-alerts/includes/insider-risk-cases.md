Cases in Microsoft Purview Insider Risk Management allow investigators to track user risk over time, review associated alerts, and take action based on the severity and context of the activity. Each case focuses on a single user and can include one or more alerts. Cases are created manually when an alert requires deeper review or coordination with other teams.

Use the **Cases** dashboard to view all active and closed cases, assign ownership, and manage follow-up actions such as escalation, communication, and resolution.

## Respond to alerts

Not all alerts require a case. You can take action directly from the **Alerts** queue by confirming or dismissing alerts as part of your triage process:

- **Dismiss** an alert if it's a false positive or doesn't require further review.
- **Confirm** an alert to indicate a policy violation and optionally create a case for deeper investigation.

Creating a case is recommended when an alert involves serious risk, multiple incidents, or needs collaboration across teams. Once a case is created, you can take further action such as sending notices, escalating, or resolving with a classification.

## Create and manage cases

Cases are created from alerts when an incident needs further review or response. Once created, cases can be updated with new alerts and managed through their lifecycle. You can:

- Assign or reassign ownership
- Send an email notice to the user
- Escalate to Microsoft Purview eDiscovery (Premium)
- Run Power Automate flows
- Create or view a connected Microsoft Teams team
- Resolve the case with a classification of Benign or Confirmed policy violation

You can assign a case to any user with one of these roles: **Insider Risk Management**, **Analyst**, or **Investigator**.

:::image type="content" source="../media/insider-risk-case-details.png" alt-text="Screenshot showing how to create a case in Insider Risk Management." lightbox="../media/insider-risk-case-details.png":::

## Use the Cases dashboard

The Cases dashboard lists each case and includes key details:

- Case name and ID
- Assigned user (anonymized if enabled)
- Status: **Active** or **Closed**
- Number of alerts
- Time opened and last updated
- Last updated by

You can search by case ID or keywords, and use filters to narrow by status, date opened, or last updated.

To customize the view, select **Customize columns**. To save filters for future use, apply filters and select **Save this view**.

:::image type="content" source="../media/insider-risk-case-details.png" alt-text="Screenshot showing the Cases dashboard in Insider Risk Management." lightbox="../media/insider-risk-case-details.png":::

## Investigate a case

Selecting a case opens a detailed investigation view with multiple tabs:

- **Case overview**: User identity, department, risk score, associated alerts
- **Alerts**: Status, severity, and alert ID for each included alert
- **User activity**: Timeline of scored risk activity from the alert or broader user history
- **Activity explorer (preview)**: Detailed timeline and metadata for each associated event

   **User activity** shows the overall timeline of user risk behavior, while **Activity explorer** focuses on event-level details within the case scope.

- **Forensic evidence**: Screen captures from activity that triggered the alert
- **Content explorer**: Copies of files and email messages associated with risk alerts
- **Case notes:** Permanent, timestamped notes added by analysts
- **Contributors**: Users added to the case for collaboration

   :::image type="content" source="../media/insider-risk-case-details.png" alt-text="Screenshot showing details of a case investigation." lightbox="../media/insider-risk-case-details.png":::

> [!NOTE]
> Contributors can view the case and add notes, but they can't edit contributor lists or confirm/dismiss alerts.

## Take action on a case

The case toolbar includes actions for responding to the alert:

### Send email notice

Send a message to the user to reinforce policies or training. Notices are based on templates and are recorded in the **Case notes** tab.

> [!TIP]
> Sending a notice doesn't close the case. To resolve it, you must select **Resolve case** separately.

### Escalate for investigation

Use this option to escalate the case to a Microsoft Purview eDiscovery (Premium) case for deeper investigation and legal hold workflows.

### Run Power Automate flows

Trigger flows for common tasks such as:

- Notifying a manager
- Creating a record in ServiceNow
- Requesting details from HR

### Create or view Teams team

If Teams integration is enabled in Insider Risk Management settings, a team is created automatically when a case is opened. Teams are archived when a case is resolved. To enable Teams integration:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).
1. Select **Settings** > **Insider Risk Management** > **Microsoft Teams**.
1. Select the toggle to enable integration with Microsoft Teams.

   :::image type="content" source="../media/insider-risk-teams-integration.png" alt-text="Screenshot showing where to enable Teams integration in Microsoft Purview Insider Risk Management." lightbox=" ../media/insider-risk-teams-integration.png":::

## Resolve a case

When investigation is complete, resolve the case as:

- **Benign**: Behavior is low-risk, accidental, or false positive
- **Confirmed policy violation**: Behavior is intentional or a serious violation

Enter a reason for the resolution. Resolution actions are recorded in Case notes, and the case status is updated to Closed.
