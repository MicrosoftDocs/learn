
You have learned that Audit (Standard) is enabled by default for all organizations with the appropriate subscription, but you still have to start the recording. In this exercise you'll perform the following tasks:

- Enable recording by using the Purview Compliance portal Audit Search interface.
- Use Exchange PowerShell to check the status and enable or disable recording.

### Prerequisites

- You'll need a Microsoft 365 tenant with licensing that supports Microsoft Defender XDR and Microsoft Purview.
- To run the PowerShell cmdlets, you'll need to have Cloud Shell configured (either in the [Microsoft Azure portal](https://portal.azure.com/) or the [Microsoft 365 admin center portal](https://admin.microsoft.com/)).

> [!NOTE]
> If you choose to perform this exercise in the unit, be aware you might incur costs in your Azure Subscription. To estimate the cost, refer to [Microsoft Sentinel Pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).

### Use the Purview Compliance portal to Start recording the Audit Log

To start recording in the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), select **Audit** under **Solutions** and then select (the horizontal blue bar) **Start recording user and admin activity**.

> [!TIP]
> You can perform the same steps in the [Microsoft Defender portal](https://security.microsoft.com/), shown in the screenshot.

:::image type="content" source="../media/screenshot-audit-enable.png" alt-text="Screenshot of the blue bar used to enable recording of activity.":::

> [!NOTE]
> If the blue bar to **Start recording..** is not there, recording is already enabled. You can disable and reenable recording with Exchange PowerShell cmdlets.

### Use Exchange PowerShell to Start recording the Audit Log

To start recording using Exchange PowerShell, perform the following steps:

1. In the [Microsoft Azure portal](https://portal.azure.com/), select the **Cloud Shell** icon to open a new **PowerShell** session. If Cloud Shell opens with a Bash prompt, you'll need to switch to PowerShell.
1. From the PowerShell /home/xxx command prompt, enter the **Connect-EXOPSSession** cmdlet and wait for it to complete. It loads all the Exchange PowerShell cmdlets you need and you can ignore any warning messages.
1. Next, enter the **Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled** cmdlets. If recording isn't enabled, you see the following response: **UnifiedAuditLogIngestionEnabled : False** (it responds with **True** if enabled).
1. To enable recording, enter the **Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true** cmdlet. You'll receive the following response: **WARNING: The admin audit log configuration change you specified could take up to 60 minutes to take effect.**.
1. After a couple minutes you can rerun the **Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled** cmdlets and the response will be **UnifiedAuditLogIngestionEnabled : True**.

> [!TIP]
> You can disable Audit log recording by running the **Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $false** PowerShell cmdlet.

After completing these steps, you'll have enabled Unified Audit Log recording:

- Using the Microsoft Purview compliance portal (or the Microsoft Defender portal).
- Using Exchange online PowerShell cmdlets in Cloud Shell

## Check your work

1. The blue Start recording bar is gone and you can enter search criteria in the form fields.
:::image type="content" source="../media/screenshot-ready-to-search-the-audit-log-2023-04-04-143906.png" alt-text="Screenshot of the Audit search form ready to perform searches." lightbox="../media/screenshot-ready-to-search-the-audit-log-2023-04-04-143906.png":::
1. Or, using Exchange PowerShell in Azure Cloud Shell, the result of "Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled" is "True".
:::image type="content" source="../media/screenshot-powershell-ready-to-search-2023-04-04-144700.png" alt-text="Screenshot of the PowerShell cmdlet results in Cloud Shell.":::

## Resources

[Turn auditing on or off](/microsoft-365/compliance/audit-log-enable-disable)
