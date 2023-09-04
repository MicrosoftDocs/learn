Choosing the correct authentication method is the first concern for organizations wanting to move their apps to the cloud. Don't take this decision lightly for the following reasons:

 -  It's the first decision for an organization that wants to move to the cloud.
 -  The authentication method is a critical component of an organization’s presence in the cloud. It controls access to all cloud data and resources.
 -  It's the foundation of all the other advanced security and user experience features in Azure AD.

Identity is the new control plane of IT security, so authentication is an organization’s access guard to the new cloud world. Organizations need an identity control plane that strengthens their security and keeps their cloud apps safe from intruders.

### Out of scope

Organizations that don't have an existing on-premises directory footprint aren't the focus of this article. Typically, those businesses create identities only in the cloud, which doesn’t require a hybrid identity solution. Cloud-only identities exist solely in the cloud and aren't associated with corresponding on-premises identities.

## Authentication methods

When the Azure AD hybrid identity solution is your new control plane, authentication is the foundation of cloud access. Choosing the correct authentication method is a crucial first decision in setting up an Azure AD hybrid identity solution. Implement the authentication method that is configured by using Azure AD Connect, which also provisions users in the cloud.

To choose an authentication method, you need to consider the time, existing infrastructure, complexity, and cost of implementing your choice. These factors are different for every organization and might change over time.

Azure AD supports the following authentication methods for hybrid identity solutions.

### Cloud authentication

When you choose this authentication method, Azure AD handles users' sign-in process. Coupled with seamless single sign-on (SSO), users can sign in to cloud apps without having to reenter their credentials. With cloud authentication, you can choose from two options:

**Azure AD password hash synchronization**. The simplest way to enable authentication for on-premises directory objects in Azure AD. Users can use the same username and password that they use on-premises without having to deploy any additional infrastructure. Some premium features of Azure AD, like Identity Protection and Azure AD Domain Services, require password hash synchronization, no matter which authentication method you choose.

> [!NOTE]
> Passwords are never stored in clear text or encrypted with a reversible algorithm in Azure AD.

Companies with a security requirement to immediately enforce on-premises user account states, password policies, and sign-in hours might use this authentication method.

### Federated authentication

When you choose this authentication method, Azure AD hands off the authentication process to a separate trusted authentication system, such as on-premises Active Directory Federation Services (AD FS), to validate the user’s password.

The authentication system can provide additional advanced authentication requirements. Examples are smartcard-based authentication or third-party multifactor authentication.

The following section helps you decide which authentication method is right for you by using a decision tree. It helps you determine whether to deploy cloud or federated authentication for your Azure AD hybrid identity solution.

:::image type="content" source="../media/authentication-method-decision-tree-6e1516b0.png" alt-text="Diagram showing how to decide on an authentication method using the Decision tree.":::


Details on decision questions:

1.  Azure AD can handle sign-in for users without relying on on-premises components to verify passwords.
2.  Azure AD can hand off user sign-in to a trusted authentication provider such as Microsoft’s AD FS.
3.  If you need to apply, user-level Active Directory security policies such as account expired, disabled account, password expired, account locked out, and sign-in hours on each user sign-in, Azure AD requires some on-premises components.
4.  Sign-in features not natively supported by Azure AD:
     -  Sign-in using on-premises MFA Server.
     -  Sign-in using third-party authentication solution.
     -  Multi-site on-premises authentication solution.
5.  Azure AD Identity Protection requires Password Hash Sync regardless of which sign-in method you choose, to provide the *Users with leaked credentials* report. Organizations can fail over to Password Hash Sync if their primary sign-in method fails and it was configured before the failure event.

> [!NOTE]
> Azure AD Identity Protection requires Azure AD Premium P2 licenses.

## Detailed considerations<br>

### Cloud authentication: Password hash synchronization

 -  Effort. Password hash synchronization requires the least effort regarding deployment, maintenance, and infrastructure. This level of effort typically applies to organizations that only need their users to sign in to Microsoft 365, SaaS apps, and other Azure AD-based resources. When turned on, password hash synchronization is part of the Azure AD Connect sync process and runs every two minutes.
 -  User experience. To improve users' sign-in experience, deploy seamless SSO with password hash synchronization. Seamless SSO eliminates unnecessary prompts when users are signed in.
 -  Advanced scenarios. If organizations choose to, it's possible to use insights from identities with Azure AD Identity Protection reports with Azure AD Premium P2. An example is the leaked credentials report. Windows Hello for Business has specific requirements when you use password hash synchronization. Azure AD Domain Services requires password hash synchronization to provision users with their corporate credentials in the managed domain.
    
    Organizations that require multi-factor authentication with password hash synchronization must use Azure AD Multi-Factor Authentication or Conditional Access custom controls. Those organizations can't use third-party or on-premises multifactor authentication methods that rely on federation.

 -  Business continuity. Using password hash synchronization with cloud authentication is highly available as a cloud service that scales to all Microsoft data centers. To make sure password hash synchronization does not go down for extended periods, deploy a second Azure AD Connect server in staging mode in a standby configuration.
 -  Considerations. Currently, password hash synchronization doesn't immediately enforce changes in on-premises account states. In this situation, a user has access to cloud apps until the user account state is synchronized to Azure AD. Organizations might want to overcome this limitation by running a new synchronization cycle after administrators do bulk updates to on-premises user account states. An example is disabling accounts.

> [!NOTE]
> The password expired and account locked-out states aren't currently synced to Azure AD with Azure AD Connect. When you change a user's password and set the *user must change password at next logon* flag, the password hash will not be synced to Azure AD with Azure AD Connect until the user changes their password.

### Cloud authentication: Pass-through Authentication

 -  **Effort**. For pass-through authentication, you need one or more (we recommend three) lightweight agents installed on existing servers. These agents must have access to your on-premises Active Directory Domain Services, including your on-premises AD domain controllers. They need outbound access to the Internet and access to your domain controllers. For this reason, it's not supported to deploy the agents in a perimeter network.
    
    Pass-through Authentication requires unconstrained network access to domain controllers. All network traffic is encrypted and limited to authentication requests.
 -  **User experience**. To improve users' sign-in experience, deploy seamless SSO with Pass-through Authentication. Seamless SSO eliminates unnecessary prompts after users sign in.
 -  **Advanced scenarios**. Pass-through Authentication enforces the on-premises account policy at the time of sign-in. For example, access is denied when an on-premises user’s account state is disabled, locked out, or their password expires or the logon attempt falls outside the hours when the user is allowed to sign in.
    
    Organizations that require multi-factor authentication with pass-through authentication must use Azure AD Multi-Factor Authentication (MFA) or Conditional Access custom controls. Those organizations can't use a third-party or on-premises multifactor authentication method that relies on federation. Advanced features require that password hash synchronization is deployed whether or not you choose pass-through authentication. An example is the leaked credentials report of Identity Protection.
 -  **Business continuity**. We recommend that you deploy two extra pass-through authentication agents. These extras are in addition to the first agent on the Azure AD Connect server. This additional deployment ensures high availability of authentication requests. When you have three agents deployed, one agent can still fail when another agent is down for maintenance.
    
    There's another benefit to deploying password hash synchronization in addition to pass-through authentication. It acts as a backup authentication method when the primary authentication method is no longer available.
 -  **Considerations**. You can use password hash synchronization as a backup authentication method for pass-through authentication, when the agents can't validate a user's credentials due to a significant on-premises failure. Fail over to password hash synchronization doesn't happen automatically and you must use Azure AD Connect to switch the sign-on method manually.

### Federated authentication

 -  **Effort**. A federated authentication system relies on an external trusted system to authenticate users. Some companies want to reuse their existing federated system investment with their Azure AD hybrid identity solution. The maintenance and management of the federated system falls outside the control of Azure AD. It's up to the organization by using the federated system to make sure it's deployed securely and can handle the authentication load.
 -  **User experience**. The user experience of federated authentication depends on the implementation of the features, topology, and configuration of the federation farm. Some organizations need this flexibility to adapt and configure the access to the federation farm to suit their security requirements. For example, it's possible to configure internally connected users and devices to sign in users automatically without prompting them for credentials. This configuration works because they already signed in to their devices. If necessary, some advanced security features make users' sign-in process more difficult.
 -  **Advanced scenarios**. A federated authentication solution is required when customers have an authentication requirement that Azure AD doesn't support natively.
    
    Consider the following common requirements:
    
    
     -  Authentication that requires smartcards or certificates.
     -  On-premises MFA servers or third-party multifactor providers requiring a federated identity provider.
     -  Authentication by using third-party authentication solutions.
     -  Sign-in that requires a sAMAccountName, for example, DOMAIN\\username, instead of a User Principal Name (UPN), for example, user@domain.com.
 -  **Business continuity**. Federated systems typically require a load-balanced array of servers, known as a farm. This farm is configured in an internal network and perimeter network topology to ensure high availability for authentication requests.
    
    Deploy password hash synchronization along with federated authentication as a backup authentication method when the primary authentication method is no longer available. An example is when the on-premises servers aren't available. Some large enterprise organizations require a federation solution to support multiple Internet ingress points configured with geo-DNS for low-latency authentication requests.
 -  **Considerations**. Federated systems typically require a more significant investment in on-premises infrastructure. Most organizations choose this option if they already have an on-premises federation investment. And if it's a strong business requirement to use a single identity provider. Federation is more complex to operate and troubleshoot compared to cloud authentication solutions.

For a non-routable domain that can't be verified in Azure AD, you need extra configuration to implement user ID sign-in. This requirement is known as Alternate login ID support. If you choose to use a third-party multi-factor authentication provider with federation, ensure the provider supports WS-Trust to allow devices to join Azure AD.

> [!NOTE]
> When you deploy your Azure AD hybrid identity solution, you must implement one of the supported topologies of Azure AD Connect. Learn more about supported and unsupported configurations at Topologies for Azure AD Connect.

## Summary

 -  This lesson outlines various authentication options that organizations can configure and deploy to support access to cloud apps.
 -  To meet various business, security, and technical requirements, organizations can choose between password hash synchronization, Pass-through Authentication, and federation.
 -  Consider each authentication method. Does the effort to deploy the solution, and the user's experience of the sign-in process address your business requirements?
 -  Evaluate whether your organization needs the advanced scenarios and business continuity features of each authentication method.
 -  Finally, evaluate the considerations of each authentication method. Do any of them prevent you from implementing your choice?
