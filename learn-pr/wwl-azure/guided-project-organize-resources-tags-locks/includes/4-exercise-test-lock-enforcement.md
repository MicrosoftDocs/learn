This guided project consists of the following exercises:

 - Create resources and apply tags
 - Apply resource locks
 - **Test lock enforcement**

In this exercise, you test what happens when you try to modify or delete locked resources. You then remove the locks and confirm that normal operations are restored, completing the full lock lifecycle.

This exercise includes the following tasks:

 - Test the read-only lock
 - Test the delete lock
 - Remove the locks
 - Confirm normal operations are restored

**Outcome:** Confirmed that locks block operations as expected, and that removing a lock restores normal access.

## Task 1: Test the read-only lock

Verify that the read-only lock on the resource group prevents modifications. This confirms that the governance control is active and protecting your environment.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  In the left menu, select **Tags**.
4.  Try to add a new tag (for example, **test-tag** with value **blocked**) and select **Apply**.
5.  Confirm that the operation fails with an error message indicating the resource group is locked.
6.  Note the error message. It confirms the read-only lock is working correctly.

> [!NOTE]
> **Validation step:** Confirm the error message references the read-only lock. This proves the lock is actively preventing modifications.

## Task 2: Test the delete lock

Verify that the delete lock prevents the storage account from being removed, even though the read-only lock is also in place.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select the first storage account (for example, **stgptagslock**).
3.  Select **Delete** from the toolbar (or the Overview page).
3.  Confirm that the deletion is blocked with an error referencing the lock.

> [!NOTE]
> **Validation step:** Confirm the deletion is blocked with an error referencing the delete lock.

## Task 3: Remove the locks

Remove both locks to restore normal operations. In a real environment, you would remove locks only when authorized changes are needed, then reapply them afterward.

> [!TIP]
> The resource group Locks pane displays locks from all child resources, so you can manage locks across the entire resource group from a single location.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  In the left menu, under **Settings**, select **Locks**.
4.  On the **read-only-rg** lock line item, select **Delete**. Confirm the deletion.
5.  On the **prevent-delete** lock line item (scoped to the storage account), select **Delete**. Confirm the deletion.
6.  Confirm the Locks pane is now empty—no locks remain on the resource group or its child resources.

> [!NOTE]
> **Validation step:** Confirm the Locks pane on both the resource group and storage account is empty.

## Task 4: Confirm normal operations are restored

Verify that removing the locks allows previously blocked operations to succeed. This demonstrates the full lock lifecycle: apply, enforce, remove, and confirm.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  In the left menu, select **Tags**.
3.  Add the tag **lock-test** with the value **passed** and select **Apply**.
4.  Confirm the tag is saved successfully, proving that the read-only lock is no longer blocking modifications.
5.  Select the **delete** icon (trash can) next to the **lock-test** tag to remove it, then select **Apply** to clean up.

> [!NOTE]
> **Validation step:** Verify the **lock-test** tag was saved successfully, proving that removing the read-only lock restored write permissions.