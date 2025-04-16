You can declare app roles using the app roles UI.

> [!IMPORTANT]
> The app roles portal UI feature is in public preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Certain features might be unsupported or have constrained capabilities.

To create an app role by using the Azure portal's user interface:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using an Administrator account.
2. Open the portal menu and then select **Identity**.
3. On the **Identity** menu, under **Applications,** select **App registrations**.
4. Select **App roles**, and then select **Create app role**.
    
   :::image type="content" source="../media/app-roles-create-app-role.png" alt-text="Screenshot of the  app roles configuration wizard with create app role highlighted.":::
    
5. In the **Create app role** pane, in the **Display name** box, enter **Survey Writer**.
6. Under **Allow member types**, select **User/Groups**.
7. In the **Value** box, enter **Survey.Create**.
8. In the **Description** box, enter **Writers can create surveys**.
9. Notice that the description is a mandatory field.
10. Verify the **Do you want to enable this app role** is selected and then select **Apply.**

## Assign users and groups to roles

Once you've added app roles in your application, you can assign users and groups to the roles. Assign users and groups to roles through the portal's UI or programmatically using [Microsoft Graph](/graph/api/user-post-approleassignments). When the users assigned to the various app roles sign in to the application, their tokens will have their assigned roles in the roles claim.

To assign users and groups to roles by using the Azure portal:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
2. In the Identity navigation menu on the left, open **Applications** select **Enterprise applications.**
3. In the **All applications** list, select **Demo app**.
4. This app was created in an earlier exercise.
5. Under **Manage**, select **Users and groups.**
6. On the menu, select **+ Add user/group.**
7. On the **Add Assignment** dialog, select **Users and groups**.
8. A list of users and security groups is displayed. You can search for a certain user or group, as well as select multiple users and groups that appear in the list.
9. After you have selected users and groups, select **Select**.
10. When using the **Select a role** assignment, all the roles that you've defined for the application are displayed.
11. Choose a role and then select **Select**.
12. Select **Assign** to finish the assignment of users and groups to the app.
13. Confirm that the users and groups you added appear in the **Users and groups** list.
