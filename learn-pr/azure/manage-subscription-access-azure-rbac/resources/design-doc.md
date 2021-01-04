# Module design

## Title

Assign management access to a subscription with Azure role-based access control

## Role(s)

Administrator

## Level

Beginner

## Product(s)

Azure role-based access control (Azure RBAC)

## Prerequisites

Basic understanding of how Azure RBAC works

## Summary

Identify the appropriate role to assign to an employee for management access to a subscription. Elevate your access to manage the subscription. Assign the role. Then, turn off your management access.

## Learning objectives

1. Identify scenarios where the global administrator for Azure AD may need to elevate their access in Azure.
1. Identify the appropriate role to assign to an employee.
1. Grant the employee management access to a subscription.

## Chunk your content into subtasks

Identify the subtasks of *Assign management access to subscription with Azure role-based access control*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify scenarios where the global administrator for Azure AD may need to elevate their access in Azure | Give management access for the subscription to someone else in the marketing department | Knowledge check | 1 | Yes |
| Identify the appropriate role to assign to an employee | An employee needs to be able to manage Azure resources and access billing information for that Azure subscription | Knowledge check | 2 | Yes |
| Grant the employee management access to a subscription | An employee needs to be able to manage Azure resources and access billing information for that Azure subscription | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    You're a global administrator in Azure Active Directory (Azure AD) for a large organization. The only administrator for the marketing department's Azure subscription recently left the organization. You've been asked to give management access for the subscription to someone else in the marketing department.  That person needs to be able to manage Azure resources created under that subscription. They also need have to access to the billing information for that subscription.

1. **Elevate your access to User Access Administrator**

    List the content that will enable the learner to *Identify scenarios where the global administrator for Azure AD may need to elevate their access in Azure*:

    - Azure AD and Azure RBAC permissions are independent of one another. Azure RBAC is for managing resource access like VMs.  Azure AD admin roles are for managing directory resources like user accounts. By default, the Global Administrator doesn't have access to Azure resources. (See [Do Azure roles and Azure AD administrator roles overlap?](https://docs.microsoft.com/azure/role-based-access-control/rbac-and-directory-admin-roles#do-azure-rbac-roles-and--azure-ad-administrator-roles-overlap) for reference.) However, the global admin for Azure AD can temporarily elevate their perms to the Azure role User Access Administrator. They'd do this to grant others Azure RBAC permissions so that they can manage Azure resources. Some typical use cases:
        - Regain lost access to a given Azure subscription or management group
        - Grant an administrator or another user access to a given Azure subscription or management group
        - View all Azure subscriptions or management groups in an organization
        - Allow an automation app (such as an invoicing or auditing app) to access all Azure subscriptions or management groups
    - Point out that the reason why Global admins can elevate their permissions is so they can assign Azure RBAC permissions to other people. The workflow is:
        - Global admin temporarily elevates their permissions to "User Access Administrator" to do Azure RBAC assignment. 
        - Global admin turns off that permission when they're done with the user admin task.

    Managing access to Azure Subscriptions

    - How to grant the employee management access to a subscription
        - Using the portal
        - Brief overview of doing this with the REST API and/or PowerShell
    - Stress the usefulness of revoking this permission, if possible -- for example, once any required operations have been completed

     **Knowledge check**

    What types of questions will test *Identify scenarios where the global administrator for Azure AD may need to elevate their access in Azure*?

    - A user who had owner access to a subscription has left your company. How can their access be revoked and reassigned to another employee?
    - Needs additional question

1. **Identify the appropriate role to assign**

    List the content that will enable the learner to *Identify the appropriate role to assign to an employee*:

    - Overview of Azure RBAC - at a very high-level. (Azure RBAC is in the module pre-requisites).
        - Allows very granular access to resources in Azure
        - Describe the principle of least permissions
        - Explain Owner/Contributor/Reader/User Access Administrator differences
    - Scope
        - Management Group
        - Subscription
        - Resource Group
        - Resource
    - Examples
        - Reader access to a VM
        - Owner access to a resource group
        - Contributor access to a subscription
    - Azure AD roles and differences
        - Global admin
        - User admin
        - Billing admin
    - Overview of differences between Azure and Azure AD roles
    - Finish the unit by identifying why you'd pick the Azure owner role with subscription scope as solution to the module scenario.

    **Knowledge check**

    What types of questions will test *Identify the appropriate role to assign to an employee*?

    - When should you use the User Access Administrator role, instead of the User Administrator AD role? (Notes as discussed with SME: The default for User Access Admin is at the root but you could scope it to something like a resource group. So then you could manage perms for a resource group (as an ongoing task). Seems like something you'd delegate to someone else though not the global admin (with that elevate perm).)
    - What is the effect of the **Access management for Azure resources** setting?
    

1. **Exercise - Elevate permissions and grant management access to a subscription**

    List the steps which apply the learning content from previous unit:

    1. Sign in to the Azure portal as Azure AD global admin.
    1. Go to the properties section of AAD and toggle 'Access Management for Azure Resources' on. This causes the 'User Access Administrator' role to be assigned at root scope. (Include screenshot)
    1. Sign out and sign back in the refresh your access. (There is a bug with the toggle UI. If you click away and go back to that UI, it'll show as "no" unless you sign out and back in. It'll look like they don't need to turn it back off when they go back to that UI. So to avoid confusion they need to sign out and back in so the toggle looks like yes. And it'll be clear they need to hit No to disable it.)
    1. Verify that you have the User Access Administrator role at root scope. Azure AD > Users > (user) > Azure resources. (Include a screenshot as this isn't that easy to find.)
    1. To assign an owner at the subscription scope, go to ...(basically word this like it's just a walk through and to not actually have them do it. SME thinks it'll be less risky if they don't actually do a dummy assignment. Just show them where they'd go to do the assignment) 
    1. Go to the properties section of AAD and toggle 'Access Management for Azure Resources' off. This causes the 'User Access Administrator' role to be revoked at root scope.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- Users will need to use their own subscription to complete exercises.
- Cover how to do in the Azure portal but mention that you can elevate with REST API and some other tasks can be done in PowerShell.
- For this scenario, Global Admin would assign the Owner role at the subscription scope.
- Briefly cover difference between Azure and Azure AD admin roles.
- Cover four fundamental Azure roles and more important AD admin roles. This will help show which one to choose to assign to the user at the subscription scope.
- Briefly discuss scopes (management group > subscription > resource group). Scope is covered in the Azure RBAC module linked below but customers find scopes confusing so would be useful to mention it again and use a diagram.
- Need to make sure to call out that the global admin need to turn back off the elevated management access. The only person that can turn it off is the person that turns it on.
- For the further reading section in module, we should include links to other perms related to billing. The permissions for billing are more granular and are in addition to Azure RBAC. For customers with a Microsoft Customer Agreement (new offering), see [Understand MCA roles](https://docs.microsoft.com/azure/billing/billing-understand-mca-roles).
For Enterprise Agreements, see [Understand EA roles](https://docs.microsoft.com/azure/billing/billing-understand-ea-roles). 

## Resources

- Related module: [Secure your Azure resources with Azure role-based access control (Azure RBAC)](https://docs.microsoft.com/learn/modules/secure-azure-resources-with-rbac/)
- [Elevate access to manage all Azure subscriptions and management groups](https://docs.microsoft.com/azure/role-based-access-control/elevate-access-global-admin)
- [Add or change Azure subscription administrators](https://docs.microsoft.com/azure/billing/billing-add-change-azure-subscription-administrator)
- [Best practices for Azure RBAC](https://docs.microsoft.com/azure/role-based-access-control/best-practices)
- [Four fundamental Azure roles](https://docs.microsoft.com/azure/role-based-access-control/rbac-and-directory-admin-roles#azure-roles)
- [Some important Azure AD administrator roles](https://docs.microsoft.com/azure/role-based-access-control/rbac-and-directory-admin-roles#azure-ad-roles)
- [Manage access to billing information for Azure](https://docs.microsoft.com/azure/cost-management-billing/manage/manage-billing-access)
