You can opt in to Azure Monitor alerts for backup and restore failure scenarios for your Recovery Services vault and your Backup vault.

## Configure alerts for a Recovery Services vault

Built-in Azure Monitor alerts are generated for job failures by default. If you want to turn off alerts for these scenarios, you can edit the monitoring settings property of the vault.

To manage monitoring settings for a Recovery Services vault:

1. Go to the vault, and then select **Properties**.

1. Locate the **Monitoring Settings** vault property, and then select **Update**.

   :::image type="content" source="../media/recovery-services-vault-monitoring-settings.png" alt-text="Screenshot that shows how to update the monitoring settings for a Recovery Services vault.":::

1. In the context pane, select the relevant options to enable or disable built-in Azure Monitor alerts for job failures.

   :::image type="content" source="../media/recovery-services-vault-job-failure-alert-setting.png" alt-text="Screenshot that shows options to enable or disable built-in Azure Monitor alerts.":::

1. Select the **Use only Azure Monitor alerts** checkbox (recommended).

   By selecting this option, you consent to receive backup alerts only via Azure Monitor. You'll no longer receive alerts from the classic alerts solution. Review the key differences between classic alerts and built-in Azure Monitor alerts.

   :::image type="content" source="../media/recovery-services-vault-opt-out-classic-alerts.png" alt-text="Screenshot that shows the option to enable receiving backup alerts.":::

1. Select **Update** to save the setting for the vault.

## Configure alerts for a Backup vault

For Backup vaults, you no longer need to use a feature flag to opt in to alerts for job failure scenarios. Built-in Azure Monitor alerts are generated for job failures by default. If you want to turn off alerts for these scenarios, you can edit the monitoring settings property of the vault.

To manage monitoring settings for a Backup vault:

1. Go to the vault, and then select **Properties**.

1. Locate the **Monitoring Settings** vault property, and then select **Update**.

   :::image type="content" source="../media/monitoring-settings-backup-vault.png" alt-text="Screenshot that shows monitoring settings in a Backup vault.":::

1. In the context pane, select the relevant options to enable or disable built-in Azure Monitor alerts for job failures.

1. Select **Update** to save the setting for the vault.

   :::image type="content" source="../media/job-failure-alert-setting.png" alt-text="Screenshot that shows updating Azure Monitor alert settings in a Backup vault." lightbox="../media/job-failure-alert-setting.png":::
