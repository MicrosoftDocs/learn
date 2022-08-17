[Azure RBAC](/azure/role-based-access-control/overview) allows you to grant access to Azure resources that you control. Azure RBAC evaluates each request for access and determines if access should be blocked, not allowed, or allowed. 

:::image type="content" source="../media/role-based-access-control-flowchart.png" alt-text="Diagram of an RBAC decision tree that shows the flow from no access to access allowed." border="false":::
 
RBAC is an allow model. An _allow model_ means when a user is assigned a specific role, Azure RBAC allows the user to perform the actions associated with that role. A role assignment could grant a user read permissions to a resource group. To have write permissions, the role would need to explicitly allow write access. 

### Things to know about Azure RBAC

Suppose you need to manage access to resources in Azure for Tailwind Traders Development, Engineering, and Marketing teams. Here are some scenarios you can implement with Azure RBAC:

- Allow one user to manage virtual machines in a subscription, and allow another user to manage virtual networks.

- Allow members of a database administrator group to manage SQL databases in a subscription.

- Allow a user to manage all resources in a resource group, such as virtual machines, websites, and subnets.

- Allow an application to access all resources in a resource group.

### Things to consider when using Azure RBAC

You have a plan for how to apply Azure Policy settings to your Tailwind Traders applications. Now consider how to integrate Azure RBAC to control user privileges and resource access.

- **Consider the highest scope level for each requirement**. Your first step is to accurately define each role definition and its permissions. Next, assign the roles to specific users, groups, and service principals. Lastly, scope the roles to management groups, subscriptions, resource groups, and resources. Assign each role at the highest scope level that meets the requirements.

   :::image type="content" source="../media/role-definition-assignment-scope.png" alt-text="Diagram that shows how a role definition is assigned to a resource and then scoped." border="false":::

- **Consider the access needs for each user**. As you plan your access control strategy, it's a best practice to grant users the least privilege they need to get their work done. This method makes it easier to separate team member responsibilities. By limiting roles and scopes, you limit what resources are at risk if a security principal is ever compromised. You can create a diagram like the following example to help plan your Azure RBAC roles for Tailwind Traders. 

   :::image type="content" source="../media/scope-role-matrix.png" alt-text="Diagram that shows how to plan roles of different scope levels within the organization." border="false":::

- **Consider assigning roles to groups, and not users**. To make role assignments more manageable, avoid assigning roles directly to users. Instead, assign roles to groups. Assigning roles to groups helps minimize the number of role assignments.

- **Consider when to use Azure policies**. [Azure policies](/azure/governance/policy/overview) are used to focus on resource properties. During deployment, an Azure policy can be used to ensure users can deploy only certain virtual machines in a resource group. By using a combination of Azure policies and Azure RBAC, you can provide effective access control inn your Tailwind Traders solution. The following table compares these access models.

   | <!-- blank --> | Azure Policy | Azure RBAC |
   | --- | --- | --- |
   | **Description** | Defined policies to ensure resources are compliant with a set of rules. | Authorization system that provides fine-grained access controls. |
   | **Main focus** | Focused on the properties of resources. | Focused on what resources users can access. |
   | **Implementation** | Specify a set of rules. | Assign roles and scopes. |
   | **Default access** | By default, policy rules are set to _allow_. | By default, all access for all users is _denied_. |

- **Consider when to create a custom role**. Sometimes, the built-in roles don't grant the precise level of access you need. [Custom roles](/azure/role-based-access-control/custom-roles) allow you to define roles that meet the specific needs of your organization. Custom roles can be shared between subscriptions that trust the same Azure Active Directory.

- **Consider how to resolve overlapping role assignments**. Azure RBAC is an additive model, so your effective permissions are the sum of your role assignments. Consider a user is granted the **Contributor** role at the subscription scope and the **Reader** role on a resource group. The sum of the Contributor permissions and the Reader permissions is effectively the Contributor role for the subscription. Therefore, in this case, the Reader role assignment has no impact.