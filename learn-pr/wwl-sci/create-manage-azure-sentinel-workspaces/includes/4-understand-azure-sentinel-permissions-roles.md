Azure role-based access control (Azure RBAC) is the authorization system that manages access to Azure resources. It's built on Azure Resource Manager, which provides fine-grained access management of Azure resources.

Use Azure RBAC to create and assign roles in your SecOps team. Azure RBAC lets you grant appropriate access to Azure Sentinel. The different roles give you specific control over what users of Azure Sentinel can access and do.

## Azure Sentinel-specific roles

The following are the three dedicated, built-in Azure Sentinel roles:

- **Reader**: This role can review data, incidents, workbooks, and other Azure Sentinel resources.

- **Responder**: This role has all the permissions of the Reader role. Plus, it can manage incidents by assigning or dismissing them.

- **Contributor**: This role has all the permissions of the Reader and Responder roles. Also, it can create and edit workbooks, analytics rules, and other Azure Sentinel resources. To deploy Azure Sentinel on your tenant, you need Contributor permissions for the subscription where the Azure Sentinel workspace is deployed.

All built-in Azure Sentinel roles grant read access to the data in your Azure Sentinel workspace. For best results, these roles should be assigned to the resource group that contains the Azure Sentinel workspace. The roles then apply to all the resources that deploy to support Azure Sentinel, if those resources are in the same resource group.

## Azure roles and Azure Monitor Log Analytics roles

In addition to Azure Sentinel-dedicated Azure RBAC roles, other Azure and Log Analytics Azure RBAC roles can grant a wider set of permissions. These roles include access to your Azure Sentinel workspace and other resources.

- Azure roles grant access across all your Azure resources. They include Log Analytics workspaces and Azure Sentinel resources:

  - Owner

  - Contributor

  - Reader

- Log Analytics roles grant access across all your Log Analytics workspaces:

  - Log Analytics Contributor

  - Log Analytics Reader

For example, a user who is assigned with the Azure Sentinel Reader and Azure Contributor (not Azure Sentinel Contributor) roles can edit data in Azure Sentinel. If you want to only grant permissions to Azure Sentinel, you should carefully remove the user's prior permissions. Make sure you don't break any needed permission role for another resource.

## Azure Sentinel roles and allowed actions

The following table summarizes the roles and allowed actions in Azure Sentinel.

| Roles| Create and run playbooks| Create and edit workbooks, analytic rules, and other Azure Sentinel resources| Manage incidents such as dismissing and assigning| View data incidents, workbooks, and other Azure Sentinel resources|
| :--- | :---: | :--- | :--- | :--- |
| Azure Sentinel Reader| No| No| No| Yes|
| Azure Sentinel Responder| No| No| Yes| Yes|
| Azure Sentinel Contributor| No| Yes| Yes| Yes|
| Azure Sentinel Contributor and Logic App Contributor| Yes| Yes| Yes| Yes|

## Custom roles and advanced Azure RBAC

If the built-in Azure roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals for management-group, subscription, and resource-group scopes.

