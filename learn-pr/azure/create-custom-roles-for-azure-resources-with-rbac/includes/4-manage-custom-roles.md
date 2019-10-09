## Manage custom roles

In order for companies to manage custom roles within their organization, they need the facility to view custom roles and assignments, so they can keep on top of all the permissions within the company.

In the scenario, you are the owner of the subscription, you will learn how to list the custom roles and view assignments from those roles.

### Listing custom roles

It is a common scenario for a subscription owner to want see all the current custom roles within their organization. This will allow them to fully understand the current role structure and permissions of their organization

To list all the current roles, you can use the following Azure CLI command

```Azure CLI
az role definition list --custom-role-only true --output json | jq '.[] | {"roleName":.roleName, "roleType":.roleType}'
```

> [!TIP]
> Notice how the command only asks for rolename and role type, this makes it easier to view lots of roles rather than each having a verbose entry

### Viewing a specified role

If you wish to see the full verbose entry for a specific role, the following Azure CLI command can be used

```Azure CLI
    az role definition list --name "Virtual Machine Manager"
```

This gives an output similar to:

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

### Role assignments

Being able to easily view whom is assigned to roles within your organization is essential in understanding the governance of your organization in Azure.

The following, allows you to view every role assignment within your organization

```Azure CLI
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

### Who can edit roles

The **AssignableScopes** property is used to determine whom can create, delete, update or view a custom role

The following table lists the type of task along with its operation permission in Azure

Task | Operation | Description
--- | --- | ---
**Create/Delete** | `Microsoft.Authorization/roleDefinitions/write` | Users that are granted this operation on all the AssignableScopes of the custom role can create (or delete) custom roles for use in those scopes. For example, Owners and User Access Administrators of subscriptions, resource groups, and resources.
**Update** | `Microsoft.Authorization/roleDefinitions/write` | Users that are granted this operation on all the AssignableScopes of the custom role can update custom roles in those scopes. For example, Owners and User Access Administrators of subscriptions, resource groups, and resources.
**View** | `Microsoft.Authorization/roleDefinitions/read` | Users that are granted this operation at a scope can view the custom roles that are available for assignment at that scope. All built-in roles allow custom roles to be available for assignment



