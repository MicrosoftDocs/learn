In this module, you have explored the OpenID Connect concepts for authentication.

Using an example application you have used the OpenID Connect ASP.Net OWIN middleware to sign in users from a single Azure AD tenant. You can now enable your applications to sign in with Azure AD identities. This will simplify login for your users by enabling them to sign in with the same accounts they use for Office 365.

## Clean up

The sandbox will clean up your resources automatically for you when you are finished with this module. However, the Azure AD tenant you created must be deleted manually.

To delete the Azure AD tenant, follow these steps:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the top bar, click on your account, and then click **Switch directory**.
1. Click on the **Learn Module AAD Tenant** you created in unit 4.
1. In the navigation on the left, click **Azure Active Directory**, click **App Registrations**, and then click the **WebApp-OpenIDConnect-DotNet** registration.
1. Click **Delete** and then click **Yes**.
1. In the navigation on the left, click **Azure Active Directory**, and then under **Manage**, click **Properties**.
1. Under **Access management for Azure resources**, click **Yes**, and then click **Save**.
1. In the top right of the portal, click your user account, and then click **Sign out**.
1. Sign in with your normal credentials. In the top bar, click on your account, and then click **Switch directory**.
1. Click on the **Learn Module AAD Tenant** you created in unit 4.
1. In the navigation on the left, click **Azure Active Directory**, click **Delete directory**, and then click **Delete**.
1. In the top right of the portal, click your user account, and then click **Sign out**.

## Further reading

- [Authorize access to web applications using OpenID Connect and Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/develop/v1-protocols-openid-connect-code)
- [OpenID Connect specification](https://openid.net/specs/openid-connect-core-1_0.html)
- [ID tokens](https://docs.microsoft.com/en-us/azure/active-directory/develop/id-tokens)
- [Azure Active Directory access tokens](https://docs.microsoft.com/en-us/azure/active-directory/develop/access-tokens)
