Before rolling out single sign-on to employees in the organization, it's important to test the single sign-on relationship between the identity provider and the service provider.

In the previous units, the application was configured for single sign-on at the identity provider and at the service provider.

Testing the single sign-on configuration can be done in any of the following ways:

- Select **Test** on the single sign-on configuration pane for the application in Azure portal. This redirects to the sign-on URL where the sign-in flow can be initiated.
- Go to the sign-on URL directly and initiate the sign-on flow from there.
- Use the My Apps portal. When you select the application tile in My Apps, this redirects to the sign-on URL.

## Test from the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com/) using the test user account that was created.
1. Select **Identity**, and then select **Azure Active Directory**.
1. On the **Azure Active Directory** pane, under **Manage**, select **Enterprise applications**.
1. In the **Search application** box, enter **Azure AD SAML Toolkit**, and then select the application in the list.
1. Select **Single sign-on**, and then at the bottom of the **SAML-based Sign-on** pane, select **Test**.

    :::image type="content" source="../media/test-sso.png" alt-text="Screenshot showing where to test the single sign-on configuration in the Azure AD tenant." border="true":::
