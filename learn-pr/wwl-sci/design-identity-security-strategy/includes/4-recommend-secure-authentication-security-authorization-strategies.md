Choosing the correct authentication method is the first concern for organizations wanting to move their apps to the cloud. Don't take this decision lightly for the following reasons:

* It's the first decision for an organization that wants to move to the cloud.
* The authentication method is a critical component of an organization's presence in the cloud. It controls access to all cloud data and resources.
* It's the foundation of all the other advanced security and user experience features in Azure AD.

Identity is the new control plane of IT security, so authentication is
an organization's access to the new cloud world. Organizations need an
identity control plane that strengthens their security and keeps their
cloud apps safe from intruders.

## Secure Authentication methods

When the Azure AD hybrid identity solution is your new control plane,
authentication is the foundation of cloud access. Choosing the correct
authentication method is a crucial first decision in setting up an Azure
AD hybrid identity solution. Implement the authentication method
configured by using Azure AD Connect, which also provisions users in the
cloud.

To choose an authentication method, consider the time, existing
infrastructure, complexity, and cost of implementing your choice. These
factors are different for every organization and might change over time.

Azure AD supports the following authentication methods for hybrid
identity solutions.

## Cloud authentication

When choosing this authentication method, Azure AD handles users'
sign-in process. Cloud authentication includes single sign-on (SSO), so that users can
sign into cloud apps without re-entering their credentials. With cloud
authentication, there are two options:

### Azure AD password hash synchronization

The simplest way to enable authentication for on-premises directory objects in Azure AD. Users can
use the same username and password that they use on-premises without deploying any additional infrastructure. Some premium features of Azure AD, like Identity Protection and [Azure AD Domain Services](/azure/active-directory-domain-services/tutorial-create-instance), require password hash synchronization, no matter which authentication
method is chosen.

### Azure AD Pass-through Authentication

Azure AD Pass-through Authentication provides a simple password validation for Azure AD authentication services by using a software
agent that runs on one or more on-premises servers. The servers validate
the users directly with your on-premises Active Directory, ensuring that
the password validation doesn't happen in the cloud.

Companies with a security requirement to immediately enforce on-premises
user account states, password policies, and sign-in hours might use this
authentication method. For more information on the actual pass-through
authentication process, see [User sign-in with Azure AD pass-through
authentication](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-pta).

## Federated authentication

Azure AD hands off the authentication process to a separate trusted
authentication system when you choose this authentication method. An
example is on-premises Active Directory Federation Services (AD FS) to
validate the user's password.

The authentication system can provide additional advanced authentication
requirements. Examples are smartcard-based authentication or third-party
multifactor authentication. For more information, see [Deploying Active Directory Federation Services](/windows-server/identity/ad-fs/deployment/windows-server-2012-r2-ad-fs-deployment-guide).

The following section helps determine which authentication method is
right using a decision tree. It helps determine whether to deploy a
cloud or federated authentication for an Azure AD hybrid identity
solution.

## Architecture diagrams

The following diagrams outline the high-level architecture components
required for each authentication method that can be used with an Azure
AD hybrid identity solution.

The simplicity of a password hash synchronization solution:

:::image type="content" source="../media/architecture-diagram.png" alt-text="Diagram showing Azure A D hybrid identity with Password hash synchronization." lightbox="../media/architecture-diagram.png":::

Agent requirements of pass-through authentication, using two agents for redundancy:

:::image type="content" source="../media/architecture-diagram-2.png" alt-text="Diagram showing Azure A D hybrid identity with Pass-through Authentication." lightbox="../media/architecture-diagram-2.png":::

Components required for federation in your perimeter and internal
network of your organization:

:::image type="content" source="../media/architecture-diagram-3.png" alt-text="Diagram showing Azure A D hybrid identity with federated authentication." lightbox="../media/architecture-diagram-3.png":::

## Comparing Authentication Methods

The following table offers a detailed comparison of the various authentication methods available and their respective features.

| Consideration | Password hash synchronization + Seamless SSO | Pass-through Authentication + Seamless SSO | Federation with AD FS |
|---|---|---|---|
| Where does authentication happen? | In the cloud | In the cloud, after a secure password verification exchange with the on-premises authentication agent | On-premises |
| What are the on-premises server requirements beyond the provisioning system: Azure AD Connect? | None | One server for each additional authentication agent | Two or more AD FS servers |
|  |  |  | Two or more WAP servers in the perimeter/DMZ network |
| What are the requirements for on-premises Internet and networking beyond the provisioning system? | None | Outbound Internet access from the servers running authentication agents | Inbound Internet access to WAP servers in the perimeter |
|  |  |  | Inbound network access to AD FS servers from WAP servers in the perimeter |
|  |  |  | Network load balancing |
| Is there a TLS/SSL certificate requirement? | No | No | Yes |
| Is there a health monitoring solution? | Not required | Agent status provided by Azure Active Directory admin center | Azure AD Connect Health |
| Do users get single sign-on to cloud resources from domain-joined devices within the company network? | Yes with Seamless SSO | Yes with Seamless SSO | Yes |
| What sign-in types are supported? | UserPrincipalName + password | UserPrincipalName + password | UserPrincipalName + password |
|  | Windows-Integrated Authentication by using Seamless SSO | Windows-Integrated Authentication by using Seamless SSO | sAMAccountName + password |
|  | Alternate login ID | Alternate login ID | Windows-Integrated Authentication |
|  |  |  | Certificate and smart card authentication |
|  |  |  | Alternate login ID |
| Is Windows Hello for Business supported? | Key trust model | Key trust model | Key trust model |
|  |  | Requires Windows Server 2016 Domain functional level |  |
|  |  |  | Certificate trust model |
| What are the multifactor authentication options? | Azure AD Multi-Factor Authentication | Azure AD Multi-Factor Authentication | Azure AD Multi-Factor Authentication |
|  | Custom Controls with Conditional Access* | Custom Controls with Conditional Access* | Azure AD Multi-Factor Authentication server |
|  |  |  | Third-party MFA |
|  |  |  | Custom Controls with Conditional Access* |
| What user account states are supported? | Disabled accounts | Disabled accounts | Disabled accounts |
|  |  | Account locked out | Account locked out |
|  |  | Account expired | Account expired |
|  |  | Password expired | Password expired |
|  |  | Sign-in hours | Sign-in hours |
| What are the Conditional Access options? | Azure AD Conditional Access, with Azure AD Premium | Azure AD Conditional Access, with Azure AD Premium | Azure AD Conditional Access, with Azure AD Premium |
|  |  |  | AD FS claim rules |
| Is blocking legacy protocols supported? | Yes | Yes | Yes |
| Can logo, image, and description be customized on the sign-in pages? | Yes, with Azure AD Premium | Yes, with Azure AD Premium | Yes |
| What advanced scenarios are supported? | Smart password lockout | Smart password lockout | Multisite low-latency authentication system |
|  | Leaked credentials reports, with Azure AD Premium P2 |  | AD FS extranet lockout |
|  |  |  | Integration with third-party identity systems |

## Secure Authorization Methods

Authorization verifies that the identity attempting to connect has the
necessary permissions to access a service, feature, function, object, or
method. Authorization always occurs after successful authentication. If
a connection isn't authenticated, it fails before any authorization
checking is performed. If authentication of a connection succeeds, a
specific action might still be disallowed because the user or group did
not have the authorization to perform that action.

Administrators benefit from understanding the following authorization
methods to enforce Zero Trust. To learn more about these authorization
methods, see [Get started with permissions, access, and security groups](/azure/devops/organizations/security/about-permissions?view=azure-devops&preserve-view=true).

## Authorization Methods

-   Security group membership
-   Role-based access control
-   Access levels
-   Feature flags
-   Security namespaces & permissions