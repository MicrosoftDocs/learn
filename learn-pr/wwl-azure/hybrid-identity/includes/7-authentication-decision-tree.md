Choosing the correct authentication method is the first concern for organizations wanting to move their apps to the cloud. Don't take this decision lightly, for the following reasons:

 -  It's the first decision for an organization that wants to move to the cloud.
 -  The authentication method is a critical component of an organization’s presence in the cloud. It controls access to all cloud data and resources.
 -  It's the foundation of all the other advanced security and user experience features in Azure AD.

Identity is the new control plane of IT security, so authentication is an organization’s access guard to the new cloud world. Organizations need an identity control plane that strengthens their security and keeps their cloud apps safe from intruders.

### Authentication methods

**Cloud Authentication** \- When you choose this authentication method, Azure AD handles users' sign-in process. Coupled with seamless single sign-on (SSO), users can sign in to cloud apps without having to reenter their credentials. With cloud authentication, you can choose from two options:

 -  Azure AD password hash Synchronization
 -  Azure AD Pass-through Authentication

**Federated Authentication** \- When you choose this authentication method, Azure AD hands off the authentication process to a separate trusted authentication system, such as on-premises Active Directory Federation Services (AD FS), to validate the user’s password. The authentication system can provide additional advanced authentication requirements. Examples are smartcard-based authentication or third-party multifactor authentication.

### Decision tree

:::image type="content" source="../media/az500-authentication-decision-tree-710a71fc.png" alt-text="Authentication decision tree described in the text.":::


Details on decision questions:

1. Azure AD can handle sign-in for users without relying on on-premises components to verify passwords.
1. Azure AD can hand off user sign-in to a trusted authentication provider such as Microsoft’s AD FS.
1. If you need to apply user-level Active Directory security policies such as account expired, disabled account, password expired, account locked out, and sign-in hours on each user sign-in, Azure AD requires some on-premises components.
1. Sign-in features not natively supported by Azure AD:
     -  Sign-in using on-premises MFA Server.
     -  Sign-in using third-party authentication solution.
     -  Multi-site on-premises authentication solution.
1. Azure AD Identity Protection requires Password Hash Sync, regardless of which sign-in method you choose, to provide the *Users with leaked credentials* report. Organizations can fail over to Password Hash Sync if their primary sign-in method fails and it was configured before the failure event.

> [!IMPORTANT]
> This decision tree is intended as a starting point to understand your options, but there can be others or even combinations of different options. For example, you can use Azure AD B2C and configure it to allow user sign-in for multi-tenant Azure AD tenants - with or without the traditional support for self-service sign-up and social identity providers.
