Organizations often need to collaborate on projects with people outside of their company, but they want to make sure that only authorized people can access the resources they want to share. They need a way to allow or block B2B collaboration with other Azure Active Directory (Azure AD) tenants through both inbound and outbound controls. With cross-tenant access settings, organizations can allow or block B2B collaboration with other Azure AD organizations by default or with specific organizations.

## Example scenario

Suppose you're an IT admin in a financial institution. Employees in your organization regularly collaborate with partners on marketing and communications projects, so you want to allow B2B collaboration with external users. However, your internal accounting applications contain highly sensitive data, so you want to strictly control access to your internal applications.

You've recently acquired a branch whose employees will need access to your accounting applications. This branch is managed in a separate Azure AD tenant. You don't want these users to have to complete multifactor authentication repeatedly during sign-in, so you want to streamline their experience by trusting multifactor authentication from the branch tenant.

## What will we be doing?

In this module, you'll

- Set default cross-tenant access settings for B2B collaboration
- Add an organization and customize their settings
- Trust multifactor authentication from an external Azure AD organization

## What is the main goal?

By the end of this session, you'll be able to use the portal to configure your cross-tenant access settings for B2B collaboration with other Azure AD organizations.