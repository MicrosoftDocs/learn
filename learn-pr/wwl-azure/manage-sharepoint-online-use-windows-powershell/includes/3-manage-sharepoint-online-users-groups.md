To provide access to a SharePoint site, you can assign users and groups varying levels of site permissions. Some of the permissions available by default are:

- Full Control
- Design
- Edit
- Approve
- Contribute
- Read

> [!NOTE]
> You can create customized permission levels by using SharePoint admin center. There are no cmdlets in SharePoint Online Management Shell for creating or modifying customized permission levels.

## SharePoint groups

To assign permissions in SharePoint Online by using PowerShell, you create SharePoint groups. SharePoint groups exist only in SharePoint Online and are specific to the site in which you create them. The following example depicts how to use the **New-SPOSiteGroup** cmdlet to create a SharePoint Online group and assign permissions for a site:

```powershell
New-SPOSiteGroup -Group MarketingUsers -PermissionLevels Read -Site https://adatum.sharepoint.com/sites/Marketing
```

You can use the **Get-SPOSiteGroup** cmdlet to identify the SharePoint groups that have been created for a site and assigned permissions. The results also contain the group membership. You need to specify the site URL with the request as depicted in the following example:

```powershell
Get-SPOSiteGroup -Site https://adatum.sharepoint.com/sites/Marketing
```

You can modify the permissions assigned to a SharePoint group by using the **Set-SPOSiteGroup** cmdlet. You need to specify the name of the group and the site URL in addition to the permissions to be modified. To add permissions, use the *-PermissionLevelsToAdd* parameter. To remove permissions, use the *-PermissionLevelsToRemove* parameter. The following example uses the *-PermissionLevelsToAdd* parameter:

```powershell
Set-SPOSiteGroup -Site https://adatum.sharepoint.com/sites/Marketing -Group MarketingUsers -PermissionLevelsToAdd Contribute
```

## Managing site users

To give permissions to Microsoft Entra users, you must make them members of a SharePoint group. You can add members to a SharePoint group by using the **Add-SPOUser** cmdlet as depicted in the following example. You need to specify the site URL along with the group name:

```powershell
Add-SPOUser -Site https://adatum.sharepoint.com/sites/Marketing -Group MarketingUsers -LoginName AbbieP@adatum.com
```

> [!NOTE]
> You can also add security groups from Microsoft Entra ID as members of SharePoint groups by using the **Add-SPOUser** cmdlet.

The **Remove-SPOUser** cmdlet has similar syntax to the **Add-SPOUser** cmdlet but removes a user from the specified SharePoint group. If you don't specify a group, then the user is removed from all SharePoint groups in the site.

To review the users who are members of SharePoint groups, you can use the **Get-SPOUser** cmdlet. You need to specify the site URL from which to retrieve users, but the group is optional. If you don't specify the group, you'll receive a list of all users in the site and the SharePoint groups that they are members of.

There is also a **Set-SPOUser** cmdlet but its only purpose is to set whether a user is an administrator for the site. The following example depicts how to configure a user as a site administrator:

```powershell
Set-SPOUser -Site https://adatum.sharepoint.com/sites/Marketing -LoginName AbbieP@adatum.com -IsSiteCollectionAdmin $true
```
