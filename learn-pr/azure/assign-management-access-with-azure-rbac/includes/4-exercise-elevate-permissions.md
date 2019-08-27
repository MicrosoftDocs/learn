After the departure of a senior manager, your organization needs to provide full subscription management access to their successor.

In this unit, you'll:

- Give yourself access to the User Access Administrator role.
- Consider how to assign subscription ownership to a given user.
- See how to revoke the User Access Administrator role after you've finished.

## Elevate permissions to User Access Administrator

1. Sign in to the Azure portal as the Azure AD global administrator.

1. Go to the properties section of Azure Active Directory and turn on 'Access Management for Azure Resources'. This action causes the 'User Access Administrator' role to be assigned at the root level. <!--CE:PLEASE CHECK - I've added bold in these instructions where I think it's appropriate.-->Select **Save**.
<!--TODO: screenshot as per the first screenshot here https://docs.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin, but with the 'Access Management for Azure resources' section highlighted, it should be possible to do this within a single screenshot-->

1. To update your access level, sign out of the Azure portal then sign back in.

1. Verify that you have the User Access Administrator role at root scope. Use Azure search to browse for 'Subscriptions', select the relevant subscription, select **Access Control (IAM)**, then select **Role Assignments**.
<!--TODO: include screenshot as per the third screenshot here https://docs.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin-->

1. If you wanted to delegate access to a new manager to own an Azure subscription, you'd go to the Access Control (IAM) pane within 'Subscriptions' – as in the previous step – select **Role Assignments**, then select **Add** > **Add Role Assignment**. Select the **Owner** role then, in the directory, provide the name or email address of the user who you want to make an owner of that subscription.

1. After completing the exercise, you return to the properties section of Azure Active Directory to turn 'Access Management for Azure Resources' back off. To avoid inadvertently creating further unplanned RBAC permissions, the 'User Access Administrator' role will be revoked at root scope.