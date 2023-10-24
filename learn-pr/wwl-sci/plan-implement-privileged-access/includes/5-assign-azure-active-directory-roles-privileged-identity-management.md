With Microsoft Entra ID, a Global administrator can make permanent Microsoft Entra admin role assignments. These role assignments can be created using the Azure portal or using PowerShell commands.

The Microsoft Entra Privileged Identity Management (PIM) service also allows Privileged role administrators to make permanent admin role assignments. Additionally, Privileged role administrators can make users eligible for Microsoft Entra admin roles. An eligible administrator can activate the role when they need it, and then their permissions expire once they're done.

## Assign a role

Follow these steps to make a user eligible for a Microsoft Entra admin role.

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a tenant administrator.
2.  Search for and then select **Microsoft Entra Privileged Identity Management.**
3.  In the Privileged Identity Management screen, in the left navigation, select **Microsoft Entra roles.**
4.  On the Quick start page, in the left navigation, select **Roles**.
5.  On the top menu, select **+ Add assignments.**
    
    :::image type="content" source="../media/privileged-identity-management-assign-role-e3e1744f.png" alt-text="Screenshot of the Microsoft Entra roles with Add assignments menu highlighted.":::
    
6.  In the Add assignments pane, on the **Membership** tab, review the settings.
7.  Select the **Select role** menu and then select **Compliance Administrator**. You can use the **Search role by name** filter to help located a role.
8.  Under **Select member(s),** select **No members selected**.
9.  In the Select a member pane, select your administrator account, and then select **Select**.
    
    :::image type="content" source="../media/privileged-identity-management-add-role-assignment-38075706.png" alt-text="Screenshot of the select a member pane with a selected member highlighted.":::
    
10. In the Add assignments screen, select **Next**.
11. On the **Settings** tab, under **Assignment type**, review the available options. For this task, use the default setting.
    
    
     -  Eligible assignments require the member of the role to perform an action to use the role. Actions might include performing a multifactor authentication (MFA) check, providing a business justification, or requesting approval from designated approvers.
     -  Active assignments don't require the member to perform any action to use the role. Members assigned as active have the privileges always assigned to the role.
12. Review the remaining settings and then select **Assign**.

## Activate your Microsoft Entra roles

When you need to assume a Microsoft Entra role, you can request activation by opening **My roles** in Privileged Identity Management.

1.  On the Privileged Identity Management screen, in the left navigation menu, select **My roles.**
2.  In the My roles pane, review the list of eligible assignments.
    
    :::image type="content" source="../media/my-roles-57af22c4.png" alt-text="Screenshot of the My roles with eligible role assignments highlighted. Pick the role you need.":::
    
3.  In the Compliance Administrator role row, select **Activate**.
4.  In the Activate – Compliance Administrator pane, select **Additional verification required,** and then follow the instructions to provide extra security verification. You're required to authenticate only once per session.
    
    :::image type="content" source="../media/privileged-identity-management-activate-role-f10cc7f1.png" alt-text="Screenshot of a popup to activate the compliance administrator.":::
    
5.  After you've completed the security verification, in the Activate – Compliance Administrator pane, in the **Reason** box, enter the justification for activating this role.
6.  Select **Activate**.

## Assign a role with restricted scope

For certain roles, the scope of the granted permissions can be restricted to a single admin unit, service principal, or application. This procedure is an example if assigning a role that has the scope of an administrative unit.

1.  Browse to the Privileged Identity Management screen, and in the left navigation menu, select **Microsoft Entra roles.**
2.  In the Roles pane, on the top menu, select **+ Add assignments.**
3.  In the Add assignments screen, select the **Select role** menu, and then select **User administrator.**
4.  Select the **Scope type** menu and review the available options. For now, you'll use the **Directory** scope type.
    
    > [!TIP]
    > Go to [Manage administrative units in Microsoft Entra ID](/azure/active-directory/roles/administrative-units) to find more information about the administrative unit scope type.
5.  Similar to assigning a role without a restricted scope. Add members, and complete the settings options. For now, select **Cancel**.

## Update or remove an existing role assignment

Follow these steps to update or remove an existing role assignment.

1.  In the Open Microsoft Entra Privileged Identity Management then Microsoft Entra roles screen, in the left navigation, select **Assignments**.
2.  In **Assignments** list, for Compliance Administrator, review the options in the **Action** column.
    
    :::image type="content" source="../media/privileged-identity-management-edit-role-assignments-53cb448a.png" alt-text="Screenshot of the options listed in the action column of the Compliance Administrator.":::
    
3.  Select **Update** and review the options available in the Membership settings pane. When complete, close the pane.
4.  Select **Remove**.
5.  In the **Remove** dialog box, review the information, and then select **Yes**.
