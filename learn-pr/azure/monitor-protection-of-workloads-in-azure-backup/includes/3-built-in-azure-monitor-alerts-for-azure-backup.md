Azure Backup provides new and improved alerting capabilities via Azure Monitor. It automatically generates built-in alerts for certain default scenarios, such as deletion of backup data, disabling of soft-delete, backup failures, restore failures, and so on. You can view these alerts out of the box via the Backup center. To configure notifications for these alerts (for example, emails), you can use Azure Monitor's Alert Processing Rules and Action groups to route alerts to a wide range of notification channels.


- **Configure notifications to a wide range of notification channels**: Azure Monitor supports a wide range of notification channels, such as email, ITSM, webhooks, logic apps, and so on. You can configure notifications for backup alerts to any of these channels without investing much time in creating custom integrations.

- **Enable notifications for selective scenarios**: With Azure Monitor alerts, you can choose the scenarios to be notified about. Also, you can enable notifications for test subscriptions.

- **Monitor alerts at-scale via Backup center**: In addition to enabling you to manage the alerts from Azure Monitor dashboard, Azure Backup also provides an alert management experience tailored to backups via Backup center. This allows you to filter alerts by backup specific properties, such as workload type, vault location, and so on, and a way to get quick visibility into the active backup security alerts that need attention.

- **Manage alerts and notifications programmatically**: You can use Azure Monitor’s REST APIs to manage alerts and notifications via nonportal clients as well.

- **Consistent alert management for multiple Azure services, including backup**: Azure Monitor is the native service for monitoring resources across Azure. With the integration of Azure Backup with Azure Monitor, you can manage backup alerts in the same way as alerts for other Azure services, without requiring a separate learning curve.

Azure Backup provides a guided experience via the Backup center that allows you to switch to built-in Azure Monitor alerts and notifications. To perform this action, you need to have access to the Backup Contributor and Monitoring Contributor Azure role-based access control (Azure RBAC) roles to the subscription.

Follow these steps:

1. On the Azure portal, go to **Backup center** > **Overview**.

   :::image type="content" source="../media/backup-center-overview.png" alt-text="Screenshot showing Overview tab in Backup center." lightbox="../media/backup-center-overview.png":::

1. On the **Alerts** tile, the count of vaults appears that still has the classic alerts enabled.

   Select the link to take the required action.

   :::image type="content" source="../media/backup-center-alerts-link.png" alt-text="Screenshot showing number of vaults which have classic alerts enabled." lightbox="../media/backup-center-alerts-link.png":::

   On the next screen, there are two recommended actions:

   - **Create rule**: This action creates an alert processing rule attached to an action group to enable you to receive notifications for Azure Monitor alerts. After you select, it leads you to a template deployment experience.

     :::image type="content" source="../media/recommended-action-one.png" alt-text="Screenshot showing recommended alert migration action Create rule for Recovery Services vaults.":::

     You can deploy two resources via this template:

   - **Alert Processing Rule**: A rule that specifies alert types to be routed to each notification channel. This template deploys alert processing rules that span all Azure Monitor based alerts on all Recovery Services vaults in the subscription that the rule is created in.
   - **Action Group**: The notification channel to which alerts should be sent. This template deploys an email action group so that alerts are routed to the email ID(s) specified while deploying the template.

   To modify any of these parameters, for example, scope of alert processing rule, or choice of notification channels, you can edit these resources after creation, or you can create the alert processing rule and action group from scratch via the Azure portal.

1. Enter the subscription, resource group, and region in which the alert processing rule and action group should be created. Also specify the email ID(s) to which notifications should be sent. Other parameters populate with default values and only need to be edited, if you want to customize the names and descriptions that the resources are created in.

   :::image type="content" source="../media/alert-processing-rule-parameters.png" alt-text="Screenshot showing template parameters to set up notification rules for Azure Monitor alerts.":::

1. Select **Review+Create** to initiate deployment.

   Once deployed, notifications for Azure Monitor based alerts are enabled. If you have multiple subscriptions, repeat the above process to create an alert processing rule for each subscription.

   :::image type="content" source="../media/alert-processing-rule-deploy.png" alt-text="Screenshot showing deployment of notification rules for Azure Monitor alerts.":::

1. Next, you need to opt-out of classic alerts to avoid receiving duplicate alerts from two solutions.

   Select **Manage Alerts** to view the vaults for which classic alerts are currently enabled.

   :::image type="content" source="../media/recommended-action-two.png" alt-text="Screenshot showing recommended alert migration action Manage Alerts for Recovery Services vaults.":::

1. Select **Update** > **Use only Azure Monitor alerts** checkbox.

   By doing so, you agree to receive backup alerts only via Azure Monitor, and you'll stop receiving alerts from the older (classic alerts) solution.

   :::image type="content" source="../media/classic-alerts-vault.png" alt-text="Screenshot showing how to opt out of classic alerts for vault.":::

1. To select multiple vaults on a page and update the settings for these vaults with a single action, select **Update** from the top menu.

   :::image type="content" source="../media/classic-alerts-multiple-vaults.png" alt-text="Screenshot showing how to opt out of classic alerts for multiple vaults.":::





