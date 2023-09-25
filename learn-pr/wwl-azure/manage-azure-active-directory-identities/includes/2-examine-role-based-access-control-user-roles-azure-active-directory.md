

Azure AD has a SaaS operational model and lacks support for computer objects and management capabilities via Group Policy settings. Therefore, the delegation model within Azure AD is considerably simpler than the same model in AD DS. There are several built-in roles in all three tiers, including Global Administrator, Billing Administrator, Service Administrator, User Administrator, and Password Administrator. Each role provides different levels of directory-wide permissions to its objects. By default, the Account Administrator of the subscription hosting the Azure AD instance is assigned as the Global Administrator, with full permissions to all objects in their directory instance. The Service Administrator, however, has more limited permissions and isn't the same as the Global Administrator by default.

In Azure AD, using the delegation model, you can delegate permissions to applications, allowing them to act on behalf of users and groups. The depth and breadth of these delegation capabilities vary based on the Azure AD edition. With Azure AD Free, you can assign applications to both users and groups. The Azure AD Premium P1 edition enhances this by offering more advanced assignment capabilities, such as dynamic group membership based on user attributes. The Premium P2 edition builds upon this by introducing features like self-service group management, where users can create and manage their own groups, and Privileged Identity Management (PIM), which is part of the suite of Identity Governance tools, allowing users to elevate their privileges temporarily.

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

> [!NOTE] 
> Tenant administrators and co-administrators can manage Azure AD by using the Azure portal because by default these accounts automatically are granted the Global Administrator role in the Active Directory instance that is associated with the subscription.

Within Azure AD, you can configure users with the following roles:

 -  **Global Administrator**. This role has access to all administrative features and settings. When you sign up for the Azure subscription, you become a Global Administrator. Only this role can assign administrative roles to other accounts.
 -  **Limited administrator**. When you select the Limited administrator role for the user, you can then select one or more of the following administrative roles (the list can vary based on applications that are using your Azure AD):
    
     -  **Password Administrator** can reset passwords for users and manage service requests.
     -  **Service Administrator** can manage service requests.
     -  **Billing Administrator** can manage billing information.
     -  **Exchange Administrator** can manage Exchange Online settings.
     -  **Skype for Business Administrator** can manage Skype for Business Online settings.
     -  **User Administrator** can manage user accounts and groups.
     -  **SharePoint Administrator** can manage SharePoint Online settings.
     -  **Compliance administrator** can manage compliance settings.
     -  **Security reader** can read security settings.
     -  **Security Administrator** can manage security settings.
     -  **Privileged role Administrator** can manage privileged roles.
     -  **Intune Administrator** can manage Intune settings.
     -  **Guest inviter** can invite guest users to the organization.
     -  **Conditional Access Administrator** can manage conditional access settings.
 -  **User**. This is a default role that doesn't provide any administrative rights.

These roles are applicable to management tools such as the Microsoft 365 and Intune portals, or the Azure AD module for Windows PowerShell cmdlets. When you’re using Privileged Identity Management, you can also configure the Security reader and Security administrator roles.
