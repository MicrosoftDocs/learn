To deploy the proof-of-concept environment, you must understand the permissions and roles that are necessary for a successful deployment.

## Overview of permissions in Azure Sentinel

Azure role-based access control (Azure RBAC) is the authorization system that manages access to Azure resources. It's built on Azure Resource Manager, which provides fine-grained access management of Azure resources.

Use Azure RBAC to create and assign roles in your SecOps team. Azure RBAC lets you grant appropriate access to Azure Sentinel. The different roles give you specific control over what users of Azure Sentinel can access and do.

> [!TIP]
> You can assign Azure RBAC roles:
> - Directly in the Azure Sentinel workspace
> - In a subscription
> - To the resource group that the workspace belongs to, which Azure Sentinel inherits

### Azure Sentinel-specific roles

The following are the three dedicated, built-in Azure Sentinel roles:

- **Reader**: This role can review data, incidents, workbooks, and other Azure Sentinel resources.
- **Responder**: This role has all the permissions of the Reader role. Plus, it can manage incidents by assigning or dismissing them.
- **Contributor**: This role has all the permissions of the Reader and Responder roles. Also, it can create and edit workbooks, analytics rules, and other Azure Sentinel resources. To deploy Azure Sentinel on your tenant, you need Contributor permissions for the subscription where the Azure Sentinel workspace is deployed.

All built-in Azure Sentinel roles grant read access to the data in your Azure Sentinel workspace. For best results, these roles should be assigned to the resource group that contains the Azure Sentinel workspace. The roles then apply to all the resources that deploy to support Azure Sentinel, if those resources are in the same resource group.

### Azure roles and Azure Monitor Log Analytics roles

In addition to Azure Sentinel-dedicated Azure RBAC roles, other Azure and Log Analytics Azure RBAC roles can grant a wider set of permissions. These roles include access to your Azure Sentinel workspace and other resources.

- Azure roles grant access across all your Azure resources. They include Log Analytics workspaces and Azure Sentinel resources:

  - Owner
  - Contributor
  - Reader

- Log Analytics roles grant access across all your Log Analytics workspaces:

  - Log Analytics Contributor
  - Log Analytics Reader

For example, a user who is assigned with the Azure Sentinel Reader and Azure Contributor (not Azure Sentinel Contributor) roles can edit data in Azure Sentinel. If you want to only grant permissions to Azure Sentinel, you should carefully remove the user's prior permissions. Make sure you don't break any needed permission role for another resource.

### Azure Sentinel roles and allowed actions

The following table summarizes the roles and allowed actions in Azure Sentinel.

|Roles|Create and run playbooks|Create and edit workbooks, analytic rules, and other Azure Sentinel resources|Manage incidents such as dismissing and assigning|View data incidents, workbooks, and other Azure Sentinel resources|
|---|---|---|---|---|
|Azure Sentinel Reader|No|No|No|Yes|
|Azure Sentinel Responder|No|No|Yes|Yes|
|Azure Sentinel Contributor|No|Yes|Yes|Yes|
|Azure Sentinel Contributor and Logic App Contributor|Yes|Yes|Yes|Yes|

## Custom roles and advanced Azure RBAC

If the built-in Azure roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals for management-group, subscription, and resource-group scopes.

> [!TIP]
> Applications and services use a *security identity* to access specific Azure resources. Think of it as a user identity (username and password or certificate) for an application. *Scope* is the set of resources to which the access applies.

Subscriptions that trust the same Azure AD directory can share custom roles between them. There's a limit of 5,000 custom roles per directory. Custom roles can be created by using the Azure portal, Azure PowerShell, Azure CLI, or the REST API.

> [!NOTE]
> For Azure Germany and Azure China 21Vianet, the limit is 2,000 custom roles.

In this unit, you learned about the built-in roles for Azure Sentinel users and what each role lets users do. After you understand the roles and permissions and how they map to your organization, you can confidently enable Azure Sentinel.
