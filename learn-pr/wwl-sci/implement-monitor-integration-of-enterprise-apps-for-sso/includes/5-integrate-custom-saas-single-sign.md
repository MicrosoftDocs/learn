Apps can delegate maintenance of their own username and password information to a centralized identity provider.  Delegating authentication and authorization to it enables scenarios such as Conditional Access policies that require a user to be in a specific location. The use of [multi-factor authentication](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-howitworks) (sometimes referred to as two-factor authentication or 2FA), enables a user to sign in once and then be automatically signed in to all of the web apps that share the same centralized directory.

Microsoft identity platform simplifies authorization and authentication for application developers by providing identity as a service, with support for industry-standard protocols such as OAuth 2.0 and OpenID Connect, as well as open-source libraries for different platforms to help you start coding quickly. It allows developers to build applications that sign in all Microsoft identities, get tokens to call Microsoft Graph, other Microsoft APIs, or APIs that developers have built.

The following list is a brief comparison of the various protocols used by Microsoft identity platform.

- **OAuth vs. OpenID Connect**: OAuth is used for authorization and OpenID Connect (OIDC) is used for authentication. OpenID Connect is built on top of OAuth 2.0, which means the terminology and flow are similar between the two. You can even authenticate a user using OpenID Connect and get authorization to access a protected resource that the user owns using OAuth 2.0 in one request.

- **OAuth vs. SAML**: OAuth is used for authorization and Security Assertion Markup Language (SAML) is used for authentication.

- **OpenID Connect vs. SAML**: Both OpenID Connect and SAML are used to authenticate a user and are used to enable single sign-on. SAML authentication is commonly used with identity providers such as Active Directory Federation Services (ADFS) federated to Azure AD and is therefore frequently used in enterprise applications. OpenID Connect is commonly used for apps that are purely in the cloud, such as mobile apps, web sites, and web APIs.

If you have an application that you want to integrate with AzureAD providing the single sign-on experience for your users, please see the article ClaimsXRay in Azure AD with Directory Extension, linked below:

[ClaimsXRay in Azure AD with Directory Extension](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/claimsxray-in-azuread-with-directory-extension/ba-p/1505737)

