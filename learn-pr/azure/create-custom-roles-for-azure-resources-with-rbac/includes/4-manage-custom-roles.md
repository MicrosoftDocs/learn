Azure makes it easy for you to find out who can do what actions in your subscription.

In this unit, you'll learn how to list the custom roles and view assignments from those roles.

## List custom roles

To list all the custom roles, use the following Azure CLI command:

```azurecli
az role definition list --custom-role-only true --output json | jq '.[] | {"roleName":.roleName, "roleType":.roleType}'
```

Notice how the command only asks for role name and role type. This makes it easier to view lots of roles.

## View a specified role

To see the full definition for a specific role,  use the following Azure CLI command:

```azurecli
az role definition list --name "Virtual Machine Operator"
```

This command gives an output similar to:

```JSON
[
  {
    "assignableScopes": [
      "/subscriptions/11111111-1111-1111-1111-111111111111"
    ],
    "description": "Can monitor and restart virtual machines.",
    "id": "/subscriptions/11111111-1111-1111-1111-111111111111/providers/Microsoft.Authorization/roleDefinitions/00000000-0000-0000-0000-000000000000",
    "name": "00000000-0000-0000-0000-000000000000",
    "permissions": [
      {
        "actions": [
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
        "dataActions": [],
        "notActions": [],
        "notDataActions": []
      }
    ],
    "roleName": "Virtual Machine Operator",
    "roleType": "CustomRole",
    "type": "Microsoft.Authorization/roleDefinitions"
  }
]
```

## Role assignments

To understand the governance of your organization in Azure, it's essential that you're able to see how the roles are assigned.

The following command allows you to view every role assignment within your organization:

```azurecli
az role assignment list [--all]
                        [--assignee]
                        [--include-classic-administrators {false, true}]
                        [--include-groups]
                        [--include-inherited]
                        [--resource-group]
                        [--role]
                        [--scope]
                        [--subscription]
```

## Who can manage custom roles?

The **AssignableScopes** property is used to determine who can create, delete, update, or view a custom role.

The following table lists the type of task, along with its operation permission in Azure:

Task | Operation | Description
--- | --- | ---
**Create/Delete** | `Microsoft.Authorization/roleDefinitions/write` | Users can create or delete custom roles for use in scopes. For example, Owners and User Access Administrators of subscriptions, resource groups, and resources.
**Update** | `Microsoft.Authorization/roleDefinitions/write` | Users can update custom roles in scopes. For example, Owners and User Access Administrators of subscriptions, resource groups, and resources.
**View** | `Microsoft.Authorization/roleDefinitions/read` | Users can view the custom roles available for assignment at a scope. All built-in roles allow custom roles to be available for assignment.
