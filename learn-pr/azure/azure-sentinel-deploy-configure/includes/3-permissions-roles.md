As the Contoso administrator who is tasked with deploying a POC environment for Azure Sentinel, you must understand the permissions and roles that are necessary for a successful deployment.

## Overview of permissions in Azure Sentinel

Azure role-based access control (Azure RBAC) is the authorization system for managing access to Azure resources, and it's built on Azure Resource Manager, which provides fine-grained access management of Azure resources.

Use Azure RBAC to create and assign roles in your SecOps team to grant appropriate access to Azure Sentinel. The different roles give you fine-grained control over what users of Azure Sentinel can access and do.

> [!TIP]
> You can assign Azure RBAC roles directly in the Azure Sentinel workspace, in a subscription, or to the resource group that the workspace belongs to, which Azure Sentinel inherits.

### Azure Sentinel-specific roles

The following are the three dedicated, built-in Azure Sentinel roles:

- The Azure Sentinel Reader role can review data, incidents, workbooks, and other Azure Sentinel resources.

- The Azure Sentinel Responder role has all the permissions of the Azure Sentinel Reader role, and it can manage incidents, such as by assigning or dismissing them.

- The Azure Sentinel Contributor role has all the permissions of the Azure Sentinel Reader and Azure Sentinel Responder roles, and it can create and edit workbooks, analytics rules, and other Azure Sentinel resources. To deploy Azure Sentinel on your tenant, you need Contributor permissions for the subscription where the Azure Sentinel workspace is deployed.

    > [!TIP]
    > All built-in Azure Sentinel roles grant read access to the data in your Azure Sentinel workspace.

    > [!NOTE]
    > For best results, these roles should be assigned to the resource group that contains the Azure Sentinel workspace. The roles then apply to all the resources that deploy to support Azure Sentinel if those resources are in the same resource group.

### Azure roles and Log Analytics roles

In addition to Azure Sentinel-dedicated Azure RBAC roles, other Azure and Log Analytics Azure RBAC roles can grant a wider set of permissions that include access to your Azure Sentinel workspace and other resources:

- Azure roles grant access across all your Azure resources, including Log Analytics workspaces and Azure Sentinel resources:

  - Owner
  - Contributor
  - Reader

- Log Analytics roles grant access across all your Log Analytics workspaces:

  - Log Analytics Contributor
  - Log Analytics Reader

For example, a user who is assigned with the Azure Sentinel Reader and Azure Contributor (not Azure Sentinel Contributor) roles can edit data in Azure Sentinel, although they only have Sentinel Reader permissions. If you want to grant permissions to Azure Sentinel only, you should carefully remove the user's prior permissions, making sure you don't break any needed permission role for another resource.

### Azure Sentinel roles and allowed actions

The following table summarizes the roles and allowed actions in Azure Sentinel.

|Roles|Create and run playbooks|Create and edit workbooks, analytic rules, and other Azure Sentinel resources|Manage incidents such as dismissing and assigning|View data incidents, workbooks, and other Azure Sentinel resources|
|---|---|---|---|---|
|Azure Sentinel Reader|No|No|No|Yes|
|Azure Sentinel Responder|No|No|Yes|Yes|
|Azure Sentinel Contributor|No|Yes|Yes|Yes|
|Azure Sentinel Contributor and Logic App Contributor|Yes|Yes|Yes|Yes|

## Custom roles and advanced Azure RBAC

If the built-in Azure roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals at management-group, subscription, and resource-group scopes.

> [!TIP]
> Applications and services use a *security identity* to access specific Azure resources. Think of it as a user identity (username and password or certificate) for an application. *Scope* is the set of resources to which the access applies.

Subscriptions that trust the same Azure AD directory can share custom roles between them. There's a limit of 5,000 custom roles per directory. Custom roles can be created by using the Azure portal, Azure PowerShell, Azure CLI, or the REST API.

> [!NOTE]
> For Azure Germany and Azure China 21Vianet, the limit is 2,000 custom roles.

In this unit, you learned about the built-in roles for Azure Sentinel users and what each role enables users to do. After you understand the roles and permissions granted and how they can map to your organization, you can confidently enable Azure Sentinel.
