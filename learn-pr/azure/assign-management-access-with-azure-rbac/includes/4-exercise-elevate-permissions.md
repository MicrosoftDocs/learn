Your organization needs to provide full subscription management access to the person replacing the previous administrator. You will need to assign the user with the correct access levels. You will need to have the correct permission to achieve this.

In this unit, you'll give yourself access to the User Access Administrator role. You'll look at how to assign subscription ownership to a given user. And you'll learn how to revoke the User Access Administrator role when the time comes.

## Elevate and revoke permissions to User Access Administrator

1. Sign in to the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>) as the Azure AD global administrator.
1. Select **Azure Active Directory > Properties** as shown below.
![Azure Active Directory properties](../media/2-active-directory-properties.png)<!-- Original image: https://docs.microsoft.com/en-us/azure/role-based-access-control/media/elevate-access-global-admin/aad-properties.png -->
1. Select **Yes** on the access management for Azure resources toggle as shown below, and select **Save**.
![Access management for Azure resources](../media/2-access-management-azure-resources.png)<!-- Original image: https://docs.microsoft.com/en-us/azure/role-based-access-control/media/elevate-access-global-admin/aad-properties-global-admin-setting.png -->
1. To update your access level, sign out of the Azure portal then sign back in.
1. Verify that you have the User Access Administrator role at root scope. Use the search box at the top of the portal to search for "Subscriptions", then select **Subscriptions**.
1. Select the relevant subscription, select **Access Control (IAM)**, then select **Role Assignments**.
![Check User Access Administrator role](../media/4-check-role.png)
<!-- Original image: https://docs.microsoft.com/en-us/azure/role-based-access-control/media/elevate-access-global-admin/iam-root.png -->
>[!NOTE] If you wanted to allow the new manager to own an Azure subscription, you'd go to the Access Control (IAM) pane in your subscription as in the previous step. You would then select **Role Assignments**, then select **Add** > **Add Role Assignment**. Then finally select the **Owner** role before you provide the name or email address of the user who you want to make an owner of that subscription.

When you are finished, you will need to return to the properties section of Azure Active Directory to set access management for Azure resources back to **No**. To avoid inadvertently creating further unplanned RBAC permissions, the User Access Administrator role will be revoked.
