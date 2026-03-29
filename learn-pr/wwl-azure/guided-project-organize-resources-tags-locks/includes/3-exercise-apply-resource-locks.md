This guided project consists of the following exercises:

 - Create resources and apply tags
 - **Apply resource locks**
 - Test lock enforcement

In this exercise, you apply two types of locks—a delete lock on the storage account and a read-only lock on the resource group. Locks add a layer of protection that prevents accidental changes or deletions, even by users who have full permissions.

This exercise includes the following tasks:

 - Apply a delete lock to the storage account
 - Apply a read-only lock to the resource group

**Outcome:** A delete lock on the storage account and a read-only lock on the resource group.

## Task 1: Apply a delete lock to the storage account

Add a delete lock to prevent the storage account from being accidentally removed. A delete lock allows normal read and write operations but blocks deletion until the lock is removed. This protects critical resources from human error.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select the first storage account you created (for example, **stgptagslock**).
3.  In the left menu, under **Settings**, select **Locks**.
3.  Select **+ Add**.
4.  For **Lock name**, enter **prevent-delete**.
5.  For **Lock type**, select **Delete**.
6.  Optionally add a note such as **Prevents accidental deletion of test storage account**.
7.  Select **OK**.
8.  Confirm the lock appears in the locks list.

> [!NOTE]
> **Validation step:** Verify the storage account displays a **prevent-delete** lock in the Locks pane.

## Task 2: Apply a read-only lock to the resource group

Add a read-only lock at the resource group level. A read-only lock prevents any modifications to resources within the group, including creating new resources. This demonstrates how locks at different scopes affect operations differently.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-tags-locks** from the list.
3.  In the left menu, under **Settings**, select **Locks**.
3.  Select **+ Add**.
4.  For **Lock name**, enter **read-only-rg**.
5.  For **Lock type**, select **Read-only**.
6.  Optionally add a note such as **Prevents modifications to the resource group and its resources**.
7.  Select **OK**.
8.  Confirm the lock appears in the locks list. 

> [!NOTE]
> You should also see the **prevent-delete** lock listed here with a scope of the storage account—resource group locks inherit and display locks from child resources.

> [!NOTE]
> **Validation step:** Confirm the resource group Locks pane shows both the **read-only-rg** lock and the **prevent-delete** lock (scoped to the storage account).

> [!NOTE]
