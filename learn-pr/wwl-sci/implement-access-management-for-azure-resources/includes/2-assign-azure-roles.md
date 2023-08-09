
Azure role-based access control (Azure RBAC) is the authorization system you use to manage access to Azure resources. To grant access, you assign roles to users, groups, service principals, or managed identities at a particular scope. Primary steps to follow when assigning an Azure role:

1.  Who needs access?
    
    
     -  **User** \- Only a single person is needed for the task. You can assign a role to users in other tenants.
     -  **Group** \- Use when you need to grant a set of users the same role.
     -  **Service Principal** \- Assign a role to a service principal when you want to grant an application access to an Azure resource.
     -  **Managed Identity** \- Use the managed identity when you want an application to manage credentials for authentication.
2.  Select the right role. Use the built-in roles or create a custom role with the specific capabilities you need.
    
    
     -  Built-in Azure roles
        
        
         -  Owner - full access to all resources.
         -  Contributor - Can create and manage all types of Azure resources, but can't grant access.
         -  Reader - Can view the available Azure resources.
         -  User Access Administrator - Assign access to Azure resources.
         -  Other task specific roles, like Virtual Machine Contributor, can be assigned.
3.  Identify what level to assign the role (the Scope). Scope is the set of resources that the access applies to. In Azure, you can specify a scope at four levels: management group, subscription, resource group, and resource. Scopes are structured in a parent-child relationship. Each level of hierarchy makes the scope more specific. You can assign roles at any of these levels of scope. The level you select determines how widely the role is applied. Lower levels inherit role permissions from higher levels. Example:
    
    ```
     - If you assign the **Reader role** to a user at the **management group scope**, that user can read everything in all subscriptions in the management group.
     - If you assign the **Billing Reader role** to a group at the **subscription scope**, the members of that group can read billing data for every resource group and resource in the subscription.
    
     - If you assign the **Contributor role** to an application at the **resource group scope**, it can manage resources of all types in that resource group, but not other resource groups in the subscription.
    
    ```
    
    It's a best practice to grant security-principals the least privilege they need to perform their job. Avoid assigning broader roles at broader scopes even if it initially seems more convenient. By limiting roles and scopes, you limit what resources are at risk if the security-principal is ever compromised. For more information, see Understand scope.
4.  Confirm the currently logged in user has the rights need to assign the Azure role.
5.  Assign the role. Once you know the security-principal, role, and scope, you can assign the role. You can assign roles using the Azure portal, Azure PowerShell, Azure CLI, Azure SDKs, or REST APIs. You can have up to 2000 role assignments in each subscription. This limit includes role assignments at the subscription, resource group, and resource scopes. You can have up to 500 role assignments in each management group.

### Assign an Azure role from the portal

:::image type="content" source="../media/assign-role-resource-group-d2406eba.png" alt-text="Screenshot of the Azure portal.  It shows a sample resource group with the Assign Role selected.":::


Whether you are in the User, Group, Resource Group, or Subscription you'll generally use the Access content (IAM) page to make the assign. It's also known as identity and access management (IAM) and appears in several locations in the Azure portal.

### Assign an Azure role with script

PowerShell using the Microsoft Graph PowerShell cmdlet

```
New-AzRoleAssignment -ObjectId <objectId> `
-RoleDefinitionName <roleName> `
-Scope /subscriptions/<subscriptionId>/resourcegroups/<resourceGroupName>/providers/<providerName>/<resourceType>/<resourceSubType>/<resourceName>

```

CLI scripting

```
az role assignment create --assignee "{assignee}" \
--role "{roleNameOrId}" \
--resource-group "{resourceGroupName}"

```
