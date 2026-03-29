## Clean up resources

The resource group was deleted during Exercise 4. Complete these steps to confirm cleanup is finished.

> [!WARNING]
> Resource deletion is permanent. Verify that you're deleting only resources created for this guided project before you proceed.

### Confirm the resource group is deleted

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Confirm **rg-gp-cli-demo** no longer appears in the list.
3.  If the resource group still appears, select it, then select **Delete resource group** from the top menu bar. In the confirmation field, type **rg-gp-cli-demo** and select **Delete**. In the confirmation dialog that appears, select **Delete** again to confirm.

### (Optional) Remove the Cloud Shell storage account

Azure creates a small storage account for Cloud Shell file persistence. Remove it only if you don't plan to use Cloud Shell again.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Look for a storage account in a resource group named **cloud-shell-storage-** (followed by a region name).
3.  If you want to remove it, select the storage account and select **Delete** from the top menu bar.
4.  Type the storage account name to confirm and select **Delete**.
