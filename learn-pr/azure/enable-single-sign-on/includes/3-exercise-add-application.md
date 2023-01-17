In this module, the **Azure AD SAML Toolkit** application represents the application that the team in the organization requested to help with company promotion.

The administrator reviews the application for single sign-on support and, if appropriate, adds it to the Azure AD tenant from the Azure AD application gallery. It's possible that not all applications that an organization uses are in the gallery. This module focuses on one that is.

The administrator then creates a user account in the Azure AD tenant and assigns it to the application to test single sign-on between the identity provider and the service provider.

## Access the application gallery

The Azure AD application gallery contains pre-integrated software as a service (SaaS) applications that can be added to a tenant. Applications that the retail company uses are probably already in the gallery. Locate the gallery from the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/) using one of the roles listed in the prerequisites and select **All services**.
1. Select **Identity**, and then select **Azure Active Directory**.

    :::image type="content" source="../media/select-azure-ad.png" alt-text="Screenshot showing where to find Azure Active Directory in the Azure portal." border="false":::

1. On the **Azure Active Directory** pane, under **Manage**, select **Enterprise applications**.
1. On the **Enterprise applications** pane, select **All applications** and then select **+ New application**.

    :::image type="content" source="../media/new-application.png" alt-text="Screenshot showing browsing to the enterprise applications pane." border="true":::

## Find and add an application

Search for the **Azure AD SAML Toolkit** application and add it to the tenant.

1. In the **Search application** box, enter **Azure AD SAML Toolkit**, and then select the application in the list.

    :::image type="content" source="../media/add-application.png" alt-text="Screenshot showing the addition of a new enterprise application." border="true":::

1. In the application overview pane that appears, enter a name for the application. Notice that the single sign-on modes listed for the application are SAML-based sign-on and linked sign-on. For this exercise, accept the default name.
1. Select **Create**

    :::image type="content" source="../media/create-application.png" alt-text="Screenshot showing the overview and creation of a new enterprise application." border="true":::

## Create a test user account

When setting up single sign-on for an application, test the configuration between the identity provider and the service provider before making it available to employees. Create a user account for the purposes of testing the configuration.

1. On the **Azure Active Directory** pane, under **Manage**, select **Users**.
1. Select **New user** at the top of the pane, then select **Create new user**.
1. In the **User name** field, enter the username of the user account. For example, `contosouser1@contoso.com`. Be sure to change `contoso.com` to the name of the tenant domain.
1. In the **Name** field, enter the name of the user of the account. For example, `contosouser1`.
1. Leave **Auto-generate password** selected, and then select **Show password**. Write down the value that's displayed in the **Password** box.
1. Select **Create**.

## Assign the test user account to the application

After the user account is created, assign it to the application that was added from the gallery.

1. On the application overview pane, under **Getting Started**, select **Assign users and groups**. Alternatively, in the left menu, under **Manage**, select **Users and groups**.
1. On the **Users and groups** pane, on the menu, select **+Add user/group**.

    :::image type="content" source="../media/add-user-account.png" alt-text="Screenshot showing the assignment of a user account to an enterprise application." border="true":::

1. On the **Add Assignment** pane, under **Users and groups**, select **None Selected**.
1. In the **Users and groups** pane, select the test user account and then click **Select**.
1. Select **Assign**.
