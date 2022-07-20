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

Define your inbound and outbound B2B collaboration with other Azure Active Directory tenants by using cross-tenant access settings. You can decide whether to allow or block B2B collaboration with other Azure AD organizations by default, and then set individual policies for specific organizations. You have granular control over who can use B2B collaboration and which applications can be accessed. You can also trust multi-factor authentication from a user’s home tenant so they don’t have to repeat the process in your tenant.

## Learning objectives

1. Design cross-tenant access policies that allow B2B collaboration by default but limit access to an application.
1. Configure cross-tenant access settings between your organization and an external partner’s organization.
1. Validate that with MFA trust enabled, an external partner can access a resource shared to them without having to repeat MFA.

## Chunk your content into subtasks

Identify the subtasks of *Secure B2B collaboration by using cross-tenant access settings*.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Design default settings for inbound and outbound access | Define your B2B collaboration access policies for internal and external users | Exercise | 1 | Yes |
| Add organizational settings for an external Azure AD tenant | Allow B2B collaboration by default | Exercise | 1 | Yes|
| Add  | Limit app access to specific users in an external organization| Exercise  | 2 | Yes|
| Contrast the sign-in experience | Different experience for blocked and allowed access | Knowledge check | 1,2,3 | Yes|

## Outline the units

Add more units as needed for your content

1. **Introduction**

Suppose you're an IT admin in a financial institution. Employees in your organization regularly collaborate with partners on marketing and communications projects, so you want to allow B2B collaboration with external users. However, your accounting application contains highly sensitive data, so you want to strictly control access to this application.

You've recently acquired a branch whose employees will need access to your accounting application. This branch is managed in a separate Azure AD tenant. You don't want these users to have to complete multi-factor authentication (MFA) repeatedly during sign-in, so you want to streamline their experience by trusting MFA from the branch tenant. In addition to these users, there are two individual auditors from an external firm who also need access to your accounting application for an upcoming audit.

2. Concept - Designing inbound and outbound settings for B2B collaboration

    - Define inbound and outbound B2B collaboration
    - Describe cross-tenant access settings and contrast them with other B2B collaboration settings
    - Describe MFA trust settings

3. Exercise - Configure default cross-tenant access settings to allow inbound and outbound access, but block an internal app

    - Navigate to default cross-tenant access settings
    - Allow all outbound B2B collaboration
    - Allow all inbound B2B collaboration except for a specific app (accounting app)

4. Concept - Creating organizational settings for B2B collaboration with another Azure AD tenant and trusting MFA

    - Describe how organizational settings override default settings
    - Describe how settings can be scoped to user, group, or app
    - Review MFA trust settings and describe the sign-in experience
  
5. Exercise – Configure organizational settings to allow inbound access to an app and trust MFA.

    - Add an organization (branch org)
    - Edit the inbound cross-tenant settings
    - Allow inbound B2B collaboration scoped to a specific app (accounting app)
    - Trust MFA from the organization

6. Concept - Scoping cross-tenant access settings to specific organizations and users

   - Describe how you add an organization and define the organization's inbound cross-tenant access settings to limit access to a specific app by individual users

6. Exercise - Configure organizational settings to allow access to an app by individual users

    - Add an organization (auditing org)
    - Edit the inbound cross-tenant settings
    - Allow inbound B2B collaboration scoped to a specific app and individual users

7. Knowledge Check

     - Match the description of an inbound policy to the setting
     - Match the description of an organizational policy to the setting
     - Predict which users will have access to an app given different cross-tenant access settings

8. Summary

    Our IT admin needed to employees to freely collaborate with external partners on most apps, but access to the accounting app needed to be limited to users in a branch organization and just two individuals from an auditing firm. In this module, you learned that cross-tenant access settings let you enable or block B2B collaboration with other Azure AD organizations. You can apply settings across all Azure AD organizations, or you can scope them to individual Azure AD organizations, apps, and users or groups. You also learned how to trust MFA claims so that B2B collaboration aren't required to complete MFA if they've already done so in their home tenant.

## Notes

- [External Identities Cross-tenant access documentation](https://docs.microsoft.com/azure/active-directory/external-identities/cross-tenant-access-overview)