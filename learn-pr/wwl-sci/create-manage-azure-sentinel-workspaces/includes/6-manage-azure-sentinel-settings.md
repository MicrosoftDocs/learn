Microsoft Sentinel Environment Settings are managed in two areas.  In Microsoft Sentinel and in the Log Analytics workspace where Microsoft Sentinel resides. In Microsoft Sentinel, the left navigation has an option for Settings.  The Settings includes tabs for Pricing, Settings, and Workspace Settings—the Settings changes over time based on the current and in-preview feature set.  Most Microsoft Sentinel Environment settings are managed in the Log Analytics workspace.  Other areas within the Microsoft Sentinel portal will transfer you to the Log Analytics portal.  One example of this are specific data connector configurations that are performed in the log analytics workspace.

## Configure log retention

Data retention at the workspace level can be configured from 30 to 730 days (two years) for all workspaces unless they are using the legacy Free pricing tier.  To adjust the retention days, select the workspace settings in the Microsoft Sentinel Settings area.  The next screen is in the Log Analytics portal.  Select the "Usage and estimated costs" tab.  At the top of the page, select the "Retention" button.  A blade will open, allowing for the adjustment of the retention days.

![Setting the data retention](../media/retention.png)

