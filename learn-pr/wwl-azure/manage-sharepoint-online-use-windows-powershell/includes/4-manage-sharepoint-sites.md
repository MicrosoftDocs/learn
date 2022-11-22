In SharePoint Online, you can have multiple sites that contain different content. There's a default site designed for collaboration that's created automatically when you create your tenant. There are also sites created automatically for each Microsoft 365 group or Microsoft Team and OneDrive users. Additionally, you can create your own SharePoint sites and customize them.

## Creating sites

You can use the **New-SPOSite** cmdlet to create new sites in SharePoint online. When you create a new site, the parameters in the following table are required.

*Table 1: Parameters for creating a new site*

| Parameter       | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| -Url          | The URL for the site, which needs to be with your SharePoint Online namespace. For example, if the default URL for your SharePoint Online tenant is `https://adatum.sharepoint.com`, then the URL for the site could be `https://adatum.sharepoint.com/sites/Marketing`. |
| -Owner        | The owner of the site that can manage it.                    |
| -StorageQuota | The maximum size of the site in megabytes (MB). This must be less than the quota available in the tenant. |

The following example creates a new site with `AbbieP@adatum.com` as the owner and a 256 MB storage quota:

```powershell
New-SPOSite -Url https://adatum.sharepoint.com/sites/Marketing -Owner AbbieP@adatum.com -StorageQuota 256
```

Most of the time when you create a site, you'll want to base it on a template. A template defines components that are automatically included in a site. There are templates included in SharePoint Online by default and you can also make your own. To review the template in your SharePoint Online tenant, use the **Get-SPOWebTemplate** cmdlet. To use a template when creating a site with the **New-SPOSite** cmdlet, use the *-Template* parameter.

## Modifying sites

You can use the **Set-SPOSite** cmdlet to modify existing sites. To define which site you want to modify, use the *-Identity* parameter and provide the URL for the site. The URL for a site is a unique identifier for the site, and you cannot modify it by using **Set-SPOSite**. The following table lists some parameters you can use with **Set-SPOSite**.

*Table 2: Parameters for modifying existing sites*

| Parameter                   | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| -Title                    | Sets the title for the site. The title typically displays when users sign in to the site. For example, a title might be **Marketing Portal**. |
| -StorageQuotaWarningLevel | Sends a warning message to the site owner when the warning level is reached. This value should be less than the -StorageQuota. |
| -AllowEditing             | Controls whether users are allowed to edit Office files in the browser, and copy and paste Office file content out of the browser window. |
| -LockState                | Sets the lock state on a site. Valid values are: **NoAccess**, **ReadOnly**, and **Unlock**. |

The following example sets the title for a site:

```powershell
Set-SPOSite -Identity https://adatum.sharepoint.com/sites/Marketing -Title "Marketing Portal"
```

## Listing and reviewing sites

You can use the **Get-SPOSite** cmdlet to review the sites created in your SharePoint Online tenant and their configurations. To list all sites in your tenant, don't include any parameters. To list the specific site's properties, you use the *-Identity* parameter and specify the site's URL. The following example depicts how to list a specific site's properties:

```powershell
Get-SPOSite -Identity https://adatum.sharepoint.com/sites/Marketing | Format-List
```

## Removing sites

You use **Remove-SPOSite** to remove a site. The following example depicts how to use this cmdlet to remove a site:

```powershell
Remove-SPOSite -Identity https://adatum.sharepoint.com/sites/Marketing
```

When you remove a site, it's placed in the SharePoint Recycle Bin. You can use the **Restore-SPODeletedSite** cmdlet to restore a site from the SharePoint Recycle Bin. To purge a deleted site from the SharePoint Recycle Bin, you can use the **Remove-SPODeletedSite** cmdlet.

## SharePoint Online terminology

The SharePoint admin center uses the site and sub-site terminology to describe how to nest content. When you create a sub-site, it inherits some of the settings from the site, such as the owner.

If you're familiar with the on-premises version of SharePoint, it uses the terminology *site collections* and *sites* instead. When reviewing documentation for SharePoint Online cmdlets, you might notice that it often uses the on-premises site collections terminology. There are no cmdlets for managing sites within site collections (or sub-sites).