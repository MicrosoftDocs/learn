Azure Architects design Identity and access management (IAM) solutions. These solutions must work for all your users, apps, and devices. There are four basic guidelines for a strong IAM solution. 

:::image type="content" source="../media/identity-access.png" alt-text="Identity provides management and seamless experience. Access provides adaptive and simplified governance.":::


- **Unified identity management**. Manage all your identities and access to all your apps in a central location, whether they’re in the cloud or on-premises, to improve visibility and control.

- **Seamless user experience**. Provide an easy, fast sign in experience to keep your users productive, reduce time managing passwords, and increase end-user productivity.

- **Secure adaptive access**. Protect access to resources and data using strong authentication and risk-based adaptive access policies without compromising user experience.

- **Simplified identity governance**. Control access to apps and data for all users and admins. Automated identity governance to ensure only authorized users have access.

Let’s first focus on the identity solution. There are three basic choices. 

| If you need this | Use this |
| - | -|
| Provide identity and access management for employees in a cloud or hybrid environment.| [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory/) |
| Collaborate with guest users and external business partners like suppliers and vendors.| [Azure AD Business to Business (B2B)](/azure/active-directory/external-identities/compare-with-b2c) |
| Control how customers sign up, sign in, and manage their profiles when they use your applications.| [Azure AD Business to Consumer (B2C)](/azure/active-directory-b2c/overview) |