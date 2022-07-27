In this exercise, we'll configure cross-tenant access settings that represent the access policies you want to apply to B2B collaboration with other Azure AD organizations. The default settings we configure will apply to all external Azure AD organizations.

Recall that in the financial firm example, outbound B2B collaboration would be allowed for all of your internal employees. Also by default, all inbound B2B collaboration would be blocked to protect your internal applications. Later, collaboration with a branch organization would be allowed only for all of their users. Here, you'll configure the default cross-tenant access settings for B2B collaboration.

[Diagram of the full financial firm example, with just the default settings highlighted.]

## Set default outbound cross-tenant access

Here, you'll configure your default outbound settings for B2B collaboration. You'll make sure your cross-tenant access settings will allow other Azure AD organizations to invite your users to their organization for B2B collaboration.

[Diagram showing inbound collaboration allowed for all but one application.]

### Open the Azure Active Directory service in the portal

1. Open a web browser.
2. In the address bar, type https://portal.azure.com.
3. Sign in using your Azure AD admin account.
4. Open the Azure Active Directory service by following these steps:
   - Under **Azure services**, select **Azure Active Directory**, or
   - Use the search box search for "Azure Active Directory" and then select it.

### Configure default outbound settings

1. On the left navigation bar, select **External Identities**.
2. Select **Cross-tenant access settings**.
1. Select the **Default settings** tab.
2. Under **Outbound access settings**, select **Edit outbound defaults**.
3. Select **B2B collaboration**.
4. With **Users and groups** selected, make sure **Access status** is set to **Allow access**.
5. Under **Applies to**, make sure **All &lt;your organization name&gt; users** is selected.
6. Select **External applications**.
7. Make sure **Access status** is set to **Allow access** and make sure **Applies to** is set to All applications.
8. Select **Save**. You'll return to the main **Cross-tenant access settings** page. Stay on this page and go on to the next section.

## Set default inbound cross-tenant access

Now, you'll configure your default inbound settings to block all inbound B2B collaboration. You'll make sure your cross-tenant access settings will block everyone in other Azure AD organizations from being invited to your organization for B2B collaboration.

[Diagram showing inbound collaboration allowed with other Azure AD organizations.]

1. On the main **Cross-tenant access settings**, select the **Default settings** tab.
2. Under **Inbound access settings**, select **Edit inbound defaults**.
3. Select **B2B collaboration**.
4. With **External users and groups** selected, make sure **Access status** is set to **Block access**.
5. Under **Applies to**, make sure **All external users and groups** is selected.

    ![Screenshot showing default inbound access settings.](media/cross-tenant-access-settings-b2b-collaboration/generic-inbound-applications-add.png)

8. Select **Save**. You'll return to the main Cross-tenant access settings page. Stay on this page to check your work in the next section.

## Check your work

On the main **Cross-tenant access settings** page:

- In the **Inbound access settings** section, you should see two **B2B collaboration** rows. The **External users and groups** row should have a **Status** of **All blocked**.
- In the **Outbound access settings** section, you should see two **B2B collaboration** rows. Both of these rows should have a **Status** of **All allowed**.

[Screenshot showing outbound access settings set to All allowed.]

All your users can now be invited by other Azure AD organizations to use B2B collaboration, but all external Azure AD users are blocked from using B2B collaboration to access your applications.
