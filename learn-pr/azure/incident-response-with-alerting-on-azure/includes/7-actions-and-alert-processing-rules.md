When any event is triggered, you can create an associated action in an action group. Action groups allow you to define actions that are executed when the alert is fired. You can run one or more actions for each triggered alert.

![Screenshot of the robot icon used to represent actions when you're creating an alert.](../media/6-actions.png)

Azure Monitor can perform any of the following actions: available actions are:

- Send an email
- Send an SMS message
- Create an Azure app push notification
- Make a voice call to a number
- Call an Azure function
- Trigger a logic app
- Send a notification to a webhook
- Create an ITSM ticket
- Use a runbook (to restart a VM, or scale a VM up or down)

Once you've created an action group, you can reuse that action group as often as you want.For example, after you've created an action to email your company's operations team, you can add that action group to all service health events.

You can create an action groups or add an existing action group when you create your alert. You can also edit an existing alert to add an action group.

## Alert processing rules

Use alert processing rules to override the normal behavior of a fired alert by adding or suppressing an action group.

Alert processing rules are different from alert rules. Alert rules trigger alerts. Alert processing rules modify the alerts as they're being fired.

You can apply alert processing rules to different resource scopes, from a single resource, or to an entire subscription. You can also use them to apply various filters or have the rule work on a predefined schedule.

You can use alert processing rules to:

- Suppress notifications during planned maintenance windows
- Implement management at scale
- Add an action group to all alert types

## Alert processing rules scope and filters
