An identity provider (IdP) is a system that creates, manages and stores digital identities.  Microsoft Entra ID is an example. The capabilities and features of identity providers can vary. The three most common components are:

- a repository of user identities
- an authentication system
- security protocols that defend against intrusion

An identity provider verifies user identities using one or more authentication factors, such as a password or fingerprint scan.  An identity provider is often a trusted provider for use with single sign-on (SSO) to access other resources. SSO enhances usability by reducing password fatigue. It also provides better security by decreasing the potential attack surface. Identity providers can facilitate connections between cloud computing resources and users, thus decreasing the need for users to reauthenticate when using mobile and roaming applications.

### Common identity protocols

**OpenID provider** - OpenID Connect (OIDC) is an authentication protocol based on the OAuth2 protocol (which is used for authorization). OIDC uses the standardized message flows from OAuth2 to provide identity services. Specifically, a system entity (called an OpenID-Provider) issues JSON-formatted identity tokens to OIDC relying parties via a RESTful HTTP API.

**SAML identity provider** - Security Assertion Markup Language (SAML) is an open standard for exchanging authentication and authorization data between an identity provider and a service provider. SAML is an XML-based markup language for security assertions, which are statements that service providers use to make access-control decisions.

## Compare identity providers in Microsoft Azure

Microsoft provides several different tools for identity based on your business needs and goals.  Microsoft Entra ID should be your go to starting point for cloud based identity.  Other services can provide supporting capabilities as you transition from on-premises to the cloud.

| Microsoft Entra Domain Services | Microsoft Entra ID | Active Directory Domain Services |
| :----- | :----- | :----- |
| Provides managed domain services with a subset of fully compatible traditional AD DS features such as domain join, group policy, LDAP, and Kerberos / NTLM authentication. | Cloud-based identity and mobile device management that provides user account and authentication services for resources such as Microsoft 365, the Azure portal, or SaaS applications. | Enterprise-ready lightweight directory access protocol (LDAP) server that provides key features such as identity and authentication, computer object management, group policy, and trusts. |


## Active Directory Domain Services (AD DS)
Enterprise-ready lightweight directory access protocol (LDAP) server that provides key features such as identity and authentication, computer object management, group policy, and trusts.
- AD DS is a central component in many organizations with an on-premises IT environment, and provides core user account authentication and computer management features.

## Microsoft Entra ID
Cloud-based identity and mobile device management that provides user account and authentication services for resources such as Microsoft 365, the Azure portal, or SaaS applications.
- Microsoft Entra ID can be synchronized with an on-premises AD DS environment to provide a single identity to users that works natively in the cloud.

## Microsoft Entra Domain Services
Provides managed domain services with a subset of fully compatible traditional AD DS features such as domain join, group policy, LDAP, and Kerberos / NTLM authentication.
- Microsoft Entra DS integrates with Microsoft Entra ID, which itself can synchronize with an on-premises AD DS environment. This ability extends central identity use cases to traditional web applications that run in Azure as part of a lift-and-shift strategy.
