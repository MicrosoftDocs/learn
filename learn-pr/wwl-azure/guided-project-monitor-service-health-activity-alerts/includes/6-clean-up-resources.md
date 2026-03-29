## Clean up resources

Complete these steps to remove the monitoring resources you created in this project. Alert rules and action groups don't incur charges, but removing them keeps your subscription tidy.

> [!WARNING]
> Resource deletion is permanent. Verify that you're deleting only resources created for this guided project before you proceed.

### Delete the alert rules

1.  In the portal search bar, search for **Monitor** and select **Monitor**.
2.  In the left menu, select **Alerts**.
3.  Select **Alert rules** from the top menu bar.
4.  Find **ar-gp-activity-delete** in the list, select the checkbox next to it, and select **Delete**. Confirm the deletion.
5.  Find **ar-gp-service-health** in the list, select the checkbox next to it, and select **Delete**. Confirm the deletion.

### Delete the action group

1.  In **Monitor** > **Alerts**, select **Action groups** from the top menu bar.
2.  Find **ag-gp-ops-email** in the list, select the checkbox next to it, and select **Delete**. Confirm the deletion.

### Delete the resource group

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-monitoring-alerts** from the list.
3.  Select **Delete resource group** from the top menu bar.
4.  In the confirmation field, type **rg-gp-monitoring-alerts** and select **Delete**.
5.  In the confirmation dialog that appears, select **Delete** again to confirm.
6.  Wait for the notification that confirms the resource group is deleted.

### Verify cleanup

1.  In the portal search bar, search for **Resource groups** and confirm **rg-gp-monitoring-alerts** no longer appears in the list.
2.  In **Monitor** > **Alerts** > **Alert rules**, confirm neither alert rule appears.
3.  In **Monitor** > **Alerts** > **Action groups**, confirm **ag-gp-ops-email** no longer appears.
