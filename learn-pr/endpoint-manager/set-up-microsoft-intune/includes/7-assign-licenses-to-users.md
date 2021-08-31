Microsoft Intune is available for different organization sizes and needs, from a simple-to-use management experience for schools and small businesses, to more advanced functionality required by enterprise customers. An admin must have a license assigned to them to administer Intune (unless you have selected to allow unlicensed admins).

Whether you added users one at a time or all at once, you must assign each user an Intune license before users can enroll their devices in Intune. The Microsoft Intune free trial provides 25 Intune licenses. For a list of licenses, see [Licenses that include Intune](/mem/intune/fundamentals/licenses?azure-portal=true).

> [!NOTE]
> 
> If you manage devices on-premises using Microsoft Endpoint Configuration Manager, you can also add cloud-based users and assign licenses to accounts synchronized from your on-premises Active Directory to Azure AD.

## Assign an Intune license to an individual user

The following steps allow you to assign an Intune license to a user:

1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Users** > **All Users** > *the user's name* > **Licenses** > **Assignments**. The **Update license assignments** pane is displayed.

2. Choose the box for **Intune** > **Save**.

   The user account now has the permissions needed to use the service and enroll devices into management.

## Assign Intune licenses to multiple users

The following steps allow you to assign Intune licenses to multiple users all at once:

1. Sign in to the [**Azure AD admin center**](https://aad.portal.azure.com).

    > [!NOTE]
    > To manage licenses, the admin account must be a license administrator, user administrator, or global administrator. The account you create using the Intune free trial is a global administrator.

2. Select **Azure Active Directory** > **Licenses** > **All products** to see and manage all licensable products that you have available for your organization.
3. Select the box next to **Intune**.
4. Click **Assign** > **Add users and groups**.
5. If you have created a group of users, click the group to add it to the **Selected items** list. Otherwise, select individual users that you have created earlier. Click **Select** to confirm your selection.

   [ ![Screenshot of Azure AD admin center with users selected.](../media/sign-up-for-intune-15.png) ](../media/sign-up-for-intune-15.png#lightbox)
  
6. Click **Next: Assignment options** to confirm **Microsoft Intune** is **On**.
7. Click **Review + assign** to confirm your license assignment settings.
10. Click **Assign** to assign the licenses to the selected users.

   A notification is displayed in the upper-right corner that shows the status and outcome of the process. If the assignment to the group couldn't be completed (for example, because of pre-existing licenses in the group), you can click the notification to view details.

   The user accounts now have the permissions needed to use the service and enroll devices into management.

You can also assign Intune licenses to users by using School Data Sync (SDS). For more information, see [Overview of School Data Sync](https://support.office.com/article/Overview-of-School-Data-Sync-and-Classroom-f3d1147b-4ade-4905-8518-508e729f2e91?azure-portal=true).