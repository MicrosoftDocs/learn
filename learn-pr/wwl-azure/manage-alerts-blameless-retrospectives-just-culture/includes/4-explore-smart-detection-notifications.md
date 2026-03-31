Smart detection notifications provide automatic alerting about performance anomalies without requiring manual alert configuration. Understanding how to manage these notifications ensures the right people receive important information without creating alert fatigue.

## Default notification configuration

**Automatic enablement:** Smart detection notifications are enabled by default when you configure Application Insights. This automatic setup ensures performance issues are surfaced immediately without additional configuration overhead.

**Default recipients:** Notifications are automatically sent to users with [specific Azure role-based access control (RBAC) roles](/azure/application-insights/app-insights-resources-roles-access-control) for the Application Insights resource:

- **Owners:** Users with full control over the Application Insights resource.
- **Contributors:** Users who can modify Application Insights configuration and view data.
- **Readers:** Users with read-only access to Application Insights data.

This default configuration ensures people who manage and monitor the application receive performance alerts automatically.

## Customizing notification recipients

**Accessing configuration:** You can customize who receives smart detection notifications through two methods:

**From email notifications:** Each smart detection email includes a "Configure" link. Clicking this link takes you directly to notification settings where you can modify recipients.

**From Azure portal:** Navigate to your Application Insights resource, then access Smart Detection settings through the configuration menu. This provides the same customization interface.

:::image type="content" source="../media/smart-detection-notifications-949f4fe7.png" alt-text="Diagram showing smart detection notifications.":::

**Modifying recipient lists:** In the Smart Detection settings, you can:

- Add additional email addresses for people who should receive notifications.
- Remove users from the notification list.
- Change notification routing to integrate with incident management systems.
- Configure action groups for advanced notification scenarios.

**When to customize recipients:** Consider adjusting default recipients in these scenarios:

- On-call rotation requires notifications to specific team members rather than all contributors.
- Integration with PagerDuty, Opsgenie, or other incident management platforms.
- Separating notification responsibilities where different teams monitor different aspects of applications.
- Reducing notification volume for users who don't need immediate performance alerts.

## Managing notification frequency

**Rate limiting to prevent alert fatigue:** Smart detection implements intelligent rate limiting to prevent notification overload:

**One email per day per resource:** For each Application Insights resource, smart detection sends at most one notification email per day. This limit prevents constant interruptions while ensuring you're aware of performance issues.

**New issue requirement:** The daily email is sent only if at least one new performance issue was detected that day. If no new issues are found, no email is sent. This ensures notifications represent fresh information rather than repeated alerts about known issues.

**No duplicate messages:** Once an issue has been reported, you won't receive repeated notifications about the same problem. This prevents alert fatigue from continuous reminders about ongoing issues you're already aware of and working to resolve.

**Why rate limiting matters:** Without rate limiting, dozens of related performance anomalies could trigger separate notifications, overwhelming recipients. By consolidating notifications to one per day per resource, smart detection keeps you informed without creating notification storms that cause teams to ignore alerts.

## Unsubscribing from notifications

**Individual user control:** Each smart detection email includes an unsubscribe link. Users can opt out of receiving notifications without affecting other recipients.

**When unsubscribing makes sense:**

- You've transitioned to a different role and no longer monitor application performance.
- Your team uses centralized incident management tools that aggregate alerts rather than relying on individual emails.
- You receive notifications for multiple Application Insights resources and want to focus on specific ones.
- You prefer to check Application Insights portal directly rather than receiving email notifications.

**Re-subscribing:** If you unsubscribe but later want to receive notifications again, you can update your subscription through the Smart Detection settings in the Azure portal.

## Integrating with alerting workflows

**Beyond email notifications:** While email notifications work well for small teams, larger organizations often need more sophisticated alerting workflows:

**Action groups:** Configure Azure Monitor action groups to route smart detection findings to:

- Incident management platforms like PagerDuty, Opsgenie, or ServiceNow.
- Team collaboration tools like Microsoft Teams or Slack.
- Webhook endpoints for custom notification handling.
- SMS or voice calls for critical alerts.
- Azure Functions or Logic Apps for automated response workflows.

**Alert rules:** Create custom alert rules based on smart detection findings to:

- Apply additional filtering based on severity or affected user count.
- Route different types of performance issues to different teams.
- Escalate alerts that remain unresolved for specific time periods.
- Suppress notifications during maintenance windows.

**Notification strategy considerations:** Design your notification strategy to balance awareness with alert fatigue:

- Ensure critical performance issues reach on-call engineers immediately.
- Route less urgent anomalies to team channels for investigation during business hours.
- Consolidate notifications when multiple related issues occur simultaneously.
- Provide enough context in notifications to enable rapid assessment without requiring portal access.
- Track notification metrics to identify if alert fatigue is developing.
