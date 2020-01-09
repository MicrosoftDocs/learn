
The administrator for the marketing department's Azure subscription recently left the organization. You don’t have access to this subscription. You now need to give administrator access for the subscription to another person in the marketing department.

In this unit, you'll explore when you may need to elevate access.

## When to elevate access

By default, the Global Administrator doesn't have access to Azure resources. The Global Administrator for Azure Active Directory (Azure AD) can temporarily elevate their permissions to the Azure role-based access control (Azure RBAC) role of *User Access Administrator*. This action grants the Azure RBAC permissions needed to manage Azure resources. The User Access Administrator is assigned at the scope of root. The role can view all resources, and assign access, in any subscription or management group in that Azure AD organization.

The following diagram shows what resources the Global Administrator can view when their permissions are elevated to User Access Administrator.

![Diagram that shows User Access Admin elevated privilege relationships](../media/2-globaladmin-user-access-admin.png)

A Global Administrator may need to elevate their permissions to:

- Regain lost access to an Azure subscription or management group
- Grant another user or yourself access to an Azure subscription or management group
- View all Azure subscriptions or management groups in an organization
- Allow an automation app access to all Azure subscriptions or management groups

After the Global Administrator elevates their permissions to User Access Administrator, they can then grant others the Azure RBAC permissions that they need to control and manage Azure resources. The Global Administrator should revoke the elevated permissions when the task is done.

## Assign a user as an administrator of an Azure subscription

To grant a user administrative access to a subscription, you must have `Microsoft.Authorization/roleAssignments/write` and `Microsoft.Authorization/roleAssignments/delete` permission at the subscription scope. Users with the subscription Owner or User Access Administrator roles have these permissions.

 In the next unit, you'll see how to assign a role by using the Azure portal after you've elevated your permissions to User Access Administrator. But you can also assign roles by using the Azure PowerShell, Azure CLI, or the REST API. Let's briefly review the commands you'd use to assign a role in Azure PowerShell or Azure CLI.

### Assign role by using Azure PowerShell

The following command shows how to assign the owner role to a user at the subscription scope by using Azure PowerShell.

```PowerShell
  New-AzRoleAssignment `
    -SignInName rbacuser@example.com `
    -RoleDefinitionName "Owner" `
    -Scope "/subscriptions/<subscriptionID>"
  ```

### Assign role by using Azure CLI

The following command shows how to assign the owner role to a user at the subscription scope by using Azure CLI.

```azurecli
  az role assignment create \
    --assignee rbacuser@example.com \
    --role "Owner" \
    --subscription <subscription_name_or_id>
```

