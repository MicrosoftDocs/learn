
Azure role-based access control (RBAC) has several Azure built-in roles that you can assign to users, groups, service principals, and managed identities. Role assignments are the way you control access to Azure resources. If the built-in roles don't meet the specific needs of your organization, you can create your own Azure custom roles.

The four general built-in roles are:

| **Built-in Role**             | **Description**                                                                                                                                                     |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Contributor**               | Grants full access to manage all resources, but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, or share image galleries. |
| **Owner**                     | Grants full access to manage all resources, including the ability to assign roles in Azure RBAC.                                                                    |
| **Reader**                    | View all resources, but does not allow you to make any changes.                                                                                                     |
| **User Access Administrator** | Lets you manage user access to Azure resources.                                                                                                                     |

## Custom roles for Azure resources

If the built-in roles for Azure resources don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals at management group, subscription, and resource group scopes.

Custom roles can be shared between subscriptions that trust the same Azure AD directory. There is a limit of 5,000 custom roles per directory. (For Azure Germany and Azure China 21Vianet, the limit is 2,000 custom roles.) Custom roles can be created using the Azure portal, Azure PowerShell, Azure CLI, or the REST API.

## Custom role limits

The following list describes the limits for custom roles.

 -  Each directory can have up to **5000** custom roles.
 -  Azure Germany and Azure China 21Vianet can have up to 2000 custom roles for each directory.
 -  You cannot set AssignableScopes to the root scope ("/").
 -  You can only define one management group in AssignableScopes of a custom role. Adding a management group to AssignableScopes is currently in preview.
 -  Custom roles with DataActions cannot be assigned at the management group scope.
 -  Azure Resource Manager doesn't validate the management group's existence in the role definition's assignable scope.
