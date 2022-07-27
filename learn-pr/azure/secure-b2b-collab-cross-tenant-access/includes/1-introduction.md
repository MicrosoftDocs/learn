Define your inbound and outbound B2B collaboration with other Azure Active Directory (Azure AD) tenants by using cross-tenant access settings. You can decide whether to allow or block B2B collaboration with other Azure AD organizations by default, and then set individual policies for specific organizations. You can trust multi-factor authentication from a user’s home tenant so they don’t have to repeat the process in your tenant. If you have an Azure Premium license, you also have granular control over who can use B2B collaboration and which applications can be accessed.
## Example scenario

Suppose you're an IT admin in a financial institution. Employees in your organization regularly collaborate with partners on marketing and communications projects, so you want to allow B2B collaboration with external users. However, your internal accounting applications contain highly sensitive data, so you want to strictly control access to your internal applications.

You've recently acquired a branch whose employees will need access to your accounting application. This branch is managed in a separate Azure AD tenant. You don't want these users to have to complete multi-factor authentication (MFA) repeatedly during sign-in, so you want to streamline their experience by trusting MFA from the branch tenant.

## What will we be doing?

In this module, you'll

- Set default cross-tenant access settings for B2B collaboration
- Add an organization and customize their settings
- Trust multi-factor authentication (MFA) from an external Azure AD organization

## What is the main goal?

By the end of this session, you'll be able to use the portal to configure your cross-tenant access settings for B2B collaboration with other Azure AD organizations.
