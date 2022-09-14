SharePoint Online is the cloud-based version of SharePoint that's included as part of Microsoft 365. You can use SharePoint Online to create sites for user collaboration and file storage. However, SharePoint Online is also used as storage for other Microsoft 365 services. For example, Microsoft Teams uses SharePoint Online as a location for file storage.

You can manage many SharePoint Online features by using the web-based SharePoint admin center. However, it doesn't provide full management access to SharePoint Online. For some advanced operations, you need to use SharePoint Online Management Shell. The *SharePoint Online Management Shell* is a Windows PowerShell module that you can install.

## Installing SharePoint Online Management Shell

You install the SharePoint Online Management Shell from the PowerShell Gallery by running the following command:

```powershell
Install-Module -Name Microsoft.Online.SharePoint.PowerShell
```

The SharePoint Online Management Shell doesn't update automatically. To update the module, run the following command:

```powershell
Update-Module -Name Microsoft.Online.SharePoint.PowerShell
```

## Connecting to SharePoint Online

All of the cmdlet nouns in the SharePoint Online Management Shell begin with **SPO**. You can connect to SharePoint Online by using the **Connect-SPOService** cmdlet as in the following example:

```powershell
Connect-SPOService -Url https://adatum-admin.sharepoint.com
```

When you connect to SharePoint Online, you need to provide the URL for your SharePoint Online instance. This URL is based on your Microsoft 365 tenant name. For example, if your Microsoft 365 tenant name is **adatum.onmicrosoft.com**, then the URL for administering SharePoint Online is **adatum-admin.sharepoint.com**. You can also find this URL when you sign in to SharePoint admin center.

> [!NOTE]
> To sign in by using **Connect-SPOService**, you need a user account with either SharePoint Admin or Global Administrator permissions for the Microsoft 365 tenant.
