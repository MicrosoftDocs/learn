When you have multiple IT and engineering teams, how can you control what access they have to the resources in your cloud environment? It's a good security practice to grant users only the rights they need to perform their job, and only to the relevant resources. 

Instead of defining the detailed access requirements for each individual, and then updating access requirements when new resources are created, Azure enables you to control access through [Azure role-based access control](https://docs.microsoft.com/azure/role-based-access-control/overview?azure-portal=true) (Azure RBAC).

Azure provides built-in roles that describe common access rules for cloud resources. Each role has an associated set of access permissions that relate to that role. When you assign individuals or groups to one or more roles, they receive all of the associated access permissions. Role-based access control is then applied to a _scope_, which is a resource or set of resources that this access applies to.

## When should I use Azure RBAC?

Use Azure RBAC when you need to:

* Allow one user to manage VMs in a subscription, and another user to manage virtual networks.
* Allow a database administrator (DBA) group to manage SQL databases in a subscription.
* Allow a user to manage all resources in a resource group, such as VMs, websites, and subnets.
* Allow an application to access all resources in a resource group.

These are just a few examples. You'll find the complete list of built-in roles at the end of this module.

## How is Azure RBAC enforced?

Azure RBAC is enforced on any action that's initiated against an Azure resource that passes through Azure Resource Manager. Azure Resource Manager is a management service that provides a way to organize and secure your cloud resources.

You typically access the Azure Resource Manager from the Azure portal, Azure Cloud Shell, Azure PowerShell, and the Azure CLI. Azure RBAC does not enforce access permissions at the application or data level. Application security must be handled by your application.

RBAC uses an *allow model*. This means that when you are assigned a role, RBAC *allows* you to perform certain actions, such as read, write, or delete. Therefore, if one role assignment grants you read permissions to a resource group, and a different role assignment grants you write permissions to the same resource group, you have both read and write permissions on that resource group.

## Who does Azure RBAC apply to?

You can apply Azure RBAC to an individual person or to a group. You can also apply Azure RBAC to other special identity types such as service principals and managed identities. These identity types are used by applications and services to automate access to Azure resources.

Tailwind Traders has the following teams with an interest in some part of their overall IT environment:

* IT Administrators

    This team has ultimate ownership of technology assets, both on-premises and in the cloud, and requires full control of all resources.
* Backup and Disaster Recovery

    This team is responsible for managing the health of regular backups and invoking any data or system recoveries.
* Cost and Billing

    People in this team track and report on technology-related spend and manage the organization's internal budgets.
* Security Operations

    This team monitors and responds to any technology-related security incidents, and require ongoing access to log files and security alerts.

You have decided to configure RBAC as follows:
<div style="background: yellow;">
TODO: 
Diagram of TWT IT teams with RBAC & Scopes.
</div>

## How do I manage Azure RBAC permissions?

You manage access permissions on the **Access control (IAM)** blade in the Azure portal. This blade shows who has access to what scope and what roles apply. You can also grant or remove access from this blade.

The following screenshot shows an example of the **Access control (IAM)** blade for a resource group. In this example, Alain Charon has been assigned the **Backup Operator** role for this resource group.

:::image type="content" source="../media/role-based-access-control-blade.png" alt-text="A screenshot that shows the access control role assignment blade. In the access control pane, settings and permissions for a user are shown.":::
