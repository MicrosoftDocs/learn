This module examined how a Java web application can use Microsoft Entra ID for sign-in and delegated access to Microsoft Graph. The walkthroughs used illustrative configuration, code, and responses; completing the module didn't require creating resources or running an application.

You explored how:

- An application registration defines the application's identity, sign-in audience, redirect URI, and credential configuration.
- MSAL4J constructs authorization URLs, exchanges authorization codes for tokens, and supports later token acquisition through a cache.
- Delegated permissions, consent, and an API-specific access token allow a Graph client to read the signed-in user's profile.

A single-tenant audience includes user and guest accounts in the selected tenant; it doesn't enforce employee-only access. Authentication establishes identity, while API permissions and application-specific authorization rules determine access.

The examples also distinguish the participants in the flow. The browser returns an authorization code to the application's callback, the server uses MSAL4J to acquire tokens, and a Graph client uses the access token to request profile data. The historical source excerpts aren't a complete or production-ready implementation.

## References

- [Microsoft identity platform app types and authentication flows](/entra/identity-platform/authentication-flows-app-scenarios)
- [Single and multitenant apps](/entra/identity-platform/single-and-multi-tenant-apps)
- [MSAL overview](/entra/identity-platform/msal-overview)
- [Microsoft Authentication Library for Java](https://github.com/AzureAD/microsoft-authentication-library-for-java)
- [User and admin consent](/entra/identity/enterprise-apps/user-admin-consent-overview)
- [Microsoft Graph overview](/graph/overview)
- [Microsoft Graph SDK for Java](https://github.com/microsoftgraph/msgraph-sdk-java)
- [Tutorial: Enable your Java Servlet web app to sign in users and call APIs with the Microsoft identity platform](https://github.com/Azure-Samples/ms-identity-java-servlet-webapp-authentication)
