In this module, you explored the OpenID Connect concepts for authentication.

By using an example application, you used the OpenID Connect ASP.NET OWIN middleware to sign in users from a single Azure Active Directory (Azure AD) tenant. Users now sign in with the same accounts that they use for Microsoft 365.

## Clean up

To delete the Azure AD tenant, follow these steps:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the top bar, select your account, and then select **Switch directory**.
1. Select the **Learn Module AAD Tenant** directory that you created in unit 4.
1. In the left pane, select **Azure Active Directory**, select **App Registrations**, and then select the **WebApp-OpenIDConnect-DotNet** registration.
1. Select **Delete**, check the box to confirm deletion, and then select **Delete**.
1. In the left pane, select **Azure Active Directory**. Then under **Manage**, select **Properties**.
1. Under **Access management for Azure resources**, select **Yes**, and then select **Save**.
1. In the upper right of the portal, select your user account, and then select **Sign out**.
1. Sign in with your normal credentials. In the top bar, select your account, and then select **Switch directory**.
1. Select the **Learn Module AAD Tenant** directory that you created in unit 4.
1. In the left pane, select **Azure Active Directory**, then select **Manage tenants**.
1. Select the check box for the tenant you want to delete, then select **Delete**.
1. On the Delete Tenant page, select **Delete**.
1. In the upper right of the portal, select your user account, and then select **Sign out**.

## Further reading

- [OpenID Connect on the Microsoft identity platform](/azure/active-directory/develop/v2-protocols-oidc)
- [OpenID Connect specification](https://openid.net/specs/openid-connect-core-1_0.html)
- [ID tokens in the Microsoft identity platform](/azure/active-directory/develop/id-tokens)
- [Access tokens in the Microsoft identity platform](/azure/active-directory/develop/access-tokens)
