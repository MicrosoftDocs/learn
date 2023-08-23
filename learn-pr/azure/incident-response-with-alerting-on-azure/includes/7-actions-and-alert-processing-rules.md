When an alert is fired, Azure Monitor, Azure Service Health, and Azure Advisor use action groups to notify users about the alert and take an action. An action group is a collection of notification preferences and actions that are executed when the alert is fired. You can run one or more actions for each triggered alert.

Azure Monitor can perform any of the following actions:

- Send an email
- Send an SMS message
- Create an Azure app push notification
- Make a voice call to a number
- Call an Azure function
- Trigger a logic app
- Send a notification to a webhook
- Create an ITSM ticket
- Use a runbook (to restart a VM, or scale a VM up or down)

Once you've created an action group, you can reuse that action group as often as you want. For example, after you've created an action to email your company's operations team, you can add that action group to all service health events.

While you're creating the alert rule, you can either create a new action group or add an existing action group to the alert rule. You can also edit an existing alert to add an action group.

## Alert processing rules

Use alert processing rules to override the normal behavior of a fired alert by adding or suppressing an action group. You can use alert processing rules to add action groups or remove (suppress) action groups from your fired alerts. Alert processing rules are different from alert rules. Alert rules trigger alerts when a condition is met in your monitored resources. Alert processing rules modify the alerts as they're being fired.

You can use alert processing rules to:

- Suppress notifications during planned maintenance windows
- Implement management at scale, by specifying commonly used logic in a single rule, instead of having to set it consistently in all your alert rules.
- Add an action group to all alert types

You can apply alert processing rules to different resource scopes, from a single resource, or to an entire subscription. You can also use them to apply various filters or have the rule work on a predefined schedule.

You can control when the alert processing rule applies. By default the rule is always active, but you can select a one-time window for this rule to apply, or you can have set a recurrence, such as a weekly recurrence.
