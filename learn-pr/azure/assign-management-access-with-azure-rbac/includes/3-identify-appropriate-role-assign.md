You're the global administrator in Azure Active Directory (Azure AD) for a large organization. After the departure of the marketing manager, you need to give their successor full role-based access control (RBAC) management privileges for the department's subscription. The new manager also needs access to that subscription's billing information. Management of Azure resources and billing information fall within the remit of RBAC. In this unit, you'll look in detail at the essential aspects of RBAC and Azure AD, to determine the correct roles to assign.

At its core, RBAC allows incredibly granular control over who has access to which Azure resources – and what they can do with them.

RBAC is built on top of Azure Resource Manager, which is based on exposing and identifying all Azure resources for management and control. This process goes down to micro-resources like the Network Interface Card (NIC) inside an Azure Virtual Machine (VM) or the secret in an Azure Key Vault.

You use RBAC to allow one user – or set of users – to access PaaS resources in a subscription, and another user – or set of users – access to IaaS resources. You separate responsibility for different resources according to the specializations within your team. Another way is to give your organization's data scientists access to Azure Machine Learning and any associated resources – such as an Azure SQL DB or Blob storage within a dedicated machine learning resource group. This action would isolate these resources from other team members who don't have such skills.

You can create fine-grained permissions schemes for applications, so that the marketing web app only has access to the associated marketing database and storage account. For managers or team members higher up in the organization, you could give access to all resources in a resource group or even a subscription – for management purposes and an overview of billing and consumption.

RBAC is based on the principle of least permissions. Give users only the bare minimum of permissions needed to get their work done. RBAC has many built-in roles, and custom roles can also be created.

The foundational built-in roles are:

- **Owner** – gives full access to all resources, including the ability to delegate access to other users.
- **Contributor** – can create and manage Azure resources without the owner delegation right.
- **Reader** – can view existing Azure resources.

There's also a **User Access Administrator** role that allows for management of user access to Azure resources. The following diagram shows some best practices you apply to determine which roles should be given to which users.

   ![Best practices to determine which roles should be given to which users](../media/4-best-practices.png)

The concept of scope is also important and establishes which resources the access – for example, owner, contributor or reader – applies to. You might wish to make someone a Virtual Machine Reader, with the ability to view virtual machines, but only for a specific resource group. This outcome can be achieved by specifying the scope of a given role. Scope can be set at a resource, resource group, subscription, or management group level.

By combining one of the foundational role types with a given resource, you set incredibly granular permissions on your Azure resources.

You can:

- Set reader access on a VM, group of VMs, or an API Management instance.
- Give owner access to resource groups.
- Give contributor access to a subscription – this access enables the role holder to create and manage every Azure resource in that subscription without delegating access to other users.

Azure AD also has its own set of roles that are more concerned with users, passwords, and domains. Some core Azure AD roles include the *Global Administrator*, who can manage access to administrative features in Azure AD and any services, such as Office 365, that federate with AAD. The *Global Administrator* can give admin roles to other users, and handle password reset for any user or administrator. By default, whoever signs up for the Azure Active Directory tenant automatically assumes this role.

The *User Administrator* can manage all aspects of users and groups – including support tickets, monitoring service health, and changing passwords for certain classes of user. The *Billing Administrator* can make purchases, manage subscriptions and support tickets, and monitor service health.

The main difference between RBAC and AAD roles is the area of concern – one handles Azure resources, while the other handles AAD resources (particularly users, groups, and domains). AAD has a more focused set of objects so, unlike with RBAC, you can't create custom roles. Also, AAD has only one scope – that of the directory tenant – while RBAC's scope covers management group, subscription, resource group, and resource. You'll use different tools to administer either scheme. AAD doesn't feature when building Azure Resource Manager (ARM) templates, for example, because of the heavy integration of RBAC with ARM.

There's a key area of overlap. An AAD Global Administrator can elevate their access to manage all Azure subscriptions and management groups. This access gives them the RBAC User Access Administrator role for all subscriptions of their tenant. This role enables the global admin to grant other users access to Azure resources.

You need to give full RBAC management and billing privileges to a new manager, so you'll temporarily elevate your access to that of User Access Administrator. You'll look at this process in the next unit.