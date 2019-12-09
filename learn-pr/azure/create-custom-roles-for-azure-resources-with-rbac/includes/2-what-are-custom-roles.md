Sometimes, the roles built into Azure don't grant the precise level of access you need.

Suppose you want to assign permissions in Azure for your new employee, who's responsible for managing VMs within the subscription. You want to understand whether to use Azure Active Directory (Azure AD) roles or Role-Based Access Control (RBAC) for these permissions.

In this unit, you learn about RBAC roles and how to create and assign them.

## Active Directory and RBAC

These role types are often confused when you first work with Azure. Active Directory roles provide the mechanism for managing permissions to AD resources only. RBAC provides a wealth of capabilities for managing every resource in Azure at a granular level.

![Diagram that shows relationship of RBAC and Azure AD administrator roles](../media/2-azure-office-roles.png)

The subtle differences between how the two can be set up and managed are listed below:

Azure RBAC roles | Azure AD administrator roles
--- | ---
Manage access to Azure resources | Manage access to Azure Active Directory resources
Allows custom roles | Allows custom roles
Multiple scope levels (management group, subscription, resource group, resource) | Scope only at tenant level
Role information accessible through Azure portal, Azure CLI, Azure PowerShell, Azure Resource Manager templates, REST API | Role information can be accessed in Azure admin portal, Microsoft 365 admin center, Microsoft Graph, AzureAD PowerShell

## Assigning custom roles

To add or remove custom roles, you must have role permissions such as:

`Microsoft.Authorization/roleAssignments/write` and `Microsoft.Authorization/roleAssignments/delete`.

These role permissions are given to User access administrators and owners. Custom roles can be assigned to:

Security principal | Summary
--- | ---
**User** | An individual who has a profile in Azure Active Directory
**Group** | A set of users created in Azure Active Directory
**Service principals** | A security identity used by applications or services to access specific Azure resources
**Managed identity** | An identity in Azure Active Directory that is automatically managed by Azure

This assignment and related permissions can be scoped to different levels within Azure. In the example, the new employee could be assigned a custom role at the subscription level (assuming the VMs are contained within your subscription). The different scopes are:

- Management group
- Subscription
- Resource group
- Individual resource

![Diagram that shows scopes for role assignment](../media/2-rbac-scope.png)

## Role definition and structure

A custom role definition breaks down into a collection of different permissions. Each definition details the operations that are allowed, such as read, write, and delete. The definition is formed using these structures:

```JSON
{
  "Name": "",
  "IsCustom": true,
  "Description": "",
  "Actions": [],
  "NotActions": [],
  "DataActions": [],
  "NotDataActions": [],
  "AssignableScopes": [
    "/subscriptions/{subscriptionId1}"
  ]
}
```

<!--Image taken from https://docs.microsoft.com/en-us/azure/role-based-access-control/overview - Can the '3 Role Definition' be removed please-->
The following example shows the role definition for the Contributor role. 
![Illustration that shows an example role definition for Contributor](../media/2-rbac-role-definition.png)

Any role definition is declared using the following format:

`{Company}.{ProviderName}/{resourceType}/{action}`

The parameter can be one of the following actions:

- \*
- read
- write
- action
- delete

Using the scenario, here's an example of a custom role for managing VMs. You'll see there's a wide variety of actions that can be applied. Learning the actions available will help you better implement RBAC solutions.

```JSON
{
  "Name": "Virtual Machine Operator",
  "Id": "88888888-8888-8888-8888-888888888888",
  "IsCustom": true,
  "Description": "Can monitor and restart virtual machines.",
  "Actions": [
    "Microsoft.Storage/*/read",
    "Microsoft.Network/*/read",
    "Microsoft.Compute/*/read",
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action",
    "Microsoft.Authorization/*/read",
    "Microsoft.ResourceHealth/availabilityStatuses/read",
    "Microsoft.Resources/subscriptions/resourceGroups/read",
    "Microsoft.Insights/alertRules/*",
    "Microsoft.Insights/diagnosticSettings/*",
    "Microsoft.Support/*"
  ],
  "NotActions": [],
  "DataActions": [],
  "NotDataActions": [],
  "AssignableScopes": [
    "/subscriptions/{subscriptionId1}",
    "/subscriptions/{subscriptionId2}",
    "/subscriptions/{subscriptionId3}"
  ]
}
```
