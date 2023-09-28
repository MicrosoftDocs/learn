## Assign Azure resource roles

Azure Active Directory (Azure AD) Privileged Identity Management (PIM) can manage the built-in Azure resource roles, as well as custom roles, including (but not limited to):

 -  Owner
 -  User Access Administrator
 -  Contributor
 -  Security Admin
 -  Security Manager

Follow these steps to make a user eligible for an Azure resource role.

1.  Sign in to the [Azure portal](https://portal.azure.com/) as a tenant administrator.
2.  Search for and then select **Azure AD Privileged Identity Management.**
3.  In the Privileged Identity Management blade, in the left navigation, select **Azure resources.**
4.  On the top menu, select **Discover resources**.
5.  In the Azure resources – Discovery blade, select your subscription and then, on the top menu, select **Manage resource**.
    
    :::image type="content" source="../media/privileged-identity-management-azure-resource-management-b548cd25.png" alt-text="Screenshot of the Azure resources discovery screen with the subscription and manage resource highlighted.":::
    
6.  In the **Onboarding selected resource for management** dialog box, review the information and then select **OK**.
7.  When onboarding completes, close the Azure resources – Discovery blade.
8.  In the Azure resources blade, select the resource you just added.
    
    :::image type="content" source="../media/privileged-identity-management-azure-resource-overview-b09e5a4e.png" alt-text="Screenshot displaying the recently added Azure resource.":::
    
9.  In the left navigation menu, under **Manage**, select **Roles** to see the list of roles for Azure resources.
10. On the top menu, select + **Add assignments**.
11. In the **Add assignments blade**, select the **Select role** menu and then select **API Management Service Contributor.**
12. Under **Select member(s),** select **No member selected**.
13. In the Select a member or group pane, select an account from your organization that will be assigned the role.
14. Select **Next**.
15. On the **Settings** tab, under **Assignment type**, select **Eligible**.
    
    
     -  **Eligible** assignments require the member of the role to perform an action to use the role. Actions might include performing a multi-factor authentication (MFA) check, providing a business justification, or requesting approval from designated approvers.
     -  **Active** assignments do not require the member to perform any action to use the role. Members assigned as active have the privileges always assigned to the role.
16. Specify an assignment duration by changing the start and end dates and times.
17. When finished, select **Assign**.
18. After the new role assignment is created, a status notification is displayed.

## Update or remove an existing resource role assignment

Follow these steps to update or remove an existing role assignment.

1.  Open **Azure AD Privileged Identity Management**.
2.  Select **Azure resources**.
3.  Select the resource you want to manage to open its overview page.
4.  Under **Manage**, select **Assignments**.
5.  On the **Eligible roles** tab, in the Action column, review the available options.
6.  Select **Remove**.
7.  In the **Remove** dialog box, review the information and then select **Yes**.
