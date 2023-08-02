
Like using groups to simplify permissions management in AD DS, you can use groups in Azure AD to simplify management. If you implement directory synchronization, groups in your on-premises AD DS can synchronize with Azure AD. A synchronized group in Azure AD has the same membership as the group in AD DS, but the individual members are translated from on-premises user accounts to user accounts in Azure AD. Alternatively, if you don’t implement directory synchronization, then groups and their membership are managed entirely in the cloud.

You can create two group types in Azure AD:

 -  **Security**. A security group is used to manage access to resources. You can assign permissions to a security group, and then manage access to the resource by managing group membership. For example, you can create a security group named **Sales** and assign permissions to the **Sales** group to access a file share. You can then manage access to the file share by managing membership in the **Sales** group. Security groups can be mail-enabled, which means they can be used as distribution groups for email.
 
 - **Microsoft 365**. A Microsoft 365 group is used to manage access to Microsoft 365 services, such as Microsoft Teams, SharePoint, and Outlook. You can assign permissions to a Microsoft 365 group, and then manage access to the resource by managing group membership. For example, you can create a Microsoft 365 group named **Sales** and assign permissions to the **Sales** group to access a SharePoint site. You can then manage access to the SharePoint site by managing membership in the **Sales** group. Microsoft 365 groups are always mail-enabled, which means they can be used as distribution groups for email.

On the Azure portal, you can create a group by selecting **Azure Active Directory** > **Groups** > **New group**. You can then select the group type, and then enter a name and description for the group. You can also select whether the group is a security group or a Microsoft 365 group. If you select **Security**, you can also select whether the group is mail-enabled. If you select **Microsoft 365**, the group is always mail-enabled.

#### Assign Membership

Membership for a cloud-based group can be **assigned** or **dynamic**. When you create a group with assigned membership, you need to add and remove group members manually. When you create a group with dynamic membership, members are based on a query of Azure AD objects. For example, dynamic membership can be based on a user’s department. You can create a membership rule based on a single attribute or an advanced membership rule where you can create complex queries based on multiple attributes.

When you create a group with dynamic membership, you need to select whether it’s for users or devices. Many Microsoft 365 features can use user-based groups. Intune uses device-based groups.

Groups from on-premises AD DS with dynamic membership don’t synchronize with Azure AD.