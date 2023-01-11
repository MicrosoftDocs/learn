Here, you'll register the user account at the service provider that matches the account that was created at the identity provider, then configure single sign-on for the account.

## Register an account

Matching accounts must be created at both the identity provider and the service provider. Some applications in the gallery can be configured directly, but others require a request be made to the application support team to do the configuration.

In this module, the **Azure AD SAML Toolkit** application represents an application that was requested by a team in the organization to help with productivity. This application has been set up to allow the administrator to register user accounts and configure single sign-on without having to contact the support team.

To register a user account with the **Azure AD SAML Toolkit** application:

1. Open a new browser window and browse to the sign-in URL for the application. For the **Azure AD SAML Toolkit** application, the address is `https://samltoolkit.azurewebsites.net`.
1. Select **Register** in the upper right corner of the page.

    :::image type="content" source="../media/toolkit-register.png" alt-text="Screenshot showing where to register a new user account at the application host." border="true":::

1. For **Email**, enter the email address of the user that will access the application. For example, the user account that was created that uses the address of `contosouser1@contoso.com`. Be sure to change `contoso.com` to the domain of the Azure AD tenant where the application is located.
1. Enter a **Password** and confirm it.
1. Select **Register**.

## Configure single sign-on

Use the values that were recorded in the previous unit to configure single sign-on at the service provider.

To configure SAML settings for the application:

1. Once you've signed in with the credentials of the user account that you registered, select **SAML Configuration** at the upper-left corner of the page.
1. Select **Create** in the middle of the page.

    :::image type="content" source="../media/saml-config-host.png" alt-text="Screenshot showing where to configure single sign-on at the service provider." border="true":::

1. For **Login URL**, **Azure AD Identifier**, and **Logout URL**, enter the values that you recorded earlier.
1. Select **Choose file** to upload the certificate that you previously downloaded.
1. Select **Create**.

    :::image type="content" source="../media/saml-add-urls-sp.png" alt-text="Screenshot showing the URLs to add for single sign-on at the service provider." border="true":::

1. Copy the values of the **SP Initiated Login URL** and the **Assertion Consumer Service (ACS) URL** to be used in the next section.

    :::image type="content" source="../media/saml-record.png" alt-text="Screenshot showing the URLs to record for single sign-on at the identity provider." border="true":::

## Update the identity provider

Update the temporary values that were previously defined for **Reply URL (Assertion Consumer Service URL)** and **Sign on URL** in the Azure AD tenant using values from the service provider.

1. Sign in to the [Azure portal](https://portal.azure.com/) using one of the roles listed in the prerequisites.
1. Select **Identity**, and then select **Azure Active Directory**.
1. On the **Azure Active Directory** pane, under **Manage**, select **Enterprise applications**.
1. In the **Search application** box, enter **Azure AD SAML Toolkit**, then select the application in the list.
1. Select **Single sign-on**, and then select **Edit** in the **Basic SAML Configuration** box.
1. For **Reply URL (Assertion Consumer Service URL)**, enter the **Assertion Consumer Service (ACS) URL** value you recorded in the last section.
1. For **Sign on URL**, enter the **SP Initiated Login URL** value you recorded in the last section.
1. Select **Save**.
