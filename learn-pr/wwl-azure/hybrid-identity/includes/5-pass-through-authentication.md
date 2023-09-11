## What is Azure Active Directory Pass-through Authentication?

**Azure Active Directory (Azure AD) Pass-through Authentication** allows your users to sign in to both on-premises and cloud-based applications using the same passwords. This feature provides users with a better experience - one less password to remember and reduces IT helpdesk costs because users are less likely to forget how to sign in. When users sign in using Azure AD, this feature validates users' passwords directly against your on-premises Active Directory.

This feature is an alternative to Azure AD Password Hash Synchronization, which provides the same benefit of cloud authentication to organizations. However, certain organizations wanting to enforce their on-premises Active Directory security and password policies can choose to use Pass-through Authentication instead. :::image type="content" source="../media/how-pass-through-authentication-works-80d183c8.png" alt-text="Diagram showing how Azure Active Directory Authentication works.":::


You can combine Pass-through Authentication with the Seamless Single Sign-on feature. This way, when your users are accessing applications on their corporate machines inside your corporate network, they don't need to type in their passwords to sign in.

## Key benefits of using Azure AD Pass-through Authentication

 -  *Great user experience*
     -  Users use the same passwords to sign into both on-premises and cloud-based applications.
     -  Users spend less time talking to the IT helpdesk to resolve password-related issues.
     -  Users can complete self-service password management tasks in the cloud.
 -  *Easy to deploy & administer*
     -  No need for complex on-premises deployments or network configuration.
     -  Needs just a lightweight agent to be installed on-premises.
     -  No management overhead. The agent automatically receives improvements and bug fixes.
 -  *Secure*
     -  On-premises passwords are never stored in the cloud in any form.
     -  Protects your user accounts by working seamlessly with Azure AD Conditional Access policies, including Multi-Factor Authentication (MFA), blocking legacy authentication, and filtering out brute force password attacks.
     -  The agent only makes outbound connections from within your network. Therefore, there is no requirement to install the agent in a perimeter network, also known as a demilitarized zone (DMZ).
     -  The communication between an agent and Azure AD is secured using certificate-based authentication. These certificates are automatically renewed every few months by Azure AD.
 -  *Highly available*
     -  Additional agents can be installed on multiple on-premises servers to provide high availability of sign-in requests.

## Feature highlights

 -  Supports user sign-in into all web browser-based applications and Microsoft Office client applications that use modern authentication.
 -  Sign-in usernames can be either the on-premises default username (userPrincipalName) or another attribute configured in Azure AD Connect (known as Alternate ID).
 -  The feature works seamlessly with Conditional Access features such as Multi-Factor Authentication (MFA) to help secure your users.
 -  Integrated with cloud-based self-service password management, including password writeback to on-premises Active Directory and password protection by banning commonly used passwords.
 -  Multi-forest environments are supported if there are forest trusts between your AD forests and if name suffix routing is correctly configured.
 -  It is a free feature, and you don't need any paid editions of Azure AD to use it.
 -  It can be enabled via Azure AD Connect.
 -  It uses a lightweight on-premises agent that listens for and responds to password validation requests.
 -  Installing multiple agents provides high availability of sign-in requests.
 -  It protects your on-premises accounts against brute-force password attacks in the cloud.

> [!IMPORTANT]
> This feature can be configured without using a federation service so that any organization, regardless of size, can implement a hybrid identity solution. Pass-through authentication is not only for user sign-in but allows an organization to use other Azure AD features, such as password management, role-based access control, published applications, and conditional access policies.
