Azure Active Directory (Azure AD) provides several ways to manage access to resources, applications, and tasks. With Azure AD groups, you can grant access and permissions to a group of users instead of each individual user. Limiting access to Azure AD resources to only those users who need access is one of the core security principles of Zero Trust.

Azure AD lets you use groups to manage access to applications, data, and resources. Resources can be:

 -  Part of the Azure AD organization, such as permissions to manage objects through roles in Azure AD
 -  External to the organization, such as for Software as a Service (SaaS) apps
 -  Azure services
 -  SharePoint sites
 -  On-premises resources

Some groups can't be managed in the Azure AD portal:

 -  Groups synced from on-premises Active Directory can be managed only in on-premises Active Directory.
 -  Distribution lists and mail-enabled security groups are managed only in Exchange admin center or Microsoft 365 admin center. You must sign in to the Exchange admin center or Microsoft 365 admin center to manage these groups.

## What to know before creating a group

There are **two group types** and **three group membership types**.

### **Group types**:

**Security**: Used to manage user and computer access to shared resources.

For example, you can create a security group so that all group members have the same set of security permissions. Members of a security group can include users, devices, other groups, and service principals, which define access policy and permissions. Owners of a security group can include users and service principals.

**Microsoft 365**: Provides collaboration opportunities by giving group members access to a shared mailbox, calendar, files, SharePoint sites, and more.

This option also lets you give people outside of your organization access to the group. Members of a Microsoft 365 group can only include users. Owners of a Microsoft 365 group can include users and service principals.

### Membership types:

 -  **Assigned**: Lets you add specific users as members of a group and have unique permissions.
 -  **Dynamic user**: Lets you use dynamic membership rules to automatically add and remove members. If a member's attributes change, the system looks at your dynamic group rules for the directory to see if the member meets the rule requirements (is added), or no longer meets the rules requirements (is removed).
 -  **Dynamic device**: Lets you use dynamic group rules to automatically add and remove devices. If a device's attributes change, the system looks at your dynamic group rules for the directory to see if the device meets the rule requirements (is added), or no longer meets the rules requirements (is removed).

> [!IMPORTANT]
> You can create a dynamic group for either devices or users but not for both. You can't create a device group based on the device owners' attributes. Device membership rules can only reference device attributions.
