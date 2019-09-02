Your organization needs to provide full subscription management access to the person replacing the previous administrator. You will need to assign the user with the correct access levels. You will need to have the correct permissions yourself to achieve this.

In this unit, you'll give yourself access to the User Access Administrator role. You'll look at how to assign subscription ownership to a given user. You'll then revoke the User Access Administrator role.

## Elevate permissions to User Access Administrator

1. Sign in to the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>) as the Azure AD global administrator.
1. Select **Azure Active Directory**, then select **Properties**.
![Azure Active Directory properties](../media/2-active-directory-properties.png)<!-- Original image: https://docs.microsoft.com/en-us/azure/role-based-access-control/media/elevate-access-global-admin/aad-properties.png -->
1. Select **Yes** on the access management for Azure resources toggle, and then select **Save**.
![Access management for Azure resources](../media/2-access-management-azure-resources.png)<!-- Original image: https://docs.microsoft.com/en-us/azure/role-based-access-control/media/elevate-access-global-admin/aad-properties-global-admin-setting.png -->

### Verify that you have the User Access Administrator role

1. Use the search box at the top of the portal to search for "Subscriptions", then select **Subscriptions**.
1. Select the relevant subscription, select **Access Control (IAM)**, then select **Role Assignments**.
![Check User Access Administrator role](../media/4-check-role.png)
<!-- Original image: https://docs.microsoft.com/en-us/azure/role-based-access-control/media/elevate-access-global-admin/iam-root.png -->
1. Scroll down to the **USER ACCESS ADMINISTRATOR** section, and check that your login has **Root (inherited)** scope.

## Assign subscription ownership

1. On the Access control (AIM) pane, at the top, select **+ Add**.
1. In the menu, select **Add role assignment**.
1. Set the **Role** field to **Owner**.
1. In the **Select** field, use the username or email of the users you want to grant access to. Select that user.

    ![text](../media/4-add-owner-role.png)
    
1. The select **Save**.

When you're finished, you'll need to return to the properties section of Azure Active Directory to set access management for Azure resources back to **No**.
