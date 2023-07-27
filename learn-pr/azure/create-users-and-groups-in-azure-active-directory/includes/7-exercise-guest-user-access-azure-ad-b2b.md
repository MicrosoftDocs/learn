The external and internal developer teams want to work together, so you decide to create guest user access for the external developer team. 

Use the Azure portal to invite business-to-business (B2B) collaboration users. You can invite guest users to an Azure Active Directory (Azure AD) organization, group, or application. After you invite a user, their account is added to Azure AD, with a guest user type.

After you add a guest user to the organization, send them a direct link to a shared app. Have the guest user open the redemption URL in the invitation email.

## Add guest users to the organization

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true), and under **Azure services**, select **Azure Active Directory**. The **Overview** pane for your Azure AD appears.

1. In the left menu pane, under **Manage**, select **Users**. The **All users** pane appears.

1. On the top menu bar, select **New user**, then select **Invite external user**.

   :::image type="content" source="../media/7-new-guest-user.png" alt-text="Screenshot that shows the New guest user button.":::

   The **New user** pane opens.

1. Enter a display name and an email address to which you have access.

1. Select **Review + invite**, then select **Invite**. An invitation is sent to the email address you provided for the guest user. The **All users** pane appears. Notice that the user now appears in the list of users and has *Guest* as **User type**. You might need to refresh to see the new user.

## Add guest users to a group

1. In your Azure AD organization overview page, in the left menu pane, under **Manage**, select **Groups**. The **All groups** pane appears.

1. Search for and select **Developer group** in the list of groups. The **Developer group** pane appears.

1. In the left menu pane, under **Manage**, select **Members**. The **Members** pane appears for your developer group.

1. On the top menu bar, select **Add members**. The **Add members** pane appears.

1. Search for the guest account you added to the organization.

1. Select the account, and select **Select**. The **Members** pane for your developer group appears.

   You now see the user in the list of members for this group. You might need to refresh to see the new user.

## Add guest users to an application

1. Go to your Azure AD organization, and in the left menu pane, under **Manage**, select **Enterprise applications**. The **Enterprise applications | All applications** pane appears.

1. On the top menu bar, select **New application**.

   :::image type="content" source="../media/7-enterprise-application.png" alt-text="Screenshot that shows the New Application button.":::

   The **Browse Azure AD Gallery** pane appears.

1. Search for and select **DocuSign**. Once the app is added, the **Docusign** pane appears.

1. Select **Create**. The **Docusign | Overview** pane appears.

1. In the left menu pane, under **Manage**, select **Users and groups**. The **Users and groups** pane appears for Docusign.

1. On the top menu bar, select **Add user/group**.

   :::image type="content" source="../media/7-application-users-groups.png" alt-text="Screenshot that shows the Docusign application user and groups page.":::

   The **Add Assignment** pane appears.

1. Under **Users and groups**, select the **None Selected** link. The **Users and groups** pane appears.

1. Select the guest user you added in the previous exercise, and select **Select**. The **Add Assignment** pane reappears.

1. Select **Assign**. The **Users and groups** pane for Docusign appears. You now see the user in the list for this application.

1. To check that the correct access level is set, select the user in the list.

   :::image type="content" source="../media/7-select-user.png" alt-text="Screenshot that shows the user selected on the users and groups page.":::

1. On the top menu bar, select **Edit**. The **Edit Assignment** pane appears.

1. Under **Select a role**, select the **None Selected** link. The **Select a role** pane appears.

1. Select **DocuSign Sender**, and then select **Select** to make sure they have the correct access.

   :::image type="content" source="../media/7-select-role.png" alt-text="Screenshot that shows role selected for user.":::

   The **Edit Assignment** pane reappears.

1. Select **Assign**. The **Users and groups** pane appears with the proper **Role assigned** as **DocuSign Sender** for the user you selected.

1. When the invitation arrives, the user accepts it, and can then access the application.

   :::image type="content" source="../media/7-application-visible-invitation-accepted.png" alt-text="Screenshot that shows the DocuSign app in the browser for the guest user after they've accepted the invitation.":::

You've now added a guest user to an application.

## Resend invitations to guest users

If the guest user didn't receive the first email invitation, you can resend an invitation email.

1. In your Azure AD organization, in the left menu pane, under **Manage**, select **Users**. The **All users** pane appears.

1. Select the user. The **Profile** pane for the user appears.

1. In the **B2B collaboration** section, select the **Resend invitation** link.

1. Select **Resend**.
