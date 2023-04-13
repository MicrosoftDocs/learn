## Configure Azure AD role settings

### Open role settings

Follow these steps to open the settings for an Azure AD role.

1. Sign in to the [Azure portal](https://portal.azure.com/) as a tenant administrator.
1. Search for and then select **Azure AD Privileged Identity Management.**
1. In the Privileged Identity Management screen, in the left navigation, select **Azure AD roles.**
1. On the Quick start page, in the left navigation, select **Settings.**
    
    :::image type="content" source="../media/privileged-identity-management-roles-settings-bfd346da.png" alt-text="Screenshot of the Azure AD roles page with the Settings menu highlighted.":::
    
1. Review the list of roles and then, in the **Search by role name**, enter **compliance**.
1. In the results, select **Compliance Administrator**.
1. Review the role-setting details information.

### Require approval to activate

If setting multiple approvers, approval completes as soon as one of them approves or denies. You can't require approval from at least two users. To require approval to activate a role, follow these steps.

1. In the Role setting details page, on the top menu, select **Edit**.
    
    :::image type="content" source="../media/privileged-identity-management-edit-compliance-role-a95707aa.png" alt-text="Screenshot of the top portion of the Role setting details -Compliance Administrator page with Edit highlighted.":::
    
1. In the Edit role setting – Compliance Administrator screen, select the **Require approval to activate** check box.
1. Select **Select approvers**.
1. In the Select a member pane, select your administrator account, and then select **Select**.
    
    :::image type="content" source="../media/privileged-identity-management-add-approver-b44ec980.png" alt-text="Screenshot of the edit role settings blade and select a member pane with the selected members highlighted.":::
    
1. Once you have configured the role settings, select **Update** to save your changes.
