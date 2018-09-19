In the previous exercises, we created a directory, created a user and group, and then created a conditional access rule that requires Azure Multi-Factor Authentication when accessing the Azure portal. Now, we'll test if we can access our resources.

## Test access to resources

You know that your users will sign in and access all their SaaS applications using the MyApps portal, so this is what we'll test.

1. Open an InPrivate browser window.

1. Browse to https://myapps.microsoft.com.

1. Sign in as the user that we created in Unit 3.

   * Notice that you're signed in to the portal without requiring Multi-Factor Authentication.

1. In the same browser window, browse to https://portal.azure.com.

   * Notice that you're now required to provide more information to keep your account secure. This interrupt is Azure Multi-Factor Authentication kicking in because of the conditional access policy we created. You can stop at this point and close the browser window.