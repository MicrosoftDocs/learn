To implement authentication and authorization, Azure Architects design identity and access management (IAM) solutions. These solutions must work for all users, applications, and devices. A strong IAM solution should have unified identity management, secure adaptive access, simplified identity governance, and a seamless user experience.

:::image type="content" source="../media/identity-access.png" alt-text="Diagram of the four basic guidelines for a strong IAM solution." border="false":::

### Things to know about IAM

As you look at your authentication and authorization options for Tailwind Traders, consider these characteristics of a strong IAM solution:

- **Unified identity management**. Manage all your identities and access to all your applications in a central location, whether they’re in the cloud or on-premises, to improve visibility and control.

- **Seamless user experience**. Provide an easy, fast sign-in experience to keep your users productive, reduce time spent managing passwords, and increase end-user productivity.

- **Secure adaptive access**. Protect access to resources and data by using strong authentication and risk-based adaptive access policies without compromising the user experience.

- **Simplified identity governance**. Control access to applications and data for all users and admins. Automated identity governance ensures only authorized users have access.

### Things to consider when using IAM

Your first step is to determine the ideal IAM solution for Tailwind Traders. The following table lists three basic choices. We'll look closely at these options in the next units.

- **Consider using Microsoft Entra ID**. Develop with [Microsoft Entra ID](https://azure.microsoft.com/services/active-directory/) for a solution that combines core directory services, application access management, and identity protection. Microsoft Entra ID provides an identity and access management system for Tailwind Traders employees that can operate in a cloud or hybrid environment.

- **Consider your business-to-business (B2B) requirements**. Support collaboration for guest users and external business partners of Tailwind Traders, such as suppliers and vendors. Build your solution with [Microsoft Entra B2B (business-to-business)](/azure/active-directory/external-identities/compare-with-b2c) to support business-to-business operations.

- **Consider your business-to-customer scenarios**. Control how Tailwind Traders customers sign up, sign in, and manage their profiles when they use your apps. Use [Azure AD B2C (business-to-customer)](/azure/active-directory-b2c/overview) to develop a Microsoft Entra solution that supports customer-focused operations.
