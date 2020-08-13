## Role-based access control (RBAC)

When you have multiple IT and engineering teams, how can you control what access they have to the resources in your cloud environment? It's a good security practice to grant users only the rights they need to perform their job, and only to the relevant resources. 

Instead of defining the detailed access requirements for each individual, and updating that when new resources are created, Azure allows you to control access using [Role-based access control](https://docs.microsoft.com/azure/role-based-access-control/overview?azure-portal=true). 

Azure comes with pre-defined common roles that someone in a technology team would perform, and an associated set of access permissions relevant to that role. You can assign individuals or groups to one or more roles, and they'll receive all of the associated access permissions. Role-based access control is then applied to a scope, which is a resource or set of resources that this access will apply to.  

> [!NOTE]
> Role-based access control (RBAC) is enforced on any action that is initiated against an Azure resource that passes through the Azure Resource Manager control plane. This consists of actions via the Azure Portal, Azure Cloud Shell, PowerShell and the Azure CLI. RBAC does not enforce access permissions at an application or data level, and application security must be handled by your application.

## Usage scenarios
Examples of when you might use RBAC include when you want to:

+ Allow one user to manage VMs in a subscription, and another user to manage virtual networks.
+ Allow a database administrator (DBA) group to manage SQL databases in a subscription.
+ Allow a user to manage all resources in a resource group, such as VMs, websites, and subnets.
+ Allow an application to access all resources in a resource group.

RBAC uses an *allow model*.  This means that when you are assigned a role, RBAC *allows* you to perform certain actions, such as read, write, or delete. Therefore, if one role assignment grants you read permissions to a resource group, and a different role assignment grants you write permissions to the same resource group, you will have write permissions on that resource group.

> [!NOTE]
> RBAC does not have to be applied to an individual person, or a group of people. Other special identity types (service principals and managed identities) are used by applications and services to access Azure resources and these too can be assigned a role with associated permissions. 

Tailwind Traders have the following teams with an interest in any technology environment:
+ IT Administrators - This team has ultimate ownership of technology assets, both on-premises and in the cloud, and requires full control of all resources. 
+ Backup & Disaster Recovery Team - This team is responsible for managing the health of regular backups and invoking any data or system recoveries.
+ Cost & Billing Team - People in this team track and report on technology-related spend and managed the organization's internal budgets. 
+ Security Operations Team - This team monitors and responds to any technology-related security incidents, and require ongoing access to log files and security alerts.

You have decided to configure RBAC as follows: 
<div style="background: yellow;">
TODO: 
Diagram of TWT IT teams with RBAC & Scopes.
</div>
  

## View and manage role-base access control
To view access permissions, access the **Access Control** (IAM) blade in the Azure portal. This blade shows who has access to that scope and their role. Using this same blade, you can also grant or remove access.

The following screenshot shows an example of the **Access Control** (IAM) blade for a resource group. In this example, *Alain Charon* has been assigned the Backup Operator role for this resource group.

![Screenshot of the access control role assignment blade. In the access control pane, settings and permissions for a user display.](../media/role-based-access-control-blade.png)



