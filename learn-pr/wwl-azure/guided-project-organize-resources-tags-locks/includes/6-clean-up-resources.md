## Clean up resources

Complete these steps to avoid ongoing charges from the resources you created in this project.

> [!WARNING]
> Resource deletion is permanent. Verify that you're deleting only resources created for this guided project before you proceed.

### Verify locks are removed

Resource locks block deletion. Confirm all locks are removed before you delete the resource group.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  In the left menu, under **Settings**, select **Locks**.
4.  If any locks remain, select each lock and select **Delete** to remove it.
5.  Open each storage account, select **Locks** in the left menu, and confirm no locks remain.

### Delete the resource group

Deleting the resource group removes both storage accounts and all tags automatically.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  Select **Delete resource group** from the top menu bar.
3.  In the confirmation field, type **rg-gp-tags-locks** and select **Delete**.
4.  In the confirmation dialog that appears, select **Delete** again to confirm.
5.  Wait for the notification that confirms the resource group is deleted.

### Verify cleanup

1.  In the portal search bar, search for **Resource groups** and confirm **rg-gp-tags-locks** no longer appears in the list.
2.  In the portal search bar, search for **Storage accounts** and confirm neither **stgptagslock** nor **stgptagsops** appears in the list.
