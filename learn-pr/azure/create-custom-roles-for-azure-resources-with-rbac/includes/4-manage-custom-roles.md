Azure makes it easy for you to find out who can do what actions in your subscription.

In this unit, you'll learn who can manage custom roles and how.

## Who can manage Azure RBAC custom roles?

Generally, administrators with the Owner or User Access Administrator roles have permissions to create and manage custom roles. By default, those roles have the Microsoft.Authorization/roleDefinitions/write permission on all role assignment scopes. That permission is required to create, delete, or update custom roles.

The role assignment scopes are defined in the custom role definition under **AssignableScopes**. As discussed in unit 2, the **AssignableScopes**  could be one or more management groups, subscriptions, resource groups, or resources.

The following table lists the permission you'd need to create, delete, update, or view custom roles. To manage custom roles, you'd need to be assigned to a role that has the related **Actions** and **AssignableScopes** in the role definition.

Task | Actions | Description
--- | --- | ---
**Create/Delete** | `Microsoft.Authorization/roleDefinitions/write` | Users can create or delete custom roles for use in scopes. For example, Owners and User Access Administrators of subscriptions, resource groups, and resources.
**Update** | `Microsoft.Authorization/roleDefinitions/write` | Users can update custom roles in scopes. For example, Owners and User Access Administrators of subscriptions, resource groups, and resources.
**View** | `Microsoft.Authorization/roleDefinitions/read` | Users can view the custom roles available for assignment at a scope. All built-in roles allow custom roles to be available for assignment.


## Find custom roles

To list all the custom roles, use the following Azure CLI command:

```azurecli
az role definition list --custom-role-only true --output json | jq '.[] | {"roleName":.roleName, "roleType":.roleType}'
```

Notice how the command only asks for role name and role type. This makes it easier to view lots of roles.

### View a specified role

To see the full definition for a specific role,  use the following Azure CLI command:

```azurecli
az role definition list --name "Virtual Machine Operator"
```



## Assign custom roles

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

