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

## Create or delete custom roles

## Update custom roles

## View custom roles

In the next unit, you'll see how to view custom roles in the Azure portal. You can also get a list of custom roles by using the Azure CLI or PowerShell.

To list all the custom roles by using Azure CLI, use the following command.

```azurecli
az role definition list --custom-role-only true --output json | jq '.[] | {"roleName":.roleName, "roleType":.roleType}'
```

Notice how the command only asks for role name and role type. This makes it easier to view lots of roles.

To list all the custom roles by using Azure PowerShell, use the following command. This command list the custom roles that are available for assignment in the subscription. If the subscription isn't in the AssignableScopes of the role, the custom role won't be listed.

```PowerShell
Get-AzRoleDefinition | ? {$_.IsCustom -eq $true} | FT Name, IsCustom

```

## View role definition

To see the full definition for a specific role,  use the following Azure CLI command.

```azurecli
az role definition list --name "Virtual Machine Operator"
```
To see the definition in PowerShell, use the following command.

```PowerShell
Get-AzRoleDefinition "Virtual Machine Operator" 
```

## See custom role assignment

The following command allows you to see who's assigned to the custom role you've created in Azure CLI:

```azurecli
az role assignment list --role "Virtual Machine Operator"
```

For PowerShell, use the following command.
```PowerShell
Get-AzRoleAssignment -RoleDefinitionName "Virtual Machine Operator"
```
