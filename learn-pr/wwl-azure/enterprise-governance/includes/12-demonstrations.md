
Use your own Azure subscription to perform these Try-This exercises - Enterprise Governance.

## Task 1 - Navigating Azure

In this task, you'll learn how to access and use the Azure portal.

**Locate the Azure portal**

In this task, you'll access the lab environment and the Azure portal.

1.  Ask your instructor how to access the lab environment.
2.  After accessing the lab environment, navigate to the [Azure portal](https://portal.azure.com).
3.  Bookmark this page. You'll use the Portal throughout the course labs and demonstrations.
4.  In the top right corner of the Portal, select your user account.
5.  Notice you can **View account** and **Switch directory**.
6.  **Switch directory** lets you view **My permissions** and **View my bill**.
7.  Select the **Settings** icon (top right menu bar - cog icon).
8.  Review the **Portal settings** including the **General** and **Language & region** settings.
9.  Use the **Search resources, services, and docs** textbox to search for **Virtual machines**.
10. You can search for not only general Azure resources but specifically but named resources.
11. Select Use the **Portal menu** (left corner three bars icon).
12. Notice you can **Create a resource**, view **All services**, and view **All resources**.
13. Take some time to browse around the interface, search and explore different areas.
14. Launch the **Cloud Shell** (first icon top menu bar).
15. Notice the drop-down for **PowerShell** or **Bash**.

## Task 2 - Azure RBAC Role Assignments

In this task, we'll learn about role assignments.

**Locate Access Control blade**

1.  Access the Azure portal, and select a resource group. Make a note of what resource group you use.
2.  Select the **Access Control (IAM)** blade.
3.  This blade is available for many different resources so you can control access.

**Review role permissions**

1.  Click the **Roles** tab (top).
2.  Select a desired role from the list by clicking the associated box next to the Role Name.
3.  Click the **View** link under the **Details** column on the far right of the page.
4.  The Permissions view is displayed including three columns from left to right that is (i.e., Other, Read, Write, and Delete) **Permissions**, and **Description**.
5.  Return to the **Access Control (IAM)** blade.<br>

## Task 3 - Manage resource locks

**Note:** This task requires a resource group.

In this task, we'll create resource locks.

1.  In the **Portal** navigate to a resource group.
2.  In the **Settings** section, click **Locks**, and then click **+ Add**.
3.  Discuss the different types of locks and applying the locks at different levels.
4.  Create a new lock with a **Lock type** of **Delete**.
5.  From the **Overview** blade, click **Delete resource group**. Type the name of the resource group and click **OK**.
6.  You should receive an error message stating the resource group is locked and can't be deleted.
7.  Add a **Storage Account** to the resource group.
8.  After the storage account is created, try to delete the storage account.
9.  You receive an error message stating the resource or its parent has a delete lock.
10. Review how the storage account inherits the lock from the parent and can't be deleted.
11. Return to the resource group blade and, in the **Settings** section, click **Locks**.
12. Scroll all the way to the right, then click the **Delete** link to the right of the lock.
13. Return to the storage account and confirm you can now delete the resource.
