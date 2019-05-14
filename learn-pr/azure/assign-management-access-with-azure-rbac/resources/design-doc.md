# Module design

## Title

Assign management access to subscription with Azure role-based access control

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

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    You're a global administrator in Azure Active Directory (Azure AD) for a large organization. The administrator for the marketing department's Azure subscription recently left the organization. You've been asked to give management access for the subscription to the someone else in the marketing department.  That person needs to be able to manage Azure resources created under that subscription. They also need have access to the billing information for that subscription.

1. **Learning-content unit title**

    List the content that will enable the learner to *subtask*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

1. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

1. **Exercise - exercise unit title**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

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