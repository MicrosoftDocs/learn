Implementing Azure Policy ensured that all our employees with Azure access are following our internal standards for creating resources, but we have a second issue we need to solve: how do we protect those resources once they're deployed? We have IT personnel who need to manage settings, developers who need to have read-only access, and administrators who need to be able to control them completely. Enter *Role-Based Access Control (RBAC)*.

RBAC provides fine-grained access management for Azure resources, allowing you to grant users the specific rights they need to perform their jobs. RBAC is considered a core service and is included with all subscription levels at no cost.

Using RBAC, you can:

- Allow one user to manage VMs in a subscription and another user to manage virtual networks.
- Allow a database administrator (DBA) group to manage SQL databases in a subscription.
- Allow a user to manage all resources in a resource group, such as VMs, websites, and virtual subnets.
- Allow an application to access all resources in a resource group.

To view access permissions, use the **Access control (IAM)** panel for the resource in the Azure portal. On this panel, you can determine who can access an area and their assigned role. Using this same panel, you can also grant or remove access.

:::image type="content" source="../media/5-resource-group-access-control.png" alt-text="Screenshot of Azure portal Access control - Role assignment pane showing a backup operator and billing reader roles assigned to different users.":::

### How RBAC defines access

RBAC uses an **allow model** for access. When you're assigned to a role, RBAC *allows* you to perform specific actions, such as read, write, or delete. Therefore, if one role assignment grants you read permissions to a resource group, and a different role assignment grants you write permissions to the same resource group, you will have both read and write permissions on that resource group.

## Best Practices for RBAC

Here are some best practices you should use when setting up resources:

- Segregate duties within your team and grant users only the amount of access that they need to perform their jobs. Instead of giving everybody unrestricted permissions in your Azure subscription or resources, allow only specific actions at a particular scope.
- When planning your access control strategy, grant users the lowest privilege level that they need to do their work.
- Use **Resource Locks** to ensure critical resources aren't modified or deleted (as you'll learn in the next unit).
