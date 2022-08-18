To implement authentication and authorization, Azure Architects design identity and access management (IAM) solutions. These solutions must work for all users, applications, and devices. There are four basic guidelines for a strong IAM solution:

:::image type="content" source="../media/identity-access.png" alt-text="Diagram of the four basic guidelines for a strong IAM solution." border="false":::

- **Unified identity management**. Manage all your identities and access to all your applications in a central location, whether they’re in the cloud or on-premises, to improve visibility and control.

- **Seamless user experience**. Provide an easy, fast sign-in experience to keep your users productive, reduce time spent managing passwords, and increase end-user productivity.

- **Secure adaptive access**. Protect access to resources and data by using strong authentication and risk-based adaptive access policies without compromising the user experience.

- **Simplified identity governance**. Control access to applications and data for all users and admins. Automated identity governance ensures only authorized users have access.

As a first step, let's focus on designing an identity solution for Tailwind Traders. The following table lists three basic choices.

| Technology | Example scenario |
| --- | ---|
| [Azure AD](https://azure.microsoft.com/services/active-directory/) | Provide an identity and access management system for your employees in a cloud or hybrid environment. |
| [Azure AD B2B (business-to-business)](/azure/active-directory/external-identities/compare-with-b2c) | Support collaboration for guest users and external business partners, such as suppliers and vendors. |
| [Azure AD B2C (business-to-customer)](/azure/active-directory-b2c/overview) | Control how your customers sign up, sign in, and manage their profiles when they use your applications. |