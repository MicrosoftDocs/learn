
We have talked about Zero Trust and about identity as the control plane for accessing resources.  By why use identity?

### Identity gives the ability:

- To prove who or what we are - **Authentication**
- To get permissions to do something - **Authorization**
- To report on what was done - **Auditing**
- To IT manage and self administer an identity - **Administration**

| Authentication | Authorization | Administration | Auditing |
| :------------- | :------------ | :------------- | :------- |
| :::image type="icon" source="../media/icon-authentication.png" alt-text="Diagram of a thumbprint to represent the authentication of an identity."::: | :::image type="icon" source="../media/icon-authorization.png" alt-text="Diagram of a hand giving items to represent the authorization to access resources."::: | :::image type="icon" source="../media/icon-administration.png" alt-text="Diagram of a hand with a wrench to represent modifying and maintaining access and resources."::: | :::image type="icon" source="../media/icon-audit.png" alt-text="Diagram of checklist with a few items marked to represent the process of checking the usage of resources by an identity"::: |
| User sign on experience | User sign on experience | Single view management | Track who does what, when, where and how |
| Trusted source(s) | Can a user access the resource | Application of business rules | Focused alerting |
| Federative protocols | What can they do when they access it? | Automated requests, approvals, and access assignment | In-depth collated reporting |
| Level of assurance |  | Entitlement management | Governance & compliance |

### What is an identity provider (IdP)

An identity provider (IdP) is a system that creates, manages and stores digital identities.  Microsoft Azure Active Directory is an example. The capabilities and features of identity providers can vary. The most common components are:

- A repository of user identities
- An authentication system
- Security protocols that defend against intrusion
- Someone we trust

An identity provider verifies user identities using one or more authentication factors, such as a password or fingerprint scan.  An identity provider is often a trusted provider for use with single-sign-on (SSO) to access other resources. SSO enhances usability by reducing password fatigue. It also provides better security by decreasing the potential attack surface. Identity providers can facilitate connections between cloud computing resources and users, thus decreasing the need for users to reauthenticate when using mobile and roaming applications.

### Common identity protocols

**OpenID provider** - OpenID Connect (OIDC) is an authentication protocol based on the OAuth2 protocol (which is used for authorization). OIDC uses the standardized message flows from OAuth2 to provide identity services. Specifically, a system entity (called an OpenID-Provider) issues JSON-formatted identity tokens to OIDC relying parties via a RESTful HTTP API.

**SAML identity provider** - Security Assertion Markup Language (SAML) is an open standard for exchanging authentication and authorization data between an identity provider and a service provider. SAML is an XML-based markup language for security assertions, which are statements that service providers use to make access-control decisions.


