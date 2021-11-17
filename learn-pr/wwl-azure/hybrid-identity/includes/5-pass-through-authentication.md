**Azure AD Pass-through Authentication** (PTA) is an alternative to Azure AD Password Hash Synchronization, and provides the same benefit of cloud authentication to organizations. PTA allows users to sign in to both on-premises and cloud-based applications using the same user account and passwords. When users sign-in using Azure AD, Pass-through authentication validates the users’ passwords directly against an organization's on-premise Active Directory.

:::image type="content" source="../media/az500-pass-through-authentication-36e0d821.png" alt-text="PTA diagram showing a user device with the PTA agent authenticating to AD and then to Azure AD.":::


## Feature benefits

 -  Supports user sign-in into all web browser-based applications and into Microsoft Office client applications that use modern authentication.
 -  Sign-in usernames can be either the on-premises default username (userPrincipalName) or another attribute configured in Azure AD Connect (known as Alternate ID).
 -  Works seamlessly with conditional access features such as Azure Active Directory Multi-Factor Authentication to help secure your users.
 -  Integrated with cloud-based self-service password management, including password writeback to on-premises Active Directory and password protection by banning commonly used passwords.
 -  Multi-forest environments are supported if there are forest trusts between your AD forests and if name suffix routing is correctly configured.
 -  PTA is a free feature, and you don't need any paid editions of Azure AD to use it.
 -  PTA can be enabled via Azure AD Connect.
 -  PTA uses a lightweight on-premises agent that listens for and responds to password validation requests.
 -  Installing multiple agents provides high availability of sign-in requests.
 -  PTA protects your on-premises accounts against brute force password attacks in the cloud.

> [!IMPORTANT]
> This feature can be configured without using a federation service so that any organization, regardless of size, can implement a hybrid identity solution. Pass-through authentication is not only for user sign-in but allows an organization to use other Azure AD features, such as password management, role-based access control, published applications, and conditional access policies.
