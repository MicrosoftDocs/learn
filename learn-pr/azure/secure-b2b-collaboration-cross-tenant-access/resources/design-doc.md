# Title

Secure B2B collaboration by using cross-tenant access settings

## Role(s)

Administrator

## Level

Beginner
  
## Product(s)
  
azure-active-directory

## Prerequisites

- An Azure account with an [active subscription](https://azure.microsoft.com/free)
- Ability to navigate the Azure portal
- Familiarity with Azure AD B2B collaboration concepts such as inviting external users, redeeming an invitation, and using multi-factor authentication

## Summary

Define your inbound and outbound B2B collaboration with other Azure Active Directory tenants by using cross-tenant access settings. You can decide whether to allow or block B2B collaboration with other Azure AD organizations by default, and then set individual policies for specific organizations. You can trust multi-factor authentication from a user’s home tenant so they don’t have to repeat the process in your tenant. With an Azure Premium license, you also have granular control over who can use B2B collaboration and which applications can be accessed.

## Learning objectives

1. Design cross-tenant access policies that allow outbound B2B collaboration but block inbound B2B collaboration by defaul.
2. Configure cross-tenant access settings between your organization and an external partner’s organization.
3. Validate that with multi-factor-authentication trust enabled, an external partner can access a resource shared to them without having to repeat multi-factor-authentication.

## Chunk your content into subtasks

Identify the subtasks of *Secure B2B collaboration by using cross-tenant access settings*.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Configure default cross-tenant access settings | Allow outbound B2B collaboration by default, but block inbound B2B collaboration to protect internal applications | Exercise | 1 | Yes |
| Add organizational settings to allow inbound B2B collaboration from a branch organization and trust multi-factor-authentication | Allow users in the branch to access the restricted app via B2B collaboration and trust multi-factor-authentication | Exercise | 2,3 | Yes|

## Outline the units

1. **Introduction**

Suppose you're an IT admin in a financial institution. Employees in your organization regularly collaborate with partners on marketing and communications projects, so you want to allow outbound B2B collaboration with external users. However, your internal applications contain highly sensitive data, so you want to strictly control access to your applications.

You've recently acquired a branch whose employees will need access to your internal applications. This branch is managed in a separate Azure AD tenant. You don't want these users to have to complete multi-factor authentication (multi-factor-authentication) repeatedly during sign-in, so you want to streamline their experience by trusting multi-factor-authentication from the branch tenant.

2. Concept - Designing inbound and outbound settings for B2B collaboration

    - Define inbound and outbound B2B collaboration
    - Describe cross-tenant access settings and contrast them with other B2B collaboration settings
    - Describe multi-factor-authentication trust settings

3. Exercise - Configure default cross-tenant access settings to allow outbound access, but block internal access

    - Navigate to default cross-tenant access settings
    - Allow all outbound B2B collaboration
    - Block all inbound B2B collaboration

4. Concept - Creating organizational settings for B2B collaboration with another Azure AD tenant and trusting multi-factor-authentication

    - Describe how organizational settings override default settings
    - Describe how settings can be scoped to user, group, or app
    - Review multi-factor-authentication trust settings and describe the sign-in experience
  
5. Exercise – Configure organizational settings to allow inbound access to an app and trust multi-factor-authentication.

    - Add an organization (branch org)
    - Edit the inbound cross-tenant settings
    - Allow inbound B2B collaboration
    - Trust multi-factor-authentication from the organization

7. Knowledge Check

     - Match the description of an inbound policy to the setting
     - Match the description of an organizational policy to the setting
     - Predict which users will have access to an app given different cross-tenant access settings

8. Summary

    Our IT admin needed to allow employees to freely collaborate with external Azure AD partners on external applications. But the admin needed to block all external Azure AD organizations from being able to access internal applications, except for users in a branch organization. In this module, you learned that cross-tenant access settings let you enable or block B2B collaboration with other Azure AD organizations. You also learned how to trust multi-factor-authentication claims so that B2B collaboration aren't required to complete multi-factor-authentication if they've already done so in their home tenant.

## Notes

- [External Identities Cross-tenant access documentation](/azure/active-directory/external-identities/cross-tenant-access-overview)
