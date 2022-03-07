App Service on Azure Stack Hub isn't backed up as part of Azure Stack Hub infrastructure backup. As an Azure Stack Hub Operator, you must take steps to ensure App Service can be successfully recovered if necessary.

Azure App Service on Azure Stack Hub has four main components to consider when planning for disaster recovery:

 -  The resource provider infrastructure; server roles, worker tiers, and so on.
 -  The App Service secrets.
 -  The App Service SQL Server hosting and metering databases.
 -  App Service user workload content stored in the App Service file share.

## Back up App Service secrets

When recovering App Service from backup, you need to provide the App Service keys used by the initial deployment. This information should be saved as soon as App Service is successfully deployed and stored in a safe location. The resource provider infrastructure configuration is recreated from backup during recovery using App Service recovery PowerShell cmdlets.

Use the administration portal to back up app service secrets by following these steps:

1.  Sign in to the Azure Stack Hub administrator portal as the service admin.
2.  Browse to **App Service -&gt; Secrets**.
3.  Select **Download Secrets**.
    
    :::image type="content" source="../media/back-up-app-service-image-1-bab73314.png" alt-text="Download secrets in Azure Stack Hub administrator portal.":::
    

4.  When secrets are ready for downloading, click **Save** and store the App Service secrets (**SystemSecrets.JSON**) file in a safe location.
    
    :::image type="content" source="../media/back-up-app-service-image-2-1cf10ce0.png" alt-text="Save secrets in Azure Stack Hub administrator portal.":::
    

Repeat these steps every time the App Service secrets are rotated.

## Back up the App Service databases

To restore App Service, you need the **Appservice\_hosting** and **Appservice\_metering** database backups. We recommend using SQL Server maintenance plans or Azure Backup Server to ensure these databases are backed up and saved securely regularly. However, any method of ensuring regular SQL backups are created can be used.

To manually back up these databases while logged into the SQL Server, use the following PowerShell commands:

```PowerShell
$s = "<SQL Server computer name>"
$u = "<SQL Server login>"
$p = read-host "Provide the SQL admin password"
sqlcmd -S $s -U $u -P $p -Q "BACKUP DATABASE appservice_hosting TO DISK = '<path>\hosting.bak'"
sqlcmd -S $s -U $u -P $p -Q "BACKUP DATABASE appservice_metering TO DISK = '<path>\metering.bak'"

```

After all databases have been successfully backed up, copy the .bak files to a safe location along with the App Service secrets info.

## Back up the App Service file share

App Service stores tenant app info in the file share. This file share must be backed up regularly along with the App Service databases so that as little data as possible is lost if a restore is required.

To back up the App Service file share content, use Azure Backup Server or another method to regularly copy the file share content to the location you've saved all previous recovery info.

For example, you can use these steps to use Robocopy from a Windows PowerShell (not PowerShell ISE) console session:

```PowerShell
$source = "<file share location>"
$destination = "<remote backup storage share location>"
net use $destination /user:<account to use to connect to the remote share in the format of domain\username> *
robocopy $source $destination
net use $destination /delete

```
