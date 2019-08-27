You're the Azure Active Directory (Azure AD) global administrator for a large organization. The administrator for the marketing department's Azure subscription recently left the organization. You now need to give management access for the relevant subscription to their successor in the marketing department. The newcomer can then manage all the Azure resources and billing information for the subscription.

Azure AD and Azure role-based access control (RBAC) are independent permission schemes. RBAC is for managing access to Azure resources like virtual machines (VMs) and key vaults at an incredibly granular level – for resources and allocated permissions. Azure AD administrator roles are for managing directory resources such as user accounts and passwords. Azure AD role assignments don't give access to Azure resources – and the other way around.

However, the global administrator for Azure AD can temporarily elevate permissions to the RBAC role of *User Access Administrator*. This action grants other members of the organization sufficient RBAC permissions to manage Azure resources, even at a subscription level. The User Access Administrator is assigned at root scope and can view all resources and assign access in any subscription or management group in that Azure AD directory.

Some typical use cases include:

 - To regain lost access to a given Azure subscription or management group.
  - To grant an administrator or another user access to a given Azure subscription or management group.
  - To view an organization's Azure subscriptions or management groups.
  - To give rights to an automation app, so it can access Azure subscriptions or management groups.

Although the two permission schemes are separate, there are many instances – particularly relating to employee churn – where the global AD administrator will need to elevate their permissions. The global AD administrator can then assign the User Access Administrator role to other members of the same organization. This process hands off the controlling and delegating access to Azure resources at a granular level to someone responsible for that task. Equally, on the security principle of least privilege, they should remove those elevated permissions for themselves when the User Access Administrator role has been successfully assigned.

   ![User Access Admin Elevated Privilege](../media/2-elevate-access.png)

Assigning the employee management access to a subscription can be done with the Azure portal. You use the 'Access management for Azure resources' toggle in the Azure Active Directory blade. <!--CE:Please sense check the following sentence. I'm not sure I understand the meaning of 'call' and 'call'.-->You could also use the Get-AzRoleAssignment and Remove-AzRoleAssignment for a user at the root scope – or call the REST API elevate Access call with a role assignment JSON object.