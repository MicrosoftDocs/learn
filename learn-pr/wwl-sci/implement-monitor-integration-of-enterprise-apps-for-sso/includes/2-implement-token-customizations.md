You can specify the lifetime of a token issued by Microsoft identity platform. Additionally, you can set token lifetimes for all apps in your organization, for a multi-tenant (multi-organization) application, or for a specific service principal in your organization. In Azure Active Directory (Azure AD), part of Entra, a policy object represents a set of rules that are enforced on individual applications or on all applications in an organization. Each policy type has a unique structure, with a set of properties that are applied to objects to which they're assigned.

You can designate a policy as the default policy for your organization. The policy is applied to any application in the organization, as long as it isn't overridden by a policy with a higher priority. You also can assign a policy to specific applications. The order of priority varies by policy type.

## Configure authentication session management with Conditional Access

In complex deployments, organizations might have a need to restrict authentication sessions. These complex scenarios might include:

 -  Resource access from an unmanaged or shared device.
 -  Access to sensitive information from an external network.
 -  High-impact users.
 -  Critical business applications.

Conditional Access controls allow you to create policies that target specific use cases within your organization without affecting all users.

For more information see the link in the resources at the end of this module.

## Customize Tokens for Azure AD

| **Access and ID token lifetime**                        | **Refresh token lifetime (days)**                                                              | **Refresh token sliding windows lifetime** | **Lifetime length (days)**                                      |
| ------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------ | --------------------------------------------------------------- |
| The lifetime of the OAuth 2.0 bearer token and ID token | The maximum time period before which a refresh token can be used to acquire a new access token | The refresh token sliding window type      | After time period elapses, the user is forced to reauthenticate |

:::image type="content" source="../media/token-customize-timeline-4817b4d6.png" alt-text="Diamgram of the Refresh token lifetime - token is valid for a specified amount of time and the access token must be refreshed before it expires.":::


## Configure optional claims as part of your token

Application developers can use optional claims in their Azure AD applications to specify which claims they want in tokens sent to their application.

You can use optional claims to:

 -  Select other claims to include in tokens for your application.
 -  Change the behavior of certain claims that the Microsoft identity platform returns in tokens.
 -  Add access custom claims for your application.

While optional claims are supported in both v1.0 and v2.0 format tokens, and SAML tokens, they provide most of their value when moving from v1.0 to v2.0. One of the goals of the Microsoft identity platform is smaller token sizes to ensure optimal performance by clients. As a result, several claims formerly included in the access and ID tokens are no longer present in v2.0 tokens and must be asked for specifically on a per-application basis.

:::image type="content" source="../media/token-configuration-claims-6ee5c231.png" alt-text="Screenshot of the Configure custom roles and claims for the S A M L token issued when you configure sign-sign-on.":::
