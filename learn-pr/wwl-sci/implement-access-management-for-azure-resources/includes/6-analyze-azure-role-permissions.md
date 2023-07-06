
What is a permission? The dictionary definition of permission is the \*\*consent or authorization to perform a specific action." In Azure Active Directory (Azure AD), you've permissions for each of the operations you're able to do. Permission can range from viewing your settings, to be able to change your setting. Then move on to granting permission to add or remove users and beyond. There are two primary places where permission can be assigned, at a user or group level. However, they all pass down to the user at the final point. When dealing with users, you've both a member-user and a guest-user. The default permissions for the guest-user are slightly less than the member.

### What are a sample of the default permissions for users?

| **Member Users**                             | **Guest Users**                                           |
| -------------------------------------------- | --------------------------------------------------------- |
| Enumerate list of users and their contacts   | Read own properties                                       |
| Invite guest users                           | Invite guest users                                        |
| Can create Security and Microsoft 365 Groups | Can search for non-hidden groups by name                  |
| Register new applications                    | Read properties of registered and enterprise applications |

\[!Note\] This is just a small subset, to show differences. If you want a full list of the [Default User Permissions](/azure/active-directory/fundamentals/users-default-permissions)

### Controlling permissions - add and restrict

|                                                                           **User settings**                                                                            |                                                                                  **Roles and administrators**                                                                                  |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| :::image type="content" source="../media/permissions-users-beeebadb.png" alt-text="Screenshot of the Azure AD user settings, where permissions can be restricted.":::  | :::image type="content" source="../media/permissions-role-admin-7c1f0c55.png" alt-text="Screenshot of the Roles and administrators screen in Azure AD. List of roles that can be applied.":::  |

You can use the **User Settings** inside of Azure AD – Manage menu to restrict or control the default permissions of the default users. Or you can use Roles and administrators to add new permissions onto your users and group. Always use the concept of Least Privilege and make sure the users only have the rights they need. In User settings you can restrict the user's ability to:

 -  Register applications
 -  Access the Azure portal
 -  Block LinkedIn connections
 -  Manage settings for external collaboration

By adding roles to a given user account or group, you can add permissions on to member users, guest users, and service principals. Adding roles gives permissions to perform specific activities. Actions are limited, which allows the rule of least privilege.

### Exploring available permissions

:::image type="content" source="../media/permissions-attribute-reader-e2092c40.png" alt-text="Screenshot of the Attribute definition reader.  You can see which permissions a built-in role grants.":::


You only want to grant the permissions a user needs. So be careful to know what all permissions are granted when you assign a role. you can see the list of permissions in the **Attribute definition reader**. To open it, launch Azure AD, then open the **Roles and administrators** screen. Next select a role, and open its description page from the ellipsis (...) menu. Depending on the role you chose, you'll see a large number of permissions or possibly a small number. Two sets of permissions:

 -  Role permissions
 -  Guest and service principal basic read permissions
