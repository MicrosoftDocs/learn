The Adatum management team wants to ensure that the company's customers have a reliable way to securely access the services provided by your applications. You intend to implement this functionality by relying on the authentication and authorization capabilities of Azure AD. To accomplish this objective, you decide to explore the core features and benefits of Azure AD, while focusing on the features that are applicable to cloud-native applications.

*Authentication* determines the identity of a security principal, such as a user or a device. *Authorization* involves granting an authenticated security principal permission to perform an action or access a resource.

## What is Azure AD and what are its benefits?

Azure AD is the cloud-based identity and access management service for Microsoft. It provides authentication capabilities and facilitates authorization through its integration with most Microsoft cloud services and a wide range of third-party software as a service (SaaS) offerings. It supports modern, industry-standard authentication and authorization protocols.

> [!NOTE]
> Through its integration with Windows Server Active Directory, Azure AD also helps protect internal resources, such as apps on your corporate network and intranet, along with any cloud apps your organization develops.

Azure AD serves as an identity store, providing you with the ability to create accounts for your organization's users, groups, and devices. It also allows for creating guest accounts, which can represent the identities of your partner organizations, making it straightforward to share resources in a secure manner in business-to-business (B2B) scenarios. You can also use Azure AD in business-to-consumer (B2C) scenarios by allowing external users to sign up for access to your apps with their existing credentials, and it supports the most common social identity providers.

For each of these scenarios, you can implement other controls that dictate the level of protection against potential threats. These controls include built-in support for multifactor authentication and Conditional Access.

Azure AD organizes its objects, such as users, groups, and apps into containers called tenants. Each tenant represents an administrative and security boundary. You can create one or more tenants for your organization. Every Azure subscription is associated with an Azure AD tenant.

## What is the role of Azure AD in cloud-native applications?

As an app developer, you can use Azure AD for authenticating and authorizing access for your applications and their data. Azure AD offers programmatic methods that help build custom apps. It also serves as a single location to store digital identity-related information, including support for application registration and their respective security principals. This capability makes it possible to provide granular access to your internally developed applications to each user, guest, or group. It also enables applications to operate independently, or on behalf of their users, when accessing other Azure AD-protected resources, services, and applications.

Cloud-native applications rely on open HTTP-based protocols to authenticate security principals, because both clients and applications could be running anywhere and on any platform or device. Azure AD, as a cloud-native identity solution, provides this functionality, including its REST-based interface, and support for Graph API and OData-based queries.

Azure AD facilitates implementing a range of scenarios commonly encountered when building cloud-native applications, such as:

- Users accessing web applications on a web browser.
- Users accessing backend web APIs from browser-based apps.
- Users accessing backend web APIs from mobile apps.
- Applications accessing backend web APIs without an active user or user interface, using their own identity.
- Applications interacting with other web APIs, acting on a user's behalf with that user's delegated credentials.

In each of these scenarios, applications need to be secured against unauthorized use. At a minimum, this step requires authenticating the security principal requesting access to a resource. This authentication might use one of several common protocols such as Security Assertion Markup Language (SAML) V2.0, WS-Fed, or OpenID Connect. Communicating with web APIs typically relies on the OAuth2 protocol and its support for access tokens.
