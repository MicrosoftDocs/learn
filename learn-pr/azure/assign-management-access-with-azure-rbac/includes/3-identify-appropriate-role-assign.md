The person replacing the administrator needs to able to manage Azure resources created under that subscription among other things. You need to identify the appropriate role to assign to them.

In this unit, you'll look in detail at the essential aspects of RBAC and Azure AD. You'll explore the different scopes available to you. You will then identify what the right role would be for your scenario.

## Overview of role-based access control

RBAC allows control over who has access to which Azure resources, and what they can do with those resources. RBAC can be set all the way down to resources like the network interface card (NIC) inside an Azure virtual machine or a secret stored in an Azure Key Vault.

You can use RBAC to allow one user or set of users to access PaaS resources in a subscription, and allow another user or set of users access to IaaS resources. You can use RBAC to separate responsibility for different resources according to the specializations within your team. You could for example, give your organization's data scientists access to Azure Machine Learning and any associated resources such as an Azure SQL Database, or Blob storage within a dedicated machine learning resource group. This action would isolate these resources from other team members who don't have such skills.

You can create fine-grained permissions schemes for applications, so that a marketing web app only has access to the associated marketing database and storage account. For managers or team members higher up in the organization, you could give access to all resources in a resource group or even a subscription for management purposes and overview of billing and consumption.

RBAC is based on the principle of least permissions. Give users only the bare minimum of permissions needed to get their work done. RBAC has many built-in roles, and custom roles can also be created.

The default built-in roles are:

- **Owner**, which gives full access to all resources, including the ability to delegate access to other users.
- **Contributor**, which can create and manage Azure resources.
- **Reader**, which can only view existing Azure resources.

There's also a **User Access Administrator** role that allows for management of user access to Azure resources. The following diagram shows some best practices you apply to determine which roles should be given to which users.

![Best practices to determine which roles should be given to which users](../media/4-best-practices.png)

## Identify the right scope

Scope is important and establishes which resources should have a specific type of access applied. You might wish to make someone a Virtual Machine Reader, with the ability to view virtual machines, but only for a specific resource group. You can do this by specifying the scope of a given role. Scope can be set at a resource, resource group, subscription, or management group level.

By combining one of the default role types with a given resource, you can set incredibly tailored permissions on your Azure resources.

You can:

- set reader access on a virtual machine, group of virtual machines, or an API Management instance.
- give owner access to resource groups.
- give contributor access to a subscription. This access enables the role holder to create and manage every Azure resource in that subscription without being able to give access to other users.

## Azure AD role differences

Azure AD also has its own set of roles that are more concerned with users, passwords, and domains. These roles have different purposes. The *Global Administrator*, can manage access to administrative features in Azure AD. The *Global Administrator* can give admin roles to other users, and handle password reset for any user or administrator. By default, whoever signs up for the Azure Active Directory tenant automatically assumes this role.

The *User Administrator* can manage all aspects of users and groups including support tickets, monitoring service health, and changing passwords for certain classes of user. The *Billing Administrator* can make purchases, manage subscriptions and support tickets, and monitor service health.

## RBAC compared with Azure AD roles

The main difference between RBAC and AAD roles is the area they cover. RBAC handles Azure resources, while the other handles Azure AD resources (particularly users, groups, and domains). You can't create custom roles with Azure AD roles unlike you can with RBAC. Also, Azure AD has only one scope (directory tenant) while RBAC's scope covers management group, subscription, resource group, and resource. You can use different tools to administer either of them. AAD doesn't feature when building Azure Resource Manager (ARM) templates, for example, because of the heavy integration of RBAC with ARM.<!-- Not sure if that is really true -->

There's a key area of overlap. An AAD Global Administrator can elevate their access to manage all Azure subscriptions and management groups. This access gives them the RBAC User Access Administrator role for all subscriptions of their tenant. The RBAC User Access Administrator role enables the global administrator to give other users access to Azure resources. For your scenario, you need to give full RBAC management and billing privileges to a new manager, so you'll temporarily elevate your access to that of this RBAC User Access Administrator role. You must then grant the new manager the RBAC owner role, so that they can create and manage resources. You must also ensure that the scope is set at a subscription level so that they are able to do this for all resources in the subscription.
