To deploy the proof-of-concept environment, you must understand the permissions and roles that are necessary for a successful deployment.

## Overview of permissions in Microsoft Sentinel

Azure role-based access control (Azure RBAC) is the authorization system that manages access to Azure resources. It's built on Azure Resource Manager, which provides fine-grained access management of Azure resources.

Use Azure RBAC to create and assign roles in your SecOps team. Azure RBAC lets you grant appropriate access to Microsoft Sentinel. The different roles give you specific control over what users of Microsoft Sentinel can access and do.

You can assign Azure RBAC roles:

- Directly in the Microsoft Sentinel workspace
- In a subscription
- To the resource group that the workspace belongs to, which Microsoft Sentinel inherits

### Microsoft Sentinel-specific roles

The following are dedicated, built-in Microsoft Sentinel roles:

- **Reader**: This role can review data, incidents, workbooks, and other Microsoft Sentinel resources.
- **Responder**: This role has all the permissions of the Reader role. Plus, it can manage incidents by assigning or dismissing them.
- **Contributor**: This role has all the permissions of the Reader and Responder roles. Also, it can create and edit workbooks, analytics rules, and other Microsoft Sentinel resources. To deploy Microsoft Sentinel on your tenant, you need Contributor permissions for the subscription where the Microsoft Sentinel workspace is deployed.
- **Playbook Operator**: This role can list, view, and manually run playbooks.
- **Automation Contributor**: This role allows Microsoft Sentinel to add playbooks to automation rules. It isn't meant for user accounts.

All built-in Microsoft Sentinel roles grant read access to the data in your Microsoft Sentinel workspace. For best results, these roles should be assigned to the resource group that contains the Microsoft Sentinel workspace. The roles then apply to all the resources that deploy to support Microsoft Sentinel, if those resources are in the same resource group.

### Azure roles and Azure Monitor Log Analytics roles

In addition to Microsoft Sentinel-dedicated Azure RBAC roles, other Azure and Log Analytics Azure RBAC roles can grant a wider set of permissions. These roles include access to your Microsoft Sentinel workspace and other resources.

- Azure roles grant access across all your Azure resources. They include Log Analytics workspaces and Microsoft Sentinel resources:

  - Owner
  - Contributor
  - Reader
  - Template Spec Contributor

- Log Analytics roles grant access across all your Log Analytics workspaces:

  - Log Analytics Contributor
  - Log Analytics Reader

For example, a user who is assigned with the Microsoft Sentinel Reader and Azure Contributor (not Microsoft Sentinel Contributor) roles can edit data in Microsoft Sentinel. If you want to only grant permissions to Microsoft Sentinel, you should carefully remove the user's prior permissions. Make sure you don't break any needed permission role for another resource.

### Microsoft Sentinel roles and allowed actions

The following table summarizes the roles and allowed actions in Microsoft Sentinel.

|Roles|View and run playbooks|Create and edit playbooks|Create and edit analytic rules, workbooks, and other Microsoft Sentinel resources|Manage incidents such as dismiss and assign|View data incidents, workbooks, and other Microsoft Sentinel resources| Install and manage content from the content hub|
|---|---|---|---|---|---|---|
|Microsoft Sentinel Reader|No|No|No|No|Yes|No|
|Microsoft Sentinel Responder|No|No|No|Yes|Yes|No|
|Microsoft Sentinel Contributor|No|No|Yes|Yes|Yes|No|
|Microsoft Sentinel Playbook Operator|Yes|No|No|No|No|No|
|Logic App Contributor|Yes|Yes|No|No|No|No|
|Template Spec Contributor|No|No|No|No|No|Yes|

## Custom roles and advanced Azure RBAC

If the built-in Azure roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals for management-group, subscription, and resource-group scopes.

> [!TIP]
> Applications and services use a *security identity* to access specific Azure resources. Think of it as a user identity (username and password or certificate) for an application. *Scope* is the set of resources to which the access applies.

Subscriptions that trust the same Azure AD directory can share custom roles between them. There's a limit of 5,000 custom roles per directory. Custom roles can be created by using the Azure portal, Azure PowerShell, Azure CLI, or the REST API.

> [!NOTE]
> For Azure Germany and Azure China 21Vianet, the limit is 2,000 custom roles.

In this unit, you learned about the built-in roles for Microsoft Sentinel users and what each role lets users do. After you understand the roles and permissions and how they map to your organization, you can confidently enable Microsoft Sentinel.
