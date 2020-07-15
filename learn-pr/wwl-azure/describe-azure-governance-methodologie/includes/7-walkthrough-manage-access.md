## Exercise - Manage access with Role Based Access Control

> [!Note]
> This lab requires and Azure subscription.  No sandbox is available to perform this lab.

In this walkthrough, we will assign roles and view activity logs. 

## Task 1: View and assign roles

In this task, we will assign the Virtual machine contributor role. 

1. Sign in to the [Azure portal (https://portal.azure.com)](https://portal.azure.com?azure-portal=true).

2. From the **All services** blade, search for and select **Resource groups**, then click **+ Add**.

3. Create a new resource group. Click **Create** when you are finished. 

    | Setting | Value |
    | -- | -- |
    | Subscription | **Choose your subscription** |
    | Resource group | **myRGRBAC** |
    | Region | **(US) East US** |
    | | |

4. Create **Review + create** and then click **Create**.

5. **Refresh** the resource group page and click the entry representing the newly created resource group.

6. Click on the **Access control (IAM)** blade, and then switch to the **Roles** tab. Scroll through the large number of roles definitions that are available. Use the Informational icons to get an idea of each role's permissions. Notice there is also information on the number of users and groups that are assigned to each role.

    > [!div class="mx-imgBorder"]
    > ![Screenshot of IAM roles blade. Owner, contributor, and reader roles are shown.](../media/roles-blade.png)

7. Switch to the **Role assignments** tab of the **myRGRBAC - Access control (IAM)** blade, click **+ Add** and then click **Add role assignment**. Assign the Virtual Machine Contributor role to your user account, then click **Save**. 

    | Setting | Value |
    | -- | -- |
    | Role | **Virtual machine contributor** |
    | Assign access to | **Azure AD user, group, or service principal** |
    | Select | your user account |
    | | |

    > [!NOTE]
    > The Virtual machine contributor role lets you manage virtual machines, but not access their operating system or manage the virtual network and storage account they are connected to.

    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Add role assignment page filled out with the necessary information.](../media/role-assignment-page.png)

8. **Refresh** the Role assignments page and ensure you are now listed as a Virtual machine contributor. 

    > [!NOTE]
    > This assignment does not actually grant you any additional privileges, since your account has already the Owner role, which includes all privileges associated with the Contributor role.

## Task 2: Monitor role assignments and remove a role

In this task, we will view the activity log to verify the role assignment, and then remove the role. 

1. On the myRGRBAC resource group blade, click **Activity log**.

2. Click **Add filter**, select **Operation**, and then **Create role assignment**.

    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Activity log page with configured filter.](../media/activity-log-page.png)

3. Verify the Activity log shows your role assignment. 

    > [!NOTE]
    > Can you figure out how to remove your role assignment?

Congratulations! You have assigned roles and viewed activity logs. 

> [!NOTE]
> To avoid additional costs, you can remove this resource group. Search for resource groups, click your resource group, and then click **Delete resource group**. Verify the name of the resource group and then click **Delete**. Monitor the **Notifications** to see how the delete is proceeding.
