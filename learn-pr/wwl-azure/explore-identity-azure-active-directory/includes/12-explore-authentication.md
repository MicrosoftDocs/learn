
**Authentication** is validating the identity (user or app or device) is who they proclaim to be. Then also providing an appropriate level of validation and security throughout the authentication transaction.  Identity authentication provides:

- Flexible, standards compliant, authentication that integrates across  organizations
- Integration of disparate sources, applications, and protocols
- Employs many different industry standard methods of validation and assurance

Using an identity provider for authentication offers a way to ensure secure identities without limiting the capabilities of the users.  You get convenience, multiple sources for validating identity, industry protocols, and assurance of the identity.

**Convenience** - The convenience capability focuses on the end-users experience with how they are prompted for authentication credentials. Focus here is on the end-user experience.  If something is not easy, users will avoid it or complain about it.

**Sources** - The sources capability surrounds where the user obtains their authentication token from. Many organizations have what they believe is a centralized issuer (Azure Active Directory), but in reality most organizations also have other identity repositories.  Federated identity is the most common other identity provider.

**Protocols** - Often, organizations have a variety of authentication protocols in place which cause a deficient experience to both end-users and the organization. A focus area of this capability is to help an organization standardize on one, or more, modern and secure authentication protocols to accomplish their authentication goals.

**Assurance** - Authentication assurance is the confidence an organization has that an individual accessing a resource is who they say they are. This capability talks about whether or not an organization uses shared accounts, if they use personalized accounts and if solutions such as multi-factor authentication or risk-based authentication are in place.

### Federated identity
Federation is a collection of domains that have established trust. The level of trust may vary, but typically includes authentication and almost always includes authorization. This allows you to leverage existing identities from trusted sources, like an existing on-premises active directory.

### Common communication protocols in identity

| Protocol | Description and usage |
| :----- | :----- |
| SAML - Security Assertion Markup Language | Open standard for exchanging authentication and authorization data between an identity provider and a service provider. Common SAML attributes: |
|  | Principal = generally a user or device, IdP = identity provider, SP = service provider |
|  | IdP = identity provider |
|  | SP = service provider |
| WS-Fed - Web Services Federation | An identity specification from Web Services Security framework to provide single-sign-on via external identity exchange and authentication. |
| OIDC - OpenID Connect | OIDC extends the OAuth 2.0 authorization protocol for use as an authentication protocol, so that you can do single sign-on using OAuth. |

### OpenID Connect
OpenID Connect (OIDC) is an authentication protocol built on OAuth 2.0.  This protocol enables a user to securely sign in a user to an application. When you use the Microsoft identity platform's implementation of OpenID Connect, you can add sign-in and API access to your apps. OpenID Connect extends the OAuth 2.0 authorization protocol for use as an authentication protocol, so that you can do single sign-on using OAuth. OpenID Connect introduces the concept of an ID token, which is a security token that allows the client to verify the identity of the user. The ID token also gets basic profile information about the user. It also introduces the UserInfo endpoint, an API that returns information about the user.

### Claims-based identity in Azure AD
When a user signs in, Azure AD sends an ID token that contains a set of claims about the user. A claim is simply a piece of information, expressed as a key/value pair. For example, email=bob@contoso.com. Claims have an issuer (in this case, Azure AD), which is the entity that authenticates the user and creates the claims. You trust the claims because you trust the issuer. (Conversely, if you don't trust the issuer, don't trust the claims!)

At a high level:
1. The user authenticates.
2. The Identity Provider (IDP) sends a set of claims.
3. The app normalizes or augments the claims (optional).
4. The app uses the claims to make authorization decisions.

In OpenID Connect, the set of claims that you get is controlled by the scope parameter of the authentication request. However, Azure AD issues a limited set of claims through OpenID Connect via a security token; primarily using JSON Web Tokens. If you want more information about the user, you'll need to use the Azure AD Graph API.

### Security tokens
The Microsoft identity platform authenticates users and provides security tokens, such as access tokens, refresh tokens, and ID tokens. Security tokens allow a client application to access protected resources on a resource server. There are three common types of tokens, Access tokens, Refresh tokens, and ID tokens.
- **Access token** - An access token is a security token that's issued by an authorization server as part of an OAuth 2.0 flow. It contains information about the user and the resource for which the token is intended. The information can be used to access web APIs and other protected resources. Access tokens are validated by resources to grant access to a client app. To learn more about how the Microsoft identity platform issues access tokens, see Access tokens.
- **Refresh token** - Because access tokens are valid for only a short period of time, authorization servers will sometimes issue a refresh token at the same time the access token is issued. The client application can then exchange this refresh token for a new access token when needed. To learn more about how the Microsoft identity platform uses refresh tokens to revoke permissions, see Refresh tokens.
- **ID token** - ID tokens are sent to the client application as part of an OpenID Connect flow. They can be sent alongside or instead of an access token. ID tokens are used by the client to authenticate the user. To learn more about how the Microsoft identity platform issues ID tokens, see ID tokens.

### What is a JSON Web Token (JWT)?
JSON Web Token (JWT) is an open standard (RFC 7519) that defines a compact and self-contained way for securely transmitting information between parties as a JSON object. This information can be verified and trusted because it is digitally signed. JWTs can be signed using a secret or a public/private key pair. Although JWTs can be encrypted to also provide secrecy between parties, we will focus on signed tokens. Signed tokens can verify the integrity of the claims contained within it, while encrypted tokens hide those claims from other parties. When tokens are signed using public/private key pairs, the signature also certifies that only the party holding the private key is the one that signed it.

> [!Note]
> Information provided from the JWT web-site -  https://jwt.io/.

#### Definitions within claims-based identity
There are some common terms used when discussing claims-based identity in Azure AD.

- **Claim** - a value pair of data within a security token.  There are multiple claims transferred within the token from the claim that defines the type of the token to the encryption method.  Here is an example:
     ```
        Header
        {
          "alg": "HS256",
          "typ": "JWT"
        }
        Content payload
        {
          "sub": "1234567890",
          "name": "John Doe",
          "aud": "https://jwt.io"
        }
     ```
- **Assertion** - a package of data, usually in for form of token that share the identity and security information about a user or account across security domains.
- **Attribute** - a value pair of data within a token.
- **Augmentation** - the process of adding additional claims to the user token to provide extra detail about the user.  This could include data from human resource (HR) systems,  from an application like SharePoint, or other systems.
