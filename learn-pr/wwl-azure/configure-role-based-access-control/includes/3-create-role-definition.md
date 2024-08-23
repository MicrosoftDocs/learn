A role definition consists of sets of permissions that are defined in a JSON file. Each permission set has a name, such as _Actions_ or _NotActions_ that describe the permissions. Some examples of permission sets include:

- _Actions_ permissions identify what actions are allowed.

- _NotActions_ permissions specify what actions aren't allowed.

- _DataActions_ permissions indicate how data can be changed or used. 

- _AssignableScopes_ permissions list the scopes where a role definition can be assigned. 

The following diagram shows details for the _Contributor_ role in Azure RBAC.

:::image type="content" source="../media/role-definition-bf297cac.png" alt-text="Diagram that shows built-in roles in Azure RBAC and custom roles. Permission sets are shown for the built-in Contributor role, including Actions, Not Actions, and Data Actions." border="false":::

The _Actions_ permissions show the _Contributor_ role has all action privileges. The asterisk `"*"` wildcard means "all." The _NotActions_ permissions narrow the privileges provided by the _Actions_ set, and deny three actions:

- `Authorization/*/Delete`: Not authorized to delete or remove for "all."
- `Authorization/*/Write`: Not authorized to write or change for "all."
- `Authorization/elevateAccess/Action`: Not authorized to increase the level or scope of access privileges.

The _Contributor_ role also has two permissions to specify how data can be affected:

- `"NotDataActions": []`: No specific actions are listed. Therefore, all actions can affect the data.
- `"AssignableScopes": ["/"]`: The role can be assigned for all scopes that affect data. 

### Things to know about role definitions

Review the following characteristics of role definitions:

- Azure RBAC provides built-in roles and permissions sets. You can also create custom roles and permissions.

- The _Owner_ built-in role has the highest level of access privilege in Azure.

- The system subtracts _NotActions_ permissions from _Actions_ permissions to determine the _effective permissions_ for a role.

- The _AssignableScopes_ permissions for a role can be management groups, subscriptions, resource groups, or resources.

### Role permissions

Use the _Actions_ and _NotActions_ permissions together to grant and deny the exact privileges for each role. The _Actions_ permissions can provide the breadth of access and the _NotActions_ permissions can narrow the access. 

The following table shows how the _Actions_ or _NotActions_ permissions are used in the definitions for three built-in roles: _Owner_, _Contributor_, and _Reader_. The permissions are narrowed from the _Owner_ role to the _Contributor_ and _Reader_ roles to limit access.

| Role&nbsp;name| Description | Actions&nbsp;permissions | NotActions&nbsp;permissions |
| --- | --- | --- | --- |
| _Owner_ | Grants full access to manage all resources, including the ability to assign roles in Azure RBAC. | `*` | n/a |
| _Contributor_ | Grants full access to manage all resources, but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, or share image galleries. | `*` | - `Microsoft.Authorization/*/Delete` <br> - `Microsoft.Authorization/*/Write` <br> - `Microsoft.Authorization/elevateAccess/Action` |
| _Reader_ | View all resources, but does not allow you to make any changes. | `/*/read` | n/a |

### Role scopes

After you define the role permissions, you use the _AssignableScopes_ permissions to specify how the role can be assigned. Let's look at a few examples.

- Scope a role as available for assignment in two subscriptions:

   `"/subscriptions/c276fc76-9cd4-44c9-99a7-4fd71546436e", "/subscriptions/e91d47c4-76f3-4271-a796-21b4ecfe3624"`

- Scope a role as available for assignment only in the Network resource group:

   `"/subscriptions/c276fc76-9cd4-44c9-99a7-4fd71546436e/resourceGroups/Network"`

- Scope a role as available for assignment for all requestors:

   `"/"`   

### Things to consider when creating roles

Consider the following points about creating role definitions in Azure RBAC:

- **Consider using built-in roles**. Review the list of [built-in role definitions](/azure/role-based-access-control/built-in-roles) in Azure RBAC. There are over 100 predefined role definitions to choose from, such as _Owner_, _Backup Operator_, _Website Contributor_, and _SQL Security Manager_. Built-in roles are defined for several categories of services, tasks, and users, including General, Networking, Storage, Databases, and more.

- **Consider creating custom definitions**. Define your own [custom roles](/azure/role-based-access-control/custom-roles) to meet specific business scenarios for your organization. You can modify the permissions for a built-in role to meet the specific requirements for your organization. You can also create custom role definitions from scratch.

- **Consider limiting access scope**. Assign your roles with the minimum level of scope required to perform the job duties. Some users like administrators require full access to corporate resources to maintain the infrastructure. Other users in the organization can require write access to personal or team resource, and read-only access to shared company resources. 

- **Consider controlling changes to data**. Identify data or resources that should only be modified in specific scenarios and apply tight access control. Limit users to the least of amount of access they need to get their work done. A well-planned access management strategy helps to maintain your infrastructure and prevent security issues.

- **Consider applying deny assignments**. Determine if you need to implement the deny assignment feature. Similar to a role assignment, a deny assignment attaches a set of deny actions to a user, group, or service principal at a particular scope for the purpose of denying access. Deny assignments block users from performing specific Azure resource actions even if a role assignment grants them access.
