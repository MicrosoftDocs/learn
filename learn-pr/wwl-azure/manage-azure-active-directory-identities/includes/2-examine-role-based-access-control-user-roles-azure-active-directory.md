
Azure AD has a SaaS operational model and lacks support for computer objects and management capabilities via Group Policy settings. Therefore, the delegation model within Azure AD is considerably simpler than the same model in AD DS. There are several built-in roles in all three tiers, including Global Administrator, Billing Administrator, Service Administrator, User Administrator, and Password Administrator. Each role provides different levels of directory-wide permissions to its objects. By default, the Service Administrator of the subscription hosting the Azure AD instance is its Global Administrator, with full permissions to all objects in their directory instance.

Using the delegation model, you can grant permissions to applications registered in an Azure AD tenant to its users and groups, and manage the delegate group. The specifics of these capabilities depend on the Azure AD tier. For example, in Azure AD Free, you can assign applications to individual users. With the Azure AD Basic tier, you can also create such assignments based on the group membership. The Premium tier further extends this functionality by offering delegated and self-service group management, thereby allowing users to create and manage their own groups and request membership in groups created by others.

Azure AD users can access Azure AD applications by using the web-based portal, referred to as My Apps, at *https://myapps.microsoft.com*. This portal automatically presents to the users all applications for which they have permissions. Another benefit of using this approach is the support for SSO. When starting an individual application from its interface, authentication happens automatically once users sign in to the portal.

### Azure delegation model and role-based access control

The delegation model applies to the graphical interface that is available in the Azure portal. The Azure portal offers a much more flexible and precise way of restricting management of Azure resources by implementing RBAC. This mechanism relies on three built-in roles: owner, contributor, and reader. Each of these roles performs a specific set of actions on Azure resources that are exposed via the Azure portal—resources such as websites or SQL databases. You can grant the intended access by associating an Azure AD object such as a user, group, or service principal with a role and a resource that appears in the Azure portal.

Azure AD doesn't include the OU class, which means that you can't arrange its objects in a hierarchy of custom containers, which frequently are used in on-premises AD DS deployments. This isn’t a significant shortcoming, because OUs in AD DS are used primarily for Group Policy scoping and delegation. Instead, you can accomplish equivalent arrangements by organizing objects based on their attribute values or group membership.

### User roles in Azure AD

You can use three types of accounts with Azure AD:

 -  An organizational account that the tenant administrator or a co-administrator creates within the default Azure directory or any custom Azure directory—for example, user@domain1.onmicrosoft.com.
 -  An account that references an organizational account you create in other Azure AD instances—for example, user@domain2.onmicrosoft.com.
 -  An account that references a Microsoft account—for example, user@outlook.com.

You use the tenant administrator account to sign up for a new trial or paid subscription. This account can be a Microsoft account or an existing organizational account. To avoid mixing authentication methods, we recommend that you use organizational accounts to manage your Azure AD tenant.

You can only manage Azure AD if you're a Global Administrator of the Azure AD instance. You can only sign in to an Azure portal if you’re the tenant administrator or if the tenant administrator has configured an organizational account to be a co-administrator. 

> [!Note] Tenant administrators and co-administrators can manage Azure AD by using the Azure portal because by default these accounts automatically are granted the Global Administrator role in the Active Directory instance that is associated with the subscription.

Within Azure AD, you can configure users with the following roles:

 -  **Global Administrator**. This role has access to all administrative features and settings. When you sign up for the Azure subscription, you become a Global Administrator. Only this role can assign administrative roles to other accounts.
 -  **Limited administrator**. When you select the Limited administrator role for the user, you can then select one or more of the following administrative roles (the list can vary based on applications that are using your Azure AD):
    
     -  Password administrator
     -  Service administrator
     -  Billing administrator
     -  Exchange administrator
     -  Skype for Business administrator
     -  User administrator
     -  SharePoint administrator
     -  Compliance administrator
     -  Security reader
     -  Security administrator
     -  Privileged role administrator
     -  Intune Service administrator
     -  Guest inviter
     -  Conditional Access Administrator
 -  **User**. This is a default role that doesn't provide any administrative rights.

These roles are applicable to management tools such as the Microsoft 365 and Intune portals, or the Azure AD module for Windows PowerShell cmdlets. When you’re using Privileged Identity Management, you can also configure the Security reader and Security administrator roles.
