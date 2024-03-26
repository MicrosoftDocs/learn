As the Azure admin for your company, you've been asked to do failovers to secondary regions for the storage accounts that hold the music data and manage those failovers.

In this unit, you'll start a failover. When the failover is complete, you'll reconfigure the storage account to use geo-redundant storage for replication. To estimate potential data loss, you'll use the **last sync time** property.

The option to fail over isn't available in the Azure portal until the initial sync from the primary region to the secondary region is complete. This initial sync process might take several hours. If you don't have time to wait, that's okay. You can still complete this module. To get familiar with the process, review the following steps and screenshots. Or, if you're following these steps in your own subscription, come back later to complete the steps.

## Start a failover

Let's simulate a region-wide failure by manually initiating a failover.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Select or find **Resource groups**.

1. Select **learn-storage-replication-rg**.

1. Select the storage account you created from the list of resources in your resource group.

1. In the pane on the left, under the **Data management** section, select **Redundancy**.

1. Select **Prepare for failover**. This button isn't enabled until the initial sync from the primary to the secondary region is complete.

   :::image type="content" source="../media/5-portal-failover-prepare.png" alt-text="Screenshot of the Prepare for failover button at the bottom of the geo-replication page.":::

1. A confirmation message appears. This message includes the **last sync time**, which is a timestamp in the GMT time zone. Make a note of the last sync time. You'll use the last sync time to estimate how much data loss you'll have after failover is complete.

   :::image type="content" source="../media/5-portal-failover-confirm.png" alt-text="Screenshot that shows the last sync time and requests you confirm failover by entering yes.":::

1. In the **Confirm failover** field, enter **yes**.
1. Select **Failover**.
1. On the geo-replication page, you'll notice that the failover is in progress.
   :::image type="content" source="../media/5-failover-progress.png" alt-text="Screenshot of the geo-replication page that shows the failover status is in progress.":::
1. Wait a few minutes for the failover to finish.
1. When the failover is complete, you'll notice that the replication type is locally redundant storage (LRS) and the data is stored in one location.

   :::image type="content" source="../media/5-failover-complete-lrs.png" alt-text="Screenshot of the geo-replication page that shows the replication type is now LRS and data is stored in one location.":::

## Reconfigure replication mode

When failover is complete, your geo-replication map shows only one region. This region is your new primary. You'll need to reconfigure your account to use geo-redundant storage.

1. On the geo-replication page, in the **Replication** drop-down, select **Geo-redundant storage (GRS)**.

    :::image type="content" source="../media/5-change-replication-type.png" alt-text="Screenshot of the geo-replication page, where you can change the replication from LRS to GRS.":::

1. At the top of the form, select **Save**.

## Estimate the data loss

Now you need to estimate potential data loss. Review the **Last failover time**, and compare it with the **last sync time** value.

1. In the pane on the left, under the **Data management** section, select **Redundancy**.
1. On the left side of the map, note the **Last failover time** value.

    :::image type="content" source="../media/5-last-sync-time-after-failover.png" alt-text="Screenshot that shows an updated last failover time on the geo-replication page.":::

1. Compare this value with the **last sync time**. If data was written to the primary region during these two times, it might be lost.
