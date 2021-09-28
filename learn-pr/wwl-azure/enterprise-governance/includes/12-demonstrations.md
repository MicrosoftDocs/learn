Use your own Azure subscription to perform these Try-This exercises - Enterprise Governance.

## Task 1 - Navigating Azure

In this task, you will learn how to access and use the Azure portal.

**Locate the Azure portal**

In this task, you will access the lab environment and the Azure portal.

1. Ask your instructor how to access the lab environment. 
1. After accessing the lab environment, navigate to the [Azure portal](https://portal.azure.com).
1. Bookmark this page. You will use the Portal throughout the course labs and demonstrations.
1. In the top right corner of the Portal, select your user account.
1. Notice you can **View account** and **Switch directory**.
1. **Switch directory** lets you view **My permissions** and **View my bill**.
1. Select the **Settings** icon (top right menu bar - cog icon).
1. Review the **Portal settings** including the **General** and **Language & region** settings.
1. Use the **Search resources, services, and docs** textbox to search for **Virtual machines**. 
1. You can search for not only general Azure resources but specifically named resources.
1. Select Use the **Portal menu** (left corner three bars icon).
1. Notice you can **Create a resource**, view **All services**, and view **All resources**.
1. Take some time to browse around the interface, search and explore different areas. 
1. Launch the **Cloud Shell** (first icon top menu bar).
1. Notice the drop-down for **PowerShell** or **Bash**. 

## Task 2 - Azure RBAC Role Assignments

In this task, we will learn about role assignments.

**Locate Access Control blade**

1. Access the Azure portal, and select a resource group. Make a note of what resource group you use. 
1. Select the **Access Control (IAM)** blade. 
1. This blade will be available for many different resources so you can control access.

**Review role permissions**

1. Select the **Roles** tab (top).
1. Review the large number of built-in roles that are available.
1. Double-click a role, and then select **Permissions** (top).
1. Continue drilling into the role until you can view the **Read, Write, and Delete** actions for that role.
1. Return to the **Access Control (IAM)** blade.

## Task 3 - Manage resource locks

**Note:** This task requires a resource group. 

In this task, we will create resource locks. 

1. In the **Portal** navigate to a resource group. 
1. In the **Settings** section, click **Locks**, and then click **+ Add**.
1. Discuss the different types of locks and applying the locks at different levels.
1. Create a new lock with a **Lock type** of **Delete**.
1. From the **Overview** blade, click **Delete resource group**. Type the name of the resource group and click **OK**. 
1. You should receive an error message stating the resource group is locked and can't be deleted.
1. Add a **Storage Account** to the resource group.
1. After the storage account is created, try to delete the storage account.
1. You receive an error message stating the resource or its parent has a delete lock. 
1. Review how the storage account inherits the lock from the parent and cannot be deleted.
1. Return to the resource group blade and, in the **Settings** section, click **Locks**.
1. Scroll all the way to the right, then click the **Delete** link to the right of the lock.
1. Return to the storage account and confirm you can now delete the resource.

