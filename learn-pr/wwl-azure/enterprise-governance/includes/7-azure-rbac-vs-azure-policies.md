
There are a few key differences between Azure Policy and **Azure role-based access control (Azure RBAC)**. Azure Policy evaluates the state by examining properties on resources that are represented in Resource Manager and properties of some Resource Providers. Azure Policy ensures that the resource state is compliant with your business rules without concern for who made the change or who has permission to make a change. Azure Policy, through the DenyAction effect, can also block specific actions on resources. Some Azure Policy resources, such as **policy definitions**, **initiative definitions**, and **assignments**, are visible to all users. This design enables transparency to all users and services regarding what policy rules are set in their environment.

Azure RBAC focuses on managing **user actions** at different scopes. If control of an action is required based on user information, then Azure RBAC is the correct tool to use. Even if an individual has access to perform an action, if the result is a non-compliant resource, Azure Policy still blocks the create or update task.<br>

The combination of Azure RBAC and Azure Policy provides full-scope control in Azure.<br>

## Azure RBAC permissions in Azure Policy

Azure Policy has several permissions, known as **operations**, in **two Resource Providers**:

1.  Microsoft.Authorization<br>
2.  Microsoft.PolicyInsights

Many built-in roles grant permission to Azure Policy resources. The **Resource Policy Contributor role** includes most Azure Policy operations. **The owner has full rights**. Both **Contributor** and **Reader** have access to all read Azure Policy operations.

A **contributor** may trigger resource remediation but can't create or update definitions and assignments. **User Access Administrator** is necessary to grant the managed identity on **deployIfNotExists** or **modify** the assignment's necessary permissions.<br>

> [!NOTE]
> All Policy objects, including definitions, initiatives, and assignments, will be readable to all roles over its scope. For example, a Policy assignment scoped to an Azure subscription will be readable by all role holders at the subscription scope and below.

If none of the built-in roles have the permissions required, create a custom role.

Azure Policy operations can have a significant impact on your Azure environment. Only the minimum set of permissions necessary to perform a task should be assigned and these permissions should not be granted to users who do not need them.

> [!NOTE]
> The managed identity of a deployIfNotExists or modify policy assignment needs enough permissions to create or update targeted resources.

## Example: Role-Based Access Control (RBAC) vs. Azure Policy

:::image type="content" source="../media/az500-role-based-versus-policies-ee3f9164.png" alt-text="RBAC has roles, users, role definitions and role initiatives.":::
<br>

> [!IMPORTANT]
> RBAC and Polices in Azure play a vital role in a governance strategy. While different, they both work together to ensure organizational business rules are followed by ensuring proper access and resource creation guidelines are met.
