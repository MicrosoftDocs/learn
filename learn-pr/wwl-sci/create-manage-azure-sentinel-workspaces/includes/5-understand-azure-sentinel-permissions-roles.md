Microsoft Sentinel uses Azure role-based access control (Azure RBAC) to provide built-in roles that can be assigned to users, groups, and services in Azure.

Use Azure RBAC to create and assign roles within your security operations team to grant appropriate access to Microsoft Sentinel. The different roles give you fine-grained control over what users of Microsoft Sentinel can see and do. Azure roles can be assigned in the Microsoft Sentinel workspace directly, or in a subscription or resource group that the workspace belongs to, which Microsoft Sentinel will inherit.

## Microsoft Sentinel-specific roles

All Microsoft Sentinel built-in roles grant read access to the data in your Microsoft Sentinel workspace:

- **Microsoft Sentinel Reader**: can view data, incidents, workbooks, and other Microsoft Sentinel resources.

- **Microsoft Sentinel Responder**: can, in addition to the above, manage incidents (assign, dismiss, etc.)

- **Microsoft Sentinel Contributor**: can, in addition to the above, create and edit workbooks, analytics rules, and other Microsoft Sentinel resources.

- **Microsoft Sentinel Automation Contributor**: allows Microsoft Sentinel to add playbooks to automation rules. It isn't meant for user accounts.

 
 For best results, these roles should be assigned to the resource group that contains the Microsoft Sentinel workspace. The roles then apply to all the resources that deploy to support Microsoft Sentinel, if those resources are in the same resource group.


## Additional roles and permissions

Users with particular job requirements may need to be assigned other roles or specific permissions in order to accomplish their tasks.

- Working with playbooks to automate responses to threats

  Microsoft Sentinel uses playbooks for automated threat response. Playbooks are built on Azure Logic Apps, and are a separate Azure resource. You might want to assign to specific members of your security operations team the ability to use Logic Apps for Security Orchestration, Automation, and Response (SOAR) operations. You can use the Logic App Contributor role to assign explicit permission for using playbooks.

- Giving Microsoft Sentinel permissions to run playbooks

  Microsoft Sentinel uses a special service account to run incident-trigger playbooks manually or to call them from automation rules. The use of this account (as opposed to your user account) increases the security level of the service.

  In order for an automation rule to run a playbook, this account must be granted explicit permissions to the resource group where the playbook resides. At that point, any automation rule will be able to run any playbook in that resource group. To grant these permissions to this service account, your account must have Owner permissions on the resource groups containing the playbooks.

- Connecting data sources to Microsoft Sentinel

  For a user to add data connectors, you must assign the user write permissions on the Microsoft Sentinel workspace. Also, note the required other permissions for each connector, as listed on the relevant connector page.

- Guest users assigning incidents

  If a guest user needs to be able to assign incidents, then in addition to the Microsoft Sentinel Responder role, the user will also need to be assigned the role of Directory Reader. This role isn't an Azure role but a Microsoft Entra role, and that regular (non-guest) users have this role assigned by default.

- Creating and deleting workbooks

  To create and delete a Microsoft Sentinel workbook, the user requires either the Microsoft Sentinel Contributor role or a lesser Microsoft Sentinel role plus the Azure Monitor role of Workbook Contributor. This role isn't necessary for using workbooks, but only for creating and deleting.


## Azure roles and Azure Monitor Log Analytics roles

In addition to Microsoft Sentinel-dedicated Azure RBAC roles, other Azure and Log Analytics Azure RBAC roles can grant a wider set of permissions. These roles include access to your Microsoft Sentinel workspace and other resources.

- Azure roles grant access across all your Azure resources. They include Log Analytics workspaces and Microsoft Sentinel resources:

  - Owner

  - Contributor

  - Reader

- Log Analytics roles grant access across all your Log Analytics workspaces:

  - Log Analytics Contributor

  - Log Analytics Reader

For example, a user who is assigned with the Microsoft Sentinel Reader and Azure Contributor (not Microsoft Sentinel Contributor) roles can edit data in Microsoft Sentinel. If you want to only grant permissions to Microsoft Sentinel, you should carefully remove the user's prior permissions. Make sure you don't break any needed permission role for another resource.

## Microsoft Sentinel roles and allowed actions

The following table summarizes the roles and allowed actions in Microsoft Sentinel.

| Roles| Create and run playbooks| Create and edit workbooks, analytic rules, and other Microsoft Sentinel resources| Manage incidents such as dismissing and assigning| View data incidents, workbooks, and other Microsoft Sentinel resources|
| :--- | :---: | :--- | :--- | :--- |
| Microsoft Sentinel Reader| No| No| No| Yes|
| Microsoft Sentinel Responder| No| No| Yes| Yes|
| Microsoft Sentinel Contributor| No| Yes| Yes| Yes|
| Microsoft Sentinel Contributor and Logic App Contributor| Yes| Yes| Yes| Yes|

## Custom roles and advanced Azure RBAC

If the built-in Azure roles don't meet the specific needs of your organization, you can create your own custom roles. Just like built-in roles, you can assign custom roles to users, groups, and service principals for management-group, subscription, and resource-group scopes.
