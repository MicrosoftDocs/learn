The ability to manage resources is granted by assigning roles that provide the required permissions. Roles can be assigned to individual users or groups. To align with the Zero Trust guiding principles, use Just-In-Time and Just-Enough-Access policies when assigning roles.

## Assign roles

There are two main steps to the role assignment process. First you'll select the role to assign. Then you'll adjust the role settings and duration.

### Select the role to assign

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a Privileged Role Administrator.
2.  Browse to **Identity** &gt; **Users** &gt; **All users**.
3.  :::image type="content" source="../media/microsoft-entra-users-page-a33719dc.png" alt-text="Screenshot showing the users page in the Microsoft Entra administration center.":::
    
4.  Search for and select the **user** getting the role assignment.
    
    :::image type="content" source="../media/select-existing-user-a4c17707.png" alt-text="Screenshot showing a list of principal users in the Azure portal.":::
    
5.  Select **Assigned roles** from the side menu, then select **Add assignments**.
    
    :::image type="content" source="../media/user-profile-assigned-external-identity-8af4f695.png" alt-text="Screenshot showing how to select assigned roles and apply assignments.":::
    
6.  Select a role to assign from the dropdown list and select the **Next** button.

## Adjust the role settings

You can assign roles as either **eligible** or **active**. Eligible roles are assigned to a user but must be elevated Just-In-Time by the user through Privileged Identity Management (PIM).

:::image type="content" source="../media/role-assignment-types-a006dc02.png" alt-text="Screenshot showing a users assigned role and active assignments in the Azure portal.":::


1.  From the Setting section of the **Add assignments** page, select an **Assignment type** option.<br>
2.  Leave the **Permanently eligible** option selected if the role should always be available to elevate for the user. If you uncheck this option, you can specify a date range for the role eligibility.
3.  Select the **Assign** button. Assigned roles appear in the associated section for the user, so eligible and active roles are listed separately.
    
    :::image type="content" source="../media/role-assignment-settings-71efc702.png" alt-text="Screenshot showing how to add an eligible or active assignment in the Azure portal.":::
    

## Update roles

You can change the settings of a role assignment, for example to change an active role to eligible.

1.  Browse to **Identity**, **Users**, **All users**.<br>
2.  Search for and select the user getting their role updated.<br>
3.  Go to the **Assigned roles** page and select the **Update** link for the role that needs to be changed.<br>
4.  Change the settings as needed and select the **Save** button.
    
    :::image type="content" source="../media/remove-update-role-assignment-024b45df.png" alt-text="Screenshot showing eligible assignments and available remove or update actions in the Azure portal.":::
    

## Remove roles<br>

You can remove role assignments from the **Administrative roles** page for a selected user.

1.  Browse to **Identity**, **Users**, **All users**.<br>
2.  Search for and select the user getting the role assignment removed.<br>
3.  Go to the **Assigned roles** page and select the **Remove** link for the role that needs to be removed. Confirm the change in the pop-up message.
