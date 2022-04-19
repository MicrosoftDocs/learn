
### What is Azure role-based access control (RBAC)?

[Azure RBAC](/azure/role-based-access-control/overview) allows you to grant access to Azure resources that you control. Suppose you need to manage access to resources in Azure for the Tailwind Trader’s development, engineering, and marketing teams. Here are some scenarios you can implement with Azure RBAC.

- Allow one user to manage virtual machines in a subscription and another user to manage virtual networks.

- Allow a database administrator group to manage SQL databases in a subscription.

- Allow a user to manage all resources in a resource group, such as virtual machines, websites, and subnets.

- Allow an application to access all resources in a resource group.

### How does role-based access control work?

Azure RBAC evaluates each request for access. The evaluations will determine if access should be blocked, not allowed, or allowed. 

:::image type="content" source="../media/role-based-access-control-flowchart.png" alt-text="Decision tree from no access to access allowed.":::
 

### Things to consider when using role-based access control

- **Remember RBAC is an allow model**. An allow model means when you’re assigned a role, Azure RBAC allows you to perform certain actions. For example, a role assignment could grant you read permissions to a resource group. To have write permissions the role would need to explicitly allow write access. 

- **Assign at the highest scope level that meets the requirements.** Your first step is to accurately define the role definition and related permissions. Next assign roles to users, groups, and service principals. Lastly, scope the roles to management groups, subscriptions, resource groups, and resources. Be sure to assign at the highest scope level that meets the requirements. 

    :::image type="content" source="../media/role-definition-assignment-scope.png" alt-text="A role definition is assigned to a resource and then scoped.":::


- **Only grant users the access they need.** When planning your access control strategy, it's a best practice to grant users the least privilege to get their work done. This allows you to segregate duties within your team. By limiting roles and scopes, you limit what resources are at risk if the security principal is ever compromised. Creating a diagram like this, might help to explain Azure RBAC roles. 

    :::image type="content" source="../media/scope-role-matrix.png" alt-text="Different roles appear at different scope levels.":::


- **Assign roles to groups, not users**. To make role assignments more manageable, avoid assigning roles directly to users. Instead, assign roles to groups. Assigning roles to groups helps minimize the number of role assignments.

- **Know when to use Azure policies**. [Azure policies](/azure/governance/policy/overview) focuses on resource properties. For example, during deployment, a policy can ensure users can only deploy certain virtual machines in a resource group. A combination of Azure policies and Azure RBAC can provide effective access control. 

    | Area| Azure Policy| Role-based Access Control |
    | - | - | - |
    | Description| Ensure resources are compliant with a set of rules.| Authorization system to provide fine-grained access controls. |
    | Focus| Focused on the properties of resources.| Focused on what resources the users can access. |
    | Implementation| Specify a set of rules.| Assign roles and scopes. |
    | Default access| By default, rules are set to allow.| By default, all access is denied. |

- **Know when to create a custom role.** Sometimes, the built-in roles don't grant the precise level of access you need. [Custom roles](/azure/role-based-access-control/custom-roles) allow you to define roles that meet the specific needs of your organization. Custom roles can be shared between subscriptions that trust the same Azure Active Directory.

- **Consider what happens if you have overlapping role assignments.** Azure RBAC is an additive model, so your effective permissions are the sum of your role assignments. Consider a user is granted the Contributor role at the subscription scope and the Reader role on a resource group. The sum of the Contributor permissions and the Reader permissions is effectively the Contributor role for the subscription. Therefore, in this case, the Reader role assignment has no impact. 
