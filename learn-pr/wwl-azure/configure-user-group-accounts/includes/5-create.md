Azure AD allows you to define two different types of groups.

 -  **Security groups**. Security groups are used to manage member and computer access to shared resources for a group of users. For example, you can create a security group for a specific security policy. By doing it this way, you can give a set of permissions to all the members at once, instead of having to add permissions to each member individually. This option requires an Azure AD administrator.
 -  **Microsoft 365 groups**. Microsoft 365 groups provide collaboration opportunities by giving members access to a shared mailbox, calendar, files, SharePoint site, and more. You can give people outside of your organization access to the group. Both users and admins can use Microsoft 365 groups.

:::image type="content" source="../media/group-accounts-378b3e22.png" alt-text="Screenshot of the Users and Groups page.":::


## Adding members to groups

There are different ways you can assign access rights:

 -  **Assigned**. Lets you add specific users to be members of this group and to have unique permissions.
 -  **Dynamic User**. Lets you use dynamic membership rules to automatically add and remove members. When a member's attributes change, Azure reviews the dynamic group rules for the directory. If the member meets the rule requirements, they're added. If the member no longer meets the rules requirements, they're removed.
 -  **Dynamic Device (Security groups only)**. Lets you use dynamic group rules to automatically add and remove devices. If a device's attributes change, Azure reviews the dynamic group rules for the directory. If the device meets the rule requirements, they're added. If the device no longer meets the rules requirements, they're removed.

> [!NOTE]
> Have you thought about which groups you need to create? Would you use directly assigned or dynamically assigned membership?
