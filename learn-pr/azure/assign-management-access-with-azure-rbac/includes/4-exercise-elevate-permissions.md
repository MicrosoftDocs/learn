Your organization needs to provide full subscription management access to the person replacing the previous administrator. You'll need to assign the user with the correct access levels. To do that, you'll need to have the correct permissions yourself.

In this unit, you'll give yourself access to the User Access Administrator role. You'll look at how to assign subscription ownership to a given user. You'll then revoke the User Access Administrator role.

## Elevate permissions to User Access Administrator

1. Sign in to the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>) as the Azure AD global administrator.
1. Select **Azure Active Directory**, then select **Properties**.
    ![Screenshot that shows the Azure AD properties](../media/2-active-directory-properties.png)
1. Select **Yes** on the access management for Azure resources toggle, and then select **Save**.
    ![Screenshot that shows access management for Azure resources option](../media/2-access-management-azure-resources.png)

### Verify that you have the User Access Administrator role

1. Use the search box at the top of the portal to search for "Subscriptions", then select **Subscriptions**.
1. Select the relevant subscription, select **Access Control (IAM)**, then select **Role Assignments**.
    ![Screenshot that shows the User Access Administrator role assigned](../media/4-check-role.png)    
1. Scroll down to the **USER ACCESS ADMINISTRATOR** section, and check that you have the **Root (inherited)** scope.

## Assign subscription ownership

1. On the Access control (AIM) pane, at the top, select **+ Add**.
1. In the menu, select **Add role assignment**.
1. Set the **Role** field to **Owner**.
1. In the **Select** field, use the username or email of the users you want to grant access to. Select that user.

    ![Screenshot of the Add role assignment adding an Owner role to a user](../media/4-add-owner-role.png)
1. The select **Save**.

When you're finished, you'll need to return to the properties section of Azure Active Directory to set access management for Azure resources back to **No**.
