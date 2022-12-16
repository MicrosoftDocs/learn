## Assign Azure resource roles

Azure Active Directory (Azure AD) Privileged Identity Management (PIM) can manage the built-in Azure resource roles, as well as custom roles, including (but not limited to):

 -  Owner
 -  User Access Administrator
 -  Contributor
 -  Security Admin
 -  Security Manager

Follow these steps to make a user eligible for an Azure resource role.

1. Sign in to the [Azure portal](https://portal.azure.com/) as a tenant administrator.
1. Search for and then select **Azure AD Privileged Identity Management.**
1. In the Privileged Identity Management blade, in the left navigation, select **Azure resources.**
1. On the top menu, select **Discover resources**.
1. In the Azure resources – Discovery blade, select your subscription and then, on the top menu, select **Manage resource**.
    
    :::image type="content" source="../media/privileged-identity-management-azure-resource-management-b548cd25.png" alt-text="Screenshot of the Azure resources discovery screen with the subscription and manage resource highlighted.":::
    
1. In the **Onboarding selected resource for management** dialog box, review the information and then select **OK**.
1. When onboarding completes, close the Azure resources – Discovery blade.
1. In the Azure resources blade, select the resource you just added.
    
    :::image type="content" source="../media/privileged-identity-management-azure-resource-overview-b09e5a4e.png" alt-text="Screenshot displaying the recently added Azure resource.":::
    
1. In the left navigation menu, under **Manage**, select **Roles** to see the list of roles for Azure resources.
1. On the top menu, select + **Add assignments**.
1. In the **Add assignments blade**, select the **Select role** menu and then select **API Management Service Contributor.**
1. Under **Select member(s),** select **No member selected**.
1. In the Select a member or group pane, select an account from your organization that will be assigned the role.
1. Select **Next**.
1. On the **Settings** tab, under **Assignment type**, select **Eligible**.
    
    
     -  **Eligible** assignments require the member of the role to perform an action to use the role. Actions might include performing a multi-factor authentication (MFA) check, providing a business justification, or requesting approval from designated approvers.
     -  **Active** assignments do not require the member to perform any action to use the role. Members assigned as active have the privileges always assigned to the role.
1. Specify an assignment duration by changing the start and end dates and times.
1. When finished, select **Assign**.
1. After the new role assignment is created, a status notification is displayed.

## Update or remove an existing resource role assignment

Follow these steps to update or remove an existing role assignment.

1. Open **Azure AD Privileged Identity Management**.
1. Select **Azure resources**.
1. Select the resource you want to manage to open its overview page.
1. Under **Manage**, select **Assignments**.
1. On the **Eligible roles** tab, in the Action column, review the available options.
1. Select **Remove**.
1. In the **Remove** dialog box, review the information and then select **Yes**.
