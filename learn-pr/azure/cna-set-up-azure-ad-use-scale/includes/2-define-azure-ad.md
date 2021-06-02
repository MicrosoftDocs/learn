The Adatum management team wants to ensure that the company's customers have a reliable way to securely access the services provided by your applications. You intend to implement this functionality by relying on Azure AD authentication and authorization capabilities. To accomplish this, you decided to explore its core features and benefits, focusing on those applicable to cloud-native applications.

> [!NOTE]
> Authentication determines the identity of a security principal, such as a user or a device. Authorization involves granting an authenticated security principal permission to perform an action or access a resource. 

## What is Azure AD and what are its benefits?

Azure AD is Microsoft's cloud-based identity and access management service. It provides authentication capabilities and facilitates authorization through its integration with practically all Microsoft's cloud services and a wide range of third-party SaaS offerings. It supports modern, industry-standard authentication and authorization protocols.

> [!NOTE]
> Through its integration with Active Directory, Azure AD also helps protect internal resources, such as apps on your corporate network and intranet, along with any cloud apps developed by your organization. 

Azure AD serves as an identity store, providing you with the ability to create accounts for your organization's users, groups, and devices. It also allows for creating guest accounts, representing identities of your partner organizations, making it straightforward to share resources in a secure manner in business-to-business (B2B) scenarios. You can also leverage Azure AD in business-to-consumer (B2C) scenarios by allowing external users to sign up for access to your apps with their existing credentials, including support for the most common social identity providers.

For each of these scenarios, you have the option to implement additional controls that dictate the level of protection against potential threats. These controls include built-in support for multi-factor authentication and conditional access. 

> [!NOTE]
> Azure AD organizes its objects, such as users, groups, and apps into containers called tenants. Each tenant represents an administrative and security boundary. You have the option of creating one or more tenants for your organization. Every Azure subscription is associated with an Azure AD tenant. 

## What is the role of Azure AD in cloud-native applications?

As an app developer, you can use Azure AD for authenticating and authorizing access for your applications and their data. Azure AD offers programmatic methods that facilitate building custom apps. It also serves as a single location to store digital identitities-related information, including support for application registration and their respective security principals. This allows for not only providing granular access to your internally developed applications to each user, guest, or group, but also makes it possible for applications to operate independently or on-behalf of their users when accessing other Azure AD-protected resources, services, and applications.

Cloud-native applications rely on open HTTP-based protocols to authenticate security principals since both clients and applications could be running anywhere and on any platform or device. Azure AD, as a cloud-native identity solution, provides this functionality, including its REST-based interface, as well as support for Graph API and OData-based queries.

Azure AD facilitates implementing a range of scenarios commonly encountered when building cloud-native applications, such as:

- Users accessing web applications via a web a browser.
- Users accessing back-end Web APIs from browser-based apps.
- Users accessing back-end Web APIs from mobile apps.
- Applications accessing back-end Web APIs without an active user or user interface, using their own identity.
- Applications interacting with other Web APIs, acting on a user's behalf with that user's delegated credentials. 

In each of these scenarios, applications need to be secured against unauthorized use. At a minimum, this requires authenticating the security principal requesting access to a resource. This authentication may use one of several common protocols such as SAML2, WS-Fed, or OpenID Connect. Communicating with Web APIs typically relies on the OAuth2 protocol and its support for access tokens.
