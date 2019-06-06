# Module design

## Title

Assign management access to a subscription with Azure role-based access control

## Role(s)

Administrator

## Level

Beginner

## Product(s)

Role-based access control (RBAC) for Azure resources

## Prerequisites

Basic understanding of how RBAC works in Azure

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

    You're a global administrator in Azure Active Directory (Azure AD) for a large organization. The administrator for the marketing department's Azure subscription recently left the organization. You've been asked to give management access for the subscription to someone else in the marketing department.  That person needs to be able to manage Azure resources created under that subscription. They also need have to access to the billing information for that subscription.

1. **Elevate your access to User Access Administrator**

    List the content that will enable the learner to *Identify scenarios where the global administrator for Azure AD may need to elevate their access in Azure*:

    - Azure AD and RBAC permissions are independent of one another. However, the global admin for Azure AD can grant themselves all RBAC permissions. Some typical use cases:
        - Regain lost access to a given Azure subscription or management group
        - Grant an administrator or another user access to a given Azure subscription or management group
        - View all Azure subscriptions or management groups in an organization
        - Allow an automation app (such as an invoicing or auditing app) to access all Azure subscriptions or management groups
    - Point out that the reason why Global admins can elevate their permissions is so they can assign RBAC permissions to other people. The workflow is:
        - Global admin temporarily elevates their permissions to "User Access Administrator" to do RBAC assignment. 
        - Global admin turns off that permission when they're done with the user admin task.

    Managing access to Azure Subscriptions

    - How to grant the employee management access to a subscription
        - Using the portal
        - Brief overview of doing this with the REST API and/or PowerShell
    - Stress the usefulness of revoking this permission, if possible -- for example, once any required operations have been completed

     **Knowledge check**

    What types of questions will test *Identify scenarios where the global administrator for Azure AD may need to elevate their access in Azure*?

    - A user who had owner access to a subscription has left your company. How can their access be revoked and reassigned to another employee?
    - A

1. **Identify the appropriate role to assign**

    List the content that will enable the learner to *Identify the appropriate role to assign to an employee*:

    - Overview of RBAC in Azure - at a very high-level. (RBAC is in the module pre-requisites).
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
    - Overview of differences between RBAC and Azure AD roles
    - Finish the unit by identifying why you'd pick the RBAC owner role with subscription scope as solution to the module scenario.

    **Knowledge check**

    What types of questions will test *Identify the appropriate role to assign to an employee*?

    - When should you use the User Access Administrator RBAC role, instead of the User Administrator AD role?
    - What is the effect of the Global admin can manage Azure Subscriptions and Management Groups setting?

    

1. **Exercise - Elevate permissions and grant management access to a subscription**

    List the steps which apply the learning content from previous unit:

    1. Log in to the Azure Portal as Azure AD global admin.
    1. Go to the properties section of AAD and toggle 'Access Management for Azure Resources' on. This causes the 'User Access Administrator' role to be assigned at root scope.
    1. For the purposes of this exercise, you can add an external user (this could also be another MS ID you own) and assign ownership of a given subscription to that email.
    1. Verify that this additional user / email can make changes reflective of the assigned permissions.
    1. Log back in to the Azure Portal as Azure AD global admin, i.e. the account previously used to make the change.
    1. Go to the properties section of AAD and toggle 'Access Management for Azure Resources' off. This causes the 'User Access Administrator' role to be revoked at root scope.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- Users will need to use their own subscription to complete exercises.
- Cover how to do in the Azure portal but mention that you can elevate with REST API and some other tasks can be done in PowerShell.
- For this scenario, Global Admin would assign the Owner RBAC role at the subscription scope.
- Briefly cover difference between RBAC and Azure AD admin roles.
- Cover four fundamental RBAC roles and more important AD admin roles. This will help show which one to choose to assign to the user at the subscription scope.
- Briefly discuss scopes (management group > subscription > resource group). Scope is covered in the RBAC module linked below but customers find scopes confusing so would be useful to mention it again and use a diagram.
- Need to make sure to call out that the global admin need to turn back off the elevated management access. The only person that can turn it off is the person that turns it on.
- For the further reading section in module, we should include links to other perms related to billing. The permissions for billing are more granular and are in addition to RBAC. For customers with a Microsoft Customer Agreement (new offering), see [Understand MCA roles](https://docs.microsoft.com/en-us/azure/billing/billing-understand-mca-roles).
For Enterprise Agreements, see [Understand EA roles](https://docs.microsoft.com/en-us/azure/billing/billing-understand-ea-roles). 

## Resources

- Related module: [Secure your Azure resources with role-based access control (RBAC)](https://docs.microsoft.com/learn/modules/secure-azure-resources-with-rbac/)
- [Elevate access to manage all Azure subscriptions and management groups](https://docs.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin)
- [Add or change Azure subscription administrators](https://docs.microsoft.com/en-us/azure/billing/billing-add-change-azure-subscription-administrator)
- [Best practices using RBAC](https://docs.microsoft.com/en-us/azure/role-based-access-control/overview#best-practice-for-using-rbac)
- [Four fundamental RBAC roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/rbac-and-directory-admin-roles#azure-rbac-roles)
- [Some important Azure AD administrator roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/rbac-and-directory-admin-roles#azure-ad-administrator-roles)
- [Manage access to billing information for Azure](https://docs.microsoft.com/en-us/azure/billing/billing-manage-access)