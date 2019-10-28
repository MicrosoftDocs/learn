Azure Role-Based Access Control (RBAC) gives you fine-grained access management controls for all your resources in Azure. You can make use of RBAC and its three built-in roles for Azure Site Recovery to restrict what people in your company can do.

After implementing and testing your recovery plan within Azure, you wish to ensure that the areas of the business who need access to support and configure Site Recovery have the required access. You wish to assign permissions to those teams as a group and then apply a more granular permission to individuals within those teams.

In this unit, you'll see how to use RBAC to give teams, and specific people, restricted access to the abilities of Azure Site Recovery.

## Role-based access control

![A diagram showing roles with different levels of access, to different levels of resources.](../media/6-rbac-least-privilege.png)

Using RBAC allows you as the administrator of the system to segregate duties, with a team or to individuals, to perform a task. Rather than granting everybody full permissions to an Azure subscription that would be insecure, only the permissions to perform the task needed should be granted. Best practice states that the least privilege should be assigned for a person, or group involved, to perform the task they need.

### How RBAC works

To control access to resource using RBAC, **role assignments** must be created. Permissions are enforced using role assignments and are made up of three elements, a security principal, role definition, and a scope.

### Security principal

A security principal is the Azure object that represents the user, group, service principal, or managed identity that is requesting access to a resource.

- **User**: an individual who has a profile within the Azure Active Directory.
- **Group**: an entity that can be assigned to multiple users at the same time, when a role is assigned to the group, all users contained in that group now have the role.
- **Service Principal**: a security identity used by applications or services to access resources across Azure.
- **Managed Identity**: an identity held with the Azure Active Directory that is automatically managed by Azure. These identities are normally used for cloud applications to manage credentials for automatic authentication to Azure services.

### Role definitions

A Role Definition is a collection of permissions, a role definition lists the operations that can be performed such as read or write to a resource. Roles can be assigned at both a high level such as **owner that has full access to all resources, or at a lower level such as power-on permission to a virtual machine.

There are several built-in roles in Azure that are below, although extra roles can be created to suit individual organizations:

- **Owner**: full access to all resources including the right to delegate access to others
- **Contributor**:  create and manage all types of Azure resource but can't grant access to others
- **Reader**: can view existing Azure resources
- **User Access Administrator**: the ability to manage user access to Azure resources

### Scope

![A diagram showing how the levels that can be scoped in an Azure account, from the top-level Management Group, through Subscriptions, to Resource Groups, and at the lowest level a specific resource like a VM or database.](../media/6-rbac-scope.png)

The scope is the selection or set of resources that the access created in the role section. The scope of a permission can be set at multiple hierarchical levels to further restrict the permission. In that hierarchy, a parent/child relationship comes in to play, as in, if a permission is assigned to a parent object, all child objects of that parent inherit that permission also. The hierarchy is:

- Management group
    - Subscription
        - Resource group
            - Specific resource, for example an Azure VM

### Azure Site Recovery built-in roles

RBAC has three built-in Azure Site Recovery roles to control the management of Site Recovery tasks:

- **Site Recovery Contributor**: has all the permissions required to manage Azure Site Recover operations in a Recovery Services Vault. The role is best suited to disaster recovery administrators who enable and manage DR for your organization.
- **Site Recovery Operator**: has permissions to execute and manage fail over and failback operations, however this role doesn't have permission to administer replication, create or delete vaults, or assign access rights to other users. It's best suited for administrators who need to fail over or failback the infrastructure when required.
- **Site Recovery Reader**: has permissions to view all Site Recovery specific management operations, it's best suited to someone who is asked to monitor the operational environment, and who acts on failures or issues with the Site Recovery protection.

For new virtual machines that need to be protected the permissions that are required are as follows. A custom role could be created that had these permissions pre-assigned to it to ease administration if necessary.

- Permission to create a virtual machine in the selected resource group
- Permission to create a virtual machine in the selected virtual network
- Permission to write to the selected storage account
