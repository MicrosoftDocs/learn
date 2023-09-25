
Just as groups in Active Directory Domain Services (AD DS) simplify permissions management, Azure AD groups streamline access management. When you enable directory synchronization, your on-premises AD DS groups can be synchronized to Azure AD. While the group membership remains consistent between AD DS and Azure AD, the individual members are mapped from on-premises user accounts to their corresponding Azure AD accounts. If directory synchronization isn't in place, group management is exclusively cloud-based.

In Azure AD, you can establish two primary types of groups:

 -  **Security**. A security group is designed to manage resource access. By assigning permissions to a security group, you can control access based on group membership. For instance, if you create a security group named **Sales**, you can grant this group access to a specific file share. Managing the **Sales** group membership then indirectly manages access to that file share. Contrary to some misconceptions, Azure AD security groups aren't mail-enabled.
 
 - **Microsoft 365**. A Microsoft 365 group facilitates access management for Microsoft 365 services, including Microsoft Teams, SharePoint, and Outlook. For example, if you establish a Microsoft 365 group named **Sales**, you can delegate permissions for this group to access a SharePoint site. Managing the group's membership then determines access to that site. By design, Microsoft 365 groups are mail-enabled, serving dual purposes as collaboration groups and email distribution lists.

To create a group in Azure, navigate to Azure Active Directory > Groups > New group on the Azure portal. Here, you can specify the group type, name, and description. You'll also choose whether it's a security group or a Microsoft 365 group. Remember, only Microsoft 365 groups are inherently mail-enabled.

#### Assign Membership

Membership for a cloud-based group can be **assigned** or **dynamic**. When you create a group with assigned membership, you need to add and remove group members manually. When you create a group with dynamic membership, members are based on a query of Azure AD objects. For example, dynamic membership can be based on a user’s department. You can create a membership rule based on a single attribute or an advanced membership rule where you can create complex queries based on multiple attributes.

When you create a group with dynamic membership, you need to select whether it’s for users or devices. Many Microsoft 365 features can use user-based groups. Intune uses device-based groups.

Groups from on-premises AD DS with dynamic membership don’t synchronize with Azure AD.