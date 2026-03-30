This guided project consists of the following exercises:

 - Create storage and upload file
 - Create access policy and generate SAS
 - Test partner access
 - Revoke partner access
 - **Configure lifecycle management**

In this exercise, you create a lifecycle management rule that automatically deletes files in the partner container after 30 days. This adds a cleanup safety net so that shared files don't accumulate indefinitely.

This exercise includes the following tasks:

 - Create a lifecycle management rule
 - Review the rule configuration

**Outcome:** A lifecycle rule that automatically deletes shared files after a set number of days.

Revoking SAS access stops partners from reaching the file, but the file itself stays in the container. For a partner exchange scenario, shared files shouldn't linger indefinitely. A **lifecycle management rule** automatically deletes blobs after a specified number of days, ensuring that old shared files are cleaned up without manual intervention.

## Task 1: Create a lifecycle management rule

Configure a rule that automatically deletes blobs in the **partner-drop** container after 30 days.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select your storage account (for example, **stgpfilexchg**).
3.  In the left menu, under **Data management**, select **Lifecycle management**.
4.  Select **+ Add a rule**.
5.  For **Rule name**, enter **delete-shared-files**.
6.  For **Rule scope**, select **Limit blobs with filters**.
7.  Under **Blob type**, confirm **Block blobs** is selected.
8.  Select **Next**.
9.  On the **Base blobs** tab, for **Base blobs were**, select **Last modified**.
10. For **More than (days ago)**, enter **30**.
11. For **Then**, select **Delete the blob**.
12. Select **Next**.
13. On the **Filter set** tab, under **Prefix match**, enter **partner-drop/**.

    > [!NOTE]
    > The prefix **partner-drop/** scopes this rule to only the partner exchange container. Blobs in other containers are not affected.

14. Select **Add**.

> [!NOTE]
> **Validation step:** Confirm the **delete-shared-files** rule appears in the lifecycle management rules list.

## Task 2: Review the rule configuration

Verify the rule details to make sure it targets the right container and action.

1.  On the **Lifecycle management** page, select the **delete-shared-files** rule to review its details.
2.  Confirm the following settings:
    -   **Scope:** Limited to blobs with prefix **partner-drop/**
    -   **Condition:** Last modified more than 30 days ago
    -   **Action:** Delete the blob
3.  Close the rule details view.

> [!NOTE]
> Lifecycle rules run once per day. In a production environment, blobs that meet the 30-day condition would be deleted during the next rule execution cycle. You won't see the rule execute during this project, but the configuration is in place.

> [!NOTE]
> **Validation step:** Confirm the rule targets the **partner-drop/** prefix with a 30-day delete action.