A Microsoft Entra group helps organize users, which makes it easier to manage permissions. Using groups lets the resource owner (or Microsoft Entra directory owner), assign a set of access permissions to all the group members instead of having to provide the rights one by one. Groups allow you to define a security boundary, then add and remove specific users to grant or deny access with a minimum amount of effort. Even better, Microsoft Entra ID supports the ability to define membership based on rules, such as what department a user works in or the job title they have.

Microsoft Entra ID allows you to define two different types of groups.

1. **Security groups**: These are the most common, and are used to manage member and computer access to shared resources for a group of users. For example, you can create a security group for a specific security policy. By doing it this way, you can give a set of permissions to all the members at once instead of having to add permissions to each member individually. This option requires a Microsoft Entra administrator.

1. **Microsoft 365 groups**: These groups provide collaboration opportunities by giving members access to a shared mailbox, calendar, files, SharePoint site, and more. This option also lets you give people outside of your organization access to the group. This option is available to users as well as admins.

## View available groups

You can view all groups by selecting **Groups** under the **Manage** section from the Microsoft Entra dashboard. A new Microsoft Entra ID install won't have any groups defined.

![Screenshot that depicts all the existing groups.](../media/M1-Groups1.png)

<a name='add-groups-to-azure-ad'></a>

## Add groups to Microsoft Entra ID

The same options we saw with users are available to create groups in Microsoft Entra ID. The Azure portal is the easiest way to create groups. You must select the group type (Security or Microsoft 365), assign a unique group name, description and a *membership type*.

![Screenshot of the Create Group feature in the Azure portal.](../media/4-add-group-portal.png)

The membership type field can be one of three values:

1. **Assigned (static)**. The group will contain specific users or groups that you select.

1. **Dynamic user**. You can create rules based on characteristics to enable attribute-based dynamic memberships for groups. For example, if a user’s department is Sales, that user will be dynamically assigned to the Sales group.

    You can use security groups for either devices or users, but you can only use Microsoft 365 Groups for user groups. If the user's department changes in the future, they're automatically removed from the group. This feature requires a Microsoft Entra ID P1 license.

1. **Dynamic device**. You can create rules based on characteristics to enable attribute-based dynamic memberships for groups. For example, if a user’s device is associated with the Service department, that device will be dynamically assigned to the Service group.

    You can use security groups for either devices or users, but you can only use Microsoft 365 Groups for user groups. If the device's association with a particular department changes in the future, it's automatically removed from the group. This feature requires a Microsoft Entra ID P1 license.

Finally, you can select group owner(s) that can administer the group and member(s) that will belong to the group. Both of these can contain other groups as well as individual users.

### Script group creation

You can also use Microsoft Graph PowerShell to add a group using the [New-MgGroup](/powershell/module/microsoft.graph.groups/new-mggroup) command as shown here:

```powershell
New-MgGroup -Description "Marketing" -DisplayName "Marketing" -MailNickName "Marketing" -SecurityEnabled -MailEnabled:$False
```

## Change membership for a group

Once a group is created, you can add or remove users (or groups) from it by editing the group membership. Select the group and use the options in the **Manage** section.

![Screenshot showing the group-management options.](../media/4-edit-group-membership.png)
