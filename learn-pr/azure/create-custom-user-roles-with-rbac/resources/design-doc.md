# Module design

## Title

Create custom user roles with role-based access control (RBAC)

## Role(s)

Administrator

## Level

Beginner

## Product(s)

Role-based access control for Azure resources

## Prerequisites

- Familiarity with role-based access control (RBAC) for Azure resources

## Summary

Understand the structure of role definitions. Identify role properties to use for custom role. Create custom role and assign to user. Test custom user role.

## Learning objectives

1. Identify role definition structure and properties
1. Create a custom user role
1. Test custom role definition

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

    Provide a scenario of a real-world job-task that shows how the technology is used in practice (from the module proposal):

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

    **Knowledge check**

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

Topics to cover:

1. When to use custom user roles
1. Determine permissions needed based on scenario:
   - Resource provider operations (Actions/NotActions)
   - Data operations (DataActions/NotDataActions)
   - Scope (AssignableScopes)
1. Exercise to discover permissions needed
1. Role definition structure and properties
1. Exercise to create custom user role by using Azure CLI (exercise)
   1. Create JSON file with role definition
   1. Run CLI command to create custom role
   1. List custom role in CLI
   1. Assign to role to user
   1. Test role 
1. Manage custom roles
   - [Who can manage](https://docs.microsoft.com/en-us/azure/role-based-access-control/custom-roles#who-can-create-delete-update-or-view-a-custom-role)
   - How you can list, update, and delete custom roles (portal, PowerShell, CLI, REST options)
1. Exercise for manage custom roles 
   1. View custom role in Azure portal
   1. Update custom role in CLI
   1. Delete custom role in CLI

## Resources

- [Custom roles for Azure resources - steps to create](https://docs.microsoft.com/en-us/azure/role-based-access-control/custom-roles#steps-to-create-a-custom-role)
- [Role properties](https://docs.microsoft.com/en-us/azure/role-based-access-control/custom-roles#custom-role-properties)
- [Understand role definitions for Azure resources](https://docs.microsoft.com/azure/role-based-access-control/role-definitions)
- [Tutorial: Create a custom role for Azure resources using Azure PowerShell](https://docs.microsoft.com/azure/role-based-access-control/tutorial-custom-role-powershell)
- [Tutorial: Create a custom role for Azure resources using Azure CLI](https://docs.microsoft.com/azure/role-based-access-control/tutorial-custom-role-cli)
- Related module: [Secure your Azure resources with role-based access control (RBAC)](https://docs.microsoft.com/learn/modules/secure-azure-resources-with-rbac)