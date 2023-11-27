You can opt in to Azure Monitor alerts for backup and restore operations failure scenarios for Recovery Services vault and Backup vault.

## Configure alerts in Recovery Services vault

Built-in Azure Monitor alerts are generated for job failures by default. If you want to turn off alerts for these scenarios, you can edit the monitoring settings property of the vault accordingly.

To manage monitoring settings for a Backup vault, follow these steps:

1. Go to the vault and select **Properties**.

1. Locate the **Monitoring Settings** vault property and select **Update**.

   :::image type="content" source="../media/recovery-services-vault-monitoring-settings.png" alt-text="Screenshot showing how to update monitoring settings in Recovery Services vault.":::

1. In the context pane, select the appropriate options to enable/disable built-in Azure Monitor alerts for job failures depending on your requirement.

	:::image type="content" source="../media/recovery-services-vault-job-failure-alert-setting.png" alt-text="Screenshot showing options to enable or disable built-in Azure Monitoring alerts.":::

1. We also recommend you to select the checkbox **Use only Azure Monitor alerts**.

   By selecting this option, you're consenting to receive backup alerts only via Azure Monitor and you'll stop receiving alerts from the older classic alerts solution. [Review the key differences between classic alerts and built-in Azure Monitor alerts](./move-to-azure-monitor-alerts.md).

	:::image type="content" source="../media/recovery-services-vault-opt-out-classic-alerts.png" alt-text="Screenshot showing the option to enable receiving backup alerts.":::

1. Select **Update** to save the setting for the vault.


## Configure alerts in Backup vault

For Backup vaults, you no longer need to use a feature flag to opt in to alerts for job failure scenarios. Built-in Azure Monitor alerts are generated for job failures by default. If you want to turn off alerts for these scenarios, you can edit the monitoring settings property of the vault accordingly.

To manage monitoring settings for a Backup vault, follow these steps:

1. Go to the vault and select **Properties**.

1. Locate the **Monitoring Settings** vault property and select **Update**.

   :::image type="content" source="../media/monitoring-settings-backup-vault.png" alt-text="Screenshot for monitoring settings in backup vault.":::

1. In the context pane, select the appropriate options to enable/disable built-in Azure Monitor alerts for job failures depending on your requirement.

1. Select **Update** to save the setting for the vault.

    :::image type="content" source="../media/job-failure-alert-setting.png" alt-text="Screenshot for updating Azure Monitor alert settings in backup vault." lightbox="../media/job-failure-alert-setting.png":::
