# Module design

## Title

Create Azure users and groups in Azure Active Directory

## Role(s)

Administrator

## Level

Beginner

## Product(s)

- Azure Active Directory (Azure AD)
- Azure Active Directory B2B

## Prerequisites

None

## Summary

Create users in Azure Active Directory. Understand different types of groups. Create group and add members. Manage business-to-business guest accounts.

## Learning objectives

1. Add users to Azure Active Directory
1. Manage app and resource access using Azure Active Directory groups
1. Give guest users access in Azure Active Directory B2B

## Chunk your content into subtasks


| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Choose the types of accounts to use | Add developer team, and external design team, to AD | KC | 1 | Yes |
| Add users to Azure Active Directory | Add developer team, and external design team, to AD | Exercise | 1 | Yes |
| Plan for using groups to manage resource access | Help support team collaboration | KC | 2 | Yes |
| Assign users to groups | Help support team collaboration | Exercise | 2 | Yes |
| Describe guest accounts in AD | Help support team collaboration | KC | 3 | Yes |
| Implement guest accounts | Help support team collaboration | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    You're a global administrator in Azure Active Directory for a marketing organization. Your organization recently added a small developer team to build a new website hosted on Azure. You're also partnering with an external organization to design the website. You've been asked to add the new developer team to your organization's Azure Active Directory. To make it easier for the teams to collaborate on the website, you decide to create guest accounts in Azure Active Directory for the external design organization.

1. **What are user accounts in Azure Active Directory?**

    In Azure Active Directory (Azure AD), all users are granted a set of default permissions. A user's access consists of the type of user, their role assignments, and their ownership of individual objects.

    Explain the different types of users - member, guest and special accounts such as Administrator and account roles, rights, and permissions.  Point out that in this context, there are two types that show up in the UI: member user (member of the directory) and guest. 

    **Default/member users**

    The properties of member users.

    **Guest Users**

    Guest users have restricted directory permissions. When you invite someone to collaborate with your organization you are adding them to your directory as a guest user. Then you can either send an invitation email that contains a redemption link or send a direct link to an app you want to share. Guest users can sign in with their own work, school, or social identities.

    Highlight that the ability to invite guests can be turned off by the User Administrator. (By default it's enabled.)

    (Note to developer: See link on redemption process - there is an update coming to this article: <https://docs.microsoft.com/en-us/azure/active-directory/b2b/redemption-experience> (look for update date June 2019))

    **Admin roles**

    You assign Azure AD administrator roles to a limited group of users to manage Azure AD resources in a directory. You can assign Azure AD administrator roles that allow a user to create or edit users, assign administrative roles to others, reset user passwords, manage user licenses, and more.

    If your user account has the User Administrator or Global Administrator role, you can create a new user in Azure AD using either the Azure Portal, Azure CLI, or PowerShell. In PowerShell, use the cmdlet `New-AzureADUser`. In Azure CLI, use `az ad user create`.

    Show that you can add new users or delete existing users from your Azure Active Directory (Azure AD) organization. Explain how deletions are handled: Once you delete a user, the account remains in a suspended state for 30 days. During that 30-day window, the user account can be restored

    - Add individual users accounts
    - How to bulk add users accounts using PowerShell.

    **Knowledge check**

    What types of questions will test *adding users to AD*?
    - If you delete a user by mistake can it be restored?
    - What kind of account would you create to allow an external organization easy access?

1. **Exercise - Add and delete users in Azure Active Directory**

    This exercise uses the sandbox, and a new directory, or if that won't work, student will use their own account.

    This exercise uses the Azure portal.

    - Sign in to the **Azure portal** as an administrator for the organization.
    - Add a new User - Select Azure Active Directory, select Users, and then select New user
    - Delete a User -  Select Azure Active Directory, select Users, and then search for and select the user you want to delete from your Azure AD tenant.
    - Recover deleted items (Restore a recently deleted user using Azure Active Directory)

1. **Manage app and resource access using Azure Active Directory groups**

    Azure Active Directory (Azure AD) helps you to manage your cloud-based apps, on-premises apps, and your resources using your organization's groups. Your resources can be part of the directory, such as permissions to manage objects through roles in the directory, or external to the directory, such as for Software as a Service (SaaS) apps, Azure services, SharePoint sites, and on-premises resources.

    - How does access management in Azure AD work
    - Azure AD helps you give access to your organization's resources by providing access rights to a single user or to an entire Azure AD group
        - Can assign a set of access permissions to all the members of the group
    - Ways to assign access rights
        - Direct assignment
        - Group assignment
        - Rule-based assignment
    - Include info about groups including dynamic groups
        - You can use rules to determine group membership based on user or device properties

1. **Exercise - Assign users to Azure Active Directory groups**

    This exercise uses the Azure portal.

    - Sign in to the **Azure portal** as a User administrator for the organization.
    - Add a new Group - Select Azure Active Directory, select Groups, and then select New group
    - Use direct assignment to add a user to this group.
    - Modify group to use dynamic assignment.  

1. **Collaborate using guest accounts and Azure Active Directory B2B**

    Azure AD Business-to-Business (B2B) where you can add users of other companies to your Azure AD tenant

    Include info on roles to do these tasks. Global administrator and User administrator can create and delete users. Most users can invite guests, but that ability can be limited by the admin. 

    As a user who is assigned any of the limited administrator directory roles, you can use the Azure portal to invite B2B collaboration users. You can invite guest users to the directory, to a group, or to an application. After you invite a user through any of these methods, the invited user's account is added to Azure Active Directory (Azure AD), with a user type of Guest. The guest user must then redeem their invitation to access resources.

    - Explain what guest user access is in Azure Active Directory B2B
    - Collaborate with any partner using their identities
    - Easily add guest users in the Azure AD portal
    - Compare B2B with federation

1. **Exercise - Give guest users access in Azure Active Directory B2B**

    You will use the Azure portal to invite B2B collaboration users. You can invite guest users to the directory, to a group, or to an application. After you invite a user through any of these methods, the invited user's account is added to Azure Active Directory (Azure AD), with a user type of Guest.
    
    After you add a guest user to the directory, you can either send the guest user a direct link to a shared app, or the guest user can click the redemption URL in the invitation email.
     - Add guest users to the directory
     - Add guest users to a group
     - Add guest users to an application
     - Resend invitations to guest users
    
1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
    
    Add clean up information for the tenant. Mention they can't clean up tenant if they've created one. But probably want to delete the accounts created.

## Notes

Tasks to cover in the module:

- Add individual users and guest accounts.
- How to bulk add users and guest accounts using PowerShell. You can't do this in the portal UI right now.
- Include info about groups including dynamic groups.
- Delete and manage user and guest accounts
- Recover deleted items.
- Include info on roles to do these tasks. Global administrator and User administrator can create and delete users. Most users can invite guests, but that ability can be limited by the admin.

Sandbox info:

- Similar to the module being developed for "Allow users to reset their password with Azure Active Directory self-service password reset", users should be able to go through exercises by creating a new directory within sandbox or their own account. This would be on a trial license for AD that's created outside the Azure sandbox scope. We think users won't be able to delete or clean up this tenant- it'll just expire after a month (with no charge). So we'll want to group together AD learning paths. See [Quickstart: Set up a dev environment](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-create-new-tenant#work-and-school-accounts-or-personal-microsoft-accounts).
- We should show the steps in Azure Portal but let users know that they can do steps in PowerShell or CLI where appropriate.

## Resources

- [Add or delete users using Azure Active Directory](https://docs.microsoft.com/azure/active-directory/fundamentals/add-users-azure-active-directory)
- [Create a basic group and add members using Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal?)
- [Create a dynamic group and check status](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/groups-create-rule)
- [Add Azure Active Directory B2B collaboration users in the Azure portal](https://docs.microsoft.com/azure/active-directory/b2b/add-users-administrator)
- [Tutorial: Bulk invite Azure AD B2B collaboration users](https://docs.microsoft.com/en-us/azure/active-directory/b2b/tutorial-bulk-invite)
- [Enable B2B external collaboration and manage who can invite guests](https://docs.microsoft.com/en-us/azure/active-directory/b2b/delegate-invitations)
- [Cmdlets for group management](https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/groups-settings-v2-cmdlets#create-groups)
- [New user cmdlet](https://docs.microsoft.com/en-us/powershell/module/azuread/New-AzureADUser?view=azureadps-2.0)