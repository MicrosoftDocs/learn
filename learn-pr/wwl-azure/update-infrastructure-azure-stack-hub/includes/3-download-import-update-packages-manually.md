You install update packages using the **Update** blade in the Azure Stack Hub administrator portal. This unit describes the steps to update, monitor, and troubleshoot the update process.

You can manage updates from the administrator portal and use the **Updates** section of the dashboard to:

 -  View important info, such as the current version.
 -  Install updates and monitor progress.
 -  Review update history for previously installed updates.
 -  View the cloud's current OEM package version.

## Determine the current version

You can view the current version of Azure Stack Hub in the **Updates** blade. To open:

1.  Open the Azure Stack Hub administrator portal.
2.  Select **Dashboard**. In the **Updates** pane, the current version is listed:
    
    :::image type="content" source="../media/how-to-update-image-1-4c7601e0.png" alt-text="Updates tile on default dashboard.":::
    

## Install updates and monitor progress

Before applying updates in Azure Stack Hub, ensure you have completed all steps in the [pre-update checklist](/azure-stack/operator/release-notes-checklist?view=azs-2008) and have scheduled an appropriate maintenance window for the update type that you are applying.

1.  Open the Azure Stack Hub administrator portal.
2.  Select **Dashboard**. Select **Update**.
3.  Select the available update that you want to install. If you don't have an update marked as **Available**, prepare the update package.
4.  Select **Update now**.
    
    :::image type="content" source="../media/how-to-update-image-2-58096bca.png" alt-text="Screenshot that shows how to start an update in Azure Stack Hub.":::
    

5.  You can view high-level status as the update process iterates through various subsystems in Azure Stack Hub. Throughout the update process, the update resource provider reports other details about the update, such as the number of steps that have succeeded, and the number in progress.
6.  Select the **Download summary** from the update run details blade to download full logs.
    
    :::image type="content" source="../media/how-to-update-image-3-069c1831.png" alt-text="Azure Stack Hub update run details.":::
    

7.  When complete, the update resource provider displays a **Succeeded** confirmation to show that the update process has finished, and how long it took. From there, you can view info on all updates, available updates, or installed updates using the filter.
    
    :::image type="content" source="../media/how-to-update-image-4-ce7fe627.png" alt-text="azure-stack-update-apply.":::
    

If the update fails, the **Update** blade reports **Needs attention**. Use the **Download full logs** option to get a high-level status of where the update failed. Azure Stack Hub log collection helps with diagnostics and troubleshooting.

## Review update history

1.  Open the administrator portal.
2.  Select **Dashboard**. Select **Update**.
3.  Select **Update history**.
    
    :::image type="content" source="../media/how-to-update-image-5-77eb5d90.png" alt-text="Azure Stack Hub update history.":::
    
