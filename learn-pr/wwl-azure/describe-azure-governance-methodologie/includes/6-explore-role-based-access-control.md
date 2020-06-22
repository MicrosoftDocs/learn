## Role-based access control (RBAC)

> [!div class="mx-imgBorder"]
> ![Users, apps, and user groups are shown using Azure Active Directory to access an Azure subscription with resource groups.](../media/role-based-access-control-diagram.png)

[Role-based access control](https://docs.microsoft.com/azure/role-based-access-control/overview?azure-portal=true) provides fine-grained access management for Azure resources, enabling you to grant users only the rights they need to perform their jobs. RBAC is provided at no additional cost to all Azure subscribers.

## Usage scenarios

Examples of when you might use RBAC include when you want to:

+ Allow one user to manage VMs in a subscription, and another user to manage virtual networks.
+ Allow a database administrator (DBA) group to manage SQL databases in a subscription.
+ Allow a user to manage all resources in a resource group, such as VMs, websites, and subnets.
+ Allow an application to access all resources in a resource group.

To view access permissions, access the **Access Control** (IAM) blade in the Azure portal. This blade, shows who has access to an area and their role. Using this same blade, you can also grant or remove access.

The following screenshot shows an example of the **Access Control** (IAM) blade for a resource group. In this example, *Alain Charon* has been assigned the Backup Operator role for this resource group.

![Screenshot of the access control role assignment blade. In the access control pane, settings and permissions for a user display.](../media/role-based-access-control-blade.png)

RBAC uses an *allow model*.  This means that when you are assigned a role, RBAC *allows* you to perform certain actions, such as read, write, or delete. Therefore, if one role assignment grants you read permissions to a resource group, and a different role assignment grants you write permissions to the same resource group, you will have write permissions on that resource group.


## Best practices

Here are some RBAC best practices:

+ Using RBAC, segregate duties within your team and grant only the amount of access to users that they need to perform their jobs. Instead of giving everybody unrestricted permissions in your Azure subscription or resources, allow only certain actions at a scope level.
+ When planning your access control strategy, grant users the lowest privilege level that they need to do their work.

