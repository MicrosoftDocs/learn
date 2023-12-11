Azure Backup provides new and improved alerting capabilities via Azure Monitor. Built-in alerts for some default scenarios are automatically generated. Alerts are generated when backup data is deleted, when soft-delete is disabled, and when backup or restore fails. You can view these default alerts in Backup center. You can use alert processing rules and action groups in Azure Monitor to route alerts in a wide range of notification options, such as by email or by role assignment.

- **Configure notifications in a wide range of channels**: Azure Monitor supports a wide range of notification channels, including email, IT service management (ITSM), webhooks, and logic apps. You can configure notifications for backup alerts to any of these channels without investing much time in creating custom integrations.

- **Enable notifications for select scenarios**: You can choose the scenarios that generate notifications. Also, you can enable notifications for test subscriptions.

- **Monitor alerts at scale via Backup center**: In addition to alerts that you manage on the Azure Monitor dashboard, Azure Backup provides an alert management experience that's tailored to backups via Backup center. You can filter alerts by backup-specific properties, such as workload type or vault location. And, you have a way to get quick visibility into active backup security alerts that need attention.

- **Manage alerts and notifications programmatically**: You can use the Azure Monitor REST APIs to manage alerts and notifications via nonportal clients as well.

- **Consistent alert management for multiple Azure services, including backup**: Azure Monitor is the native service for monitoring resources across Azure. With the integration of Azure Backup with Azure Monitor, you can manage backup alerts the same way you manage alerts for other Azure services, and without a separate learning curve.

Azure Backup provides a guided experience via Backup center where you can switch to built-in Azure Monitor alerts and notifications. To perform this action, you must have access to the Backup Contributor and Monitoring Contributor Azure role-based access control (Azure RBAC) roles in the subscription.

To set up default notification alerts:

1. In the Azure portal, go to **Backup center** > **Overview**.

   :::image type="content" source="../media/backup-center-overview.png" alt-text="Screenshot that shows the Overview tab in Backup center." lightbox="../media/backup-center-overview.png":::

1. The **Alerts** tile displays the count of vaults that still have classic alerts enabled.

   Select the link to take required action.

   :::image type="content" source="../media/backup-center-alerts-link.png" alt-text="Screenshot that shows number of vaults that have classic alerts enabled." lightbox="../media/backup-center-alerts-link.png":::

1. Select **Create rule**.

   This action creates an alert processing rule that's attached to an action group so that you receive notifications for Azure Monitor alerts.

     :::image type="content" source="../media/recommended-action-one.png" alt-text="Screenshot that shows recommended alert migration action Create rule for Recovery Services vaults.":::

     You can deploy two resources via this template:

   - **Alert processing rule**: A rule that specifies alert types to be routed to each notification channel. This template deploys alert processing rules that span all Azure Monitor-based alerts on all Recovery Services vaults in the subscription that the rule is created in.
   - **Action group**: The notification channel to which alerts should be sent. This template deploys an email action group so that alerts are routed to the email IDs that are specified when you deploy the template.

   To modify any of these parameters, like the scope of an alert processing rule or the notification channels that are selected, you can edit these resources after they're created. You also can create and edit alert processing rules and action groups in the Azure portal.

1. Enter the subscription, resource group, and region in which the alert processing rule and action group should be created. Also, specify the email IDs to which notifications should be sent. Other parameters populate by using the default values and need to be edited only if you want to customize the names and descriptions that the resources are created in.

   :::image type="content" source="../media/alert-processing-rule-parameters.png" alt-text="Screenshot that shows template parameters to set up notification rules for Azure Monitor alerts.":::

1. Select **Review+Create** to initiate deployment.

   After the configuration is deployed, notifications for Azure Monitor-based alerts are enabled. If you have multiple subscriptions, repeat this process to create an alert processing rule for each subscription.

   :::image type="content" source="../media/alert-processing-rule-deploy.png" alt-text="Screenshot that shows deployment of notification rules for Azure Monitor alerts.":::

1. Next, opt out of classic alerts to avoid receiving duplicate alerts from two solutions.

   Select **Manage alerts** to view the vaults for which classic alerts are currently enabled.

   :::image type="content" source="../media/recommended-action-two.png" alt-text="Screenshot that shows recommended alert migration action Manage Alerts for Recovery Services vaults.":::

1. Select **Update** > **Use only Azure Monitor alerts**.

   By making this selection, you agree to receive backup alerts only via Azure Monitor. You will no longer receive alerts from the classic alerts solution.

   :::image type="content" source="../media/classic-alerts-vault.png" alt-text="Screenshot that shows how to opt out of classic alerts for a vault.":::

1. To select multiple vaults on a page and update the settings for these vaults in a single action, select **Update** in the top menu.

   :::image type="content" source="../media/classic-alerts-multiple-vaults.png" alt-text="Screenshot that shows how to opt out of classic alerts for multiple vaults.":::
