Define your access policies for B2B collaboration with other Azure Active Directory tenants by configuring inbound and outbound cross-tenant access settings. Your default and organization-specific settings will determine the apps and resources users can access and whether multi-factor authentication (MFA) from other tenants is trusted.

## Example scenario

Suppose you're an IT admin in a financial institution. Employees in your organization regularly collaborate with partners on marketing and communications projects, so you want to allow B2B collaboration with external users. However, your accounting application contains highly sensitive data, so you want to strictly control access to this application.

You've recently acquired a branch whose employees will need access to your accounting application. This branch is managed in a separate Azure AD tenant. You don't want these users to have to complete multi-factor authentication (MFA) repeatedly during sign-in, so you want to streamline their experience by trusting MFA from the branch tenant. In addition to these users, there are two individual auditors from an external firm who also need access to your accounting application for an upcoming audit.

## What will we be doing?

In this module, you'll

- Set default cross-tenant access settings for B2B collaboration
- Add an organization and customize their settings
- Trust multi-factor authentication (MFA) from an external Azure AD organization

## What is the main goal?

By the end of this session, you'll be able to use the portal to configure your cross-tenant access settings for B2B collaboration with other Azure AD organizations.
