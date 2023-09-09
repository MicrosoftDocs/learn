
When Azure Monitor data indicates that there might be a problem with your infrastructure or application, an alert is triggered. Alerts can contain action groups, which are a collection of notification preferences. Azure Monitor, Azure Service Health, and Azure Advisor use action groups to notify users about the alert and take an action.

Each action is made up of:

- **Type**: The notification that's sent or action that's performed. Examples include sending a voice call, SMS, or email. You can also trigger various types of automated actions.
- **Name**: A unique identifier within the action group.
- **Details**: The corresponding details that vary by type.

In general, an action group is a global service. Global requests from clients can be processed by action group services in any region. If one region of the action group service is down, the traffic is automatically routed and processed in other regions. As a global service, an action group helps provide a disaster recovery solution.

## Action groups

When Azure Monitor data indicates that there might be a problem with your infrastructure or application, an alert is triggered. Alerts can contain action groups, which are a collection of notification preferences. Azure Monitor, Azure Service Health, and Azure Advisor use action groups to notify users about the alert and take an action.

Each action is made up of:

- **Type**: The notification that's sent or action that's performed. Examples include sending a voice call, SMS, or email. You can also trigger various types of automated actions.
- **Name**: A unique identifier within the action group.
- **Details**: The corresponding details that vary by type.

In general, an action group is a global service. Global requests from clients can be processed by action group services in any region. If one region of the action group service is down, the traffic is automatically routed and processed in other regions. As a global service, an action group helps provide a disaster recovery solution. 

## Action group properties

Action groups have the following properties:

- You can add up to five action groups to an alert rule.
- Action groups are executed concurrently, in no specific order.
- Multiple alert rules can use the same action group.

When creating an Action group, you must choose a region option. The two options are as follows:

- **Global**. The action groups service decides where to store the action group. The action group is persisted in at least two regions to ensure regional resiliency. Processing of actions may be done in any geographic region. Voice, SMS, and email actions performed as the result of service health alerts are resilient to Azure live-site incidents.
- **Regional**. The action group is stored within the selected region. The action group is zone-redundant. Use this option if you want to ensure that the processing of your action group is performed within a specific geographic boundary.

## Action group notification

Action groups support the following notification options:

- **Email Azure Resource Manager role**. Send an email to the subscription members, based on their role. A notification email is sent only to the primary email address configured for the Azure AD user. The email is only sent to Azure Active Directory user members of the selected role, not to Azure AD groups or service principals.
- **Email**. Send an email to a specific address. Ensure that your email filtering and any malware/spam prevention services are configured appropriately. Emails are sent from the following email addresses:
	- * azure-noreply@microsoft.com
	- * azureemail-noreply@microsoft.com
	- * alerts-noreply@mail.windowsazure.com
- **SMS**. SMS notifications support bi-directional communication. The recipient of an SMS is able to unsubscribe to SMS alerts, resubscribe, or request help. You must enter the country code and phone number of the recipient. The SMS contains the following information:
	- Shortname of the action group this alert was sent to
	- The title of the alert.
- **Azure app Push notifications**. Send notifications to the Azure mobile app. In the Azure account email field, enter the email address that you use as your account ID when you configure the Azure mobile app.
- **Voice**. Voice notification. Enter the Country code and the Phone number for the recipient of the notification.

## Action types

Action groups allow the following actions to be triggered:

 - **Automation Runbook**. Allows an automation runbook to be run.
- **Event hubs**. An Event Hubs action publishes notifications to Event Hubs. You can subscribe to the alert notification stream from your event receiver.
- **Functions**. Calls an existing HTTP trigger endpoint in functions. When you define the function action, the function's HTTP trigger endpoint and access key are saved in the action definition. If you change the access key for the function, you must remove and re-create the function action in the action group. In addition to this your endpoint must support the HTTP POST method and the function must have access to the storage account. 
- **ITSM**. Allows you to create work items in your ITSM (IT Service Management) tool based on your Azure metric alerts, activity log alerts, and Log Analytics alerts.
- **Logic apps**. You can use Azure Logic Apps to build and customize workflows for integration and to customize your alert notifications. 
- **Secure webhook**. When you use a secure webhook action, you must use Azure AD to secure the connection between your action group and your endpoint, which is a protected web API. Secure webhook doesn't support basic authentication.
- **Webhook**. If you use the webhook action, your target webhook endpoint must be able to process the various JSON payloads that different alert sources emit. You can't pass security certificates through a webhook action. To use basic authentication, you must pass your credentials through the URI. If the webhook endpoint expects a specific schema, for example, the Microsoft Teams schema, use the Logic Apps action type to manipulate the alert schema to meet the target webhook's expectations.

## Common alert schema

The common alert schema standardizes the consumption of Azure Monitor alert notifications. Historically, activity log, metric, and log alerts each had their own email templates and webhook schemas. The common alert schema provides one standardized schema for all alert notifications.

The common alert schema provides a consistent structure for:

- **Email templates**: Use the detailed email template to diagnose issues at a glance. Embedded links to the alert instance on the portal and to the affected resource ensure that you can quickly jump into the remediation process.
- **JSON structure**: Use the consistent JSON structure to build integrations for all alert types using:
	- Azure Logic Apps
	- Azure Functions
	- Azure Automation runbook

Alerts generated by VM insights do not support the common schema. Smart detection alerts use the common schema by default. However, you don't have to enable the common schema for smart detection alerts.

## Create an action group

To create an action group, perform the following steps:

1. In the Azure portal search for and select **Monitor**. 
1. In the **Monitor** page, select **Alerts**, and then select **Action groups** and select **Create**.
1. Configure the basic action group settings. In the **Project details** section:
	- Select values for Subscription and Resource group.
	- Select the region. Choose between **Global** and **Regional**.
1. In the **Instance details** section, enter values for **Action group name** and **Display name**. The display name is used in place of a full action group name when the group is used to send notifications.
1. Configure notifications. Select **Next: Notifications** or select the **Notifications** tab at the top of the page.
1. Define a list of notifications to send when an alert is triggered. You can choose between the following options described earlier:
	- Email Azure Resource Manager role 
	- Email
	- SMS
	- Azure app Push notifications 
	- Voice
1. Select if you want to enable the Common alert schema and choose **Next**. 
1. Configure actions. Select **Next: Actions**. or select the **Actions** tab at the top of the page. Define a list of actions to trigger when an alert is triggered. Select an action type and enter a name for each action. You can choose from the following actions:
	- Automation Runbook. 
	- Event hubs. 
	- Functions. 
	- ITSM. 
	- Logic apps.  
	- Secure webhook. 
	- Webhook.
1. If you'd like to assign a key-value pair to the action group to categorize your Azure resources, select **Next: Tags** or the **Tags** tab. Otherwise, skip this step.
1. Select **Review + create** to review your settings. This step quickly checks your inputs to make sure you've entered all required information. If there are issues, they're reported here. After you've reviewed the settings, select **Create** to create the action group.
