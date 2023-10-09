An action group is a collection of notification preferences that you define as an Azure subscription owner. When Azure Monitor detects an issue in your telemetry data, your alert triggers and your alert rule actions initiate. Azure Monitor, Azure Service Health, and Azure Advisor use _action groups_ to notify users when an alert triggers. 

### Things to know about action groups

Let's review the characteristics of action groups, including how to configure notifications and define actions.

- Multiple alerts can use the same action group or different action groups depending on the user's requirements.

- Notifications specify how to notify users when your action group triggers.

- Actions specify how to invoke your defined actions when your action group triggers.

#### Notifications

You can configure notifications to operate by configuring email or similar communication settings.

:::image type="content" source="../media/alert-notifications-618b4c6f.png" alt-text="Screenshot that shows how to configure notifications for an action group in the Azure portal.":::

In the Azure portal, you can select the **Email Azure Resource Manager role** option to send email notifications to the members of your Azure subscription's role. The system sends email to Azure Active Directory (Azure AD) user members of the role only, and not to Azure AD groups or service principals.

You can also select the **Email/SMS message/Push/Voice** option to specify any email, SMS, push, or voice actions.

#### Actions

You provide each action with a unique name and details, and define the notifications or actions to perform. You might specify actions to send a voice call, an SMS message, or an email message. 

:::image type="content" source="../media/action-groups-42c1cd23.png" alt-text="Screenshot that shows how to configure actions for an action group in the Azure portal.":::

You can configure the action group to use an automated action via the **Action type** attribute. Here are some automated options:

- **Automation runbook**: An automation runbook is the ability to define, build, orchestrate, manage, and report on workflows that support system and network operational processes. A runbook workflow can potentially interact with all types of infrastructure elements, such as applications, databases, and hardware.
- **Azure Functions**: Azure Functions is a serverless compute service that lets you run event-triggered code without having to explicitly provision or manage infrastructure.
- **ITSM**: The action can connect Azure and a supported IT Service Management (ITSM) product or service. This action requires an ITSM connection.
- **Logic Apps**: Azure Logic Apps connects your business-critical apps and services by automating your workflows.
- **Webhook**: A webhook is an HTTPS or HTTP endpoint that allows external applications to communicate with your system.