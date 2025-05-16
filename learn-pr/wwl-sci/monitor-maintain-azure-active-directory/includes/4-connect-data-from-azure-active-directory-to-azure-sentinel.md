In this unit we take a look at what is Microsoft Sentinel?

:::image type="content" source="../media/azure-sentinel.png" alt-text="Screenshot of Azure Sentinel screenshot that shows the initial configuration screen that allows you to create a new KQL (Kusto Query Language) queries.":::

A security information and event management (SIEM) aggregates and analyzes activity. A security orchestration automation and remediation (SOAR) tool collects data on security threats and responds. Microsoft Sentinel is a scalable, cloud-native SIEM, and SOAR solution. Microsoft Sentinel is your birds-eye view across the enterprise alleviating the stress of increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

 - Collect data at cloud scale across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds
 - Detect previously undetected threats, and minimize false positives using Microsoft analytics and unparalleled threat intelligence
 - Investigate threats with artificial intelligence, and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft
 - Respond to incidents rapidly with built-in orchestration and automation of common tasks

## Prerequisites

 - A Microsoft Entra ID P1 or P2 license is required to ingest sign-in logs into Microsoft Sentinel. Any Microsoft Entra ID license (Free/O365/P1/P2) is sufficient to ingest the other log types. Additional per-gigabyte charges might apply for Azure Monitor (Log Analytics) and Microsoft Sentinel.<br>
 - Your user must be assigned the Microsoft Sentinel Contributor role on the workspace.
 - Your user must be assigned the Security Administrator role on the tenant you want to stream the logs from.
 - Your user must have read and write permissions to the Microsoft Entra diagnostic settings to be able to see the connection status.

## Create and add a Microsoft Sentinel workspace

Use these instructions if you don't already have a workspace available to Microsoft Sentinel.

1. Sign in to the [Azure portal](https://portal.azure.com/) as a tenant administrator.
2. Search for and select **Microsoft Sentinel**.
3. In the Microsoft Sentinel workspaces screen, on the menu, select **+ Add**. If you already have a Microsoft Sentinel workspace, you can select that and continue to the next task.
4. In the Add Microsoft Sentinel to a workspace screen, select **Create a new workspace**.
5. Use the following information to create a new log analytics workspace:
    
    | **Setting**    | **Value**                                           |
    | :---           | :---                                                |
    | Subscription   | Use your current subscription.                      |
    | Resource group | Use an existing resource group or create a new one. |
    | Name           | Lab-workspace-yourinitialsanddate.                  |
    |                | The workspace must be a globally unique value.      |
    | Pricing tier   | Pay-as-you-go                                       |

6.  When complete, select your new workspace and then select **Add** to add the workspace to Microsoft Sentinel.

## Connect to Microsoft Entra ID

You can use Microsoft Sentinel's built-in connector to collect data from Microsoft Entra ID and stream it into Microsoft Sentinel. The connector allows you to stream [sign in logs](/azure/active-directory/reports-monitoring/concept-sign-ins) and [audit logs](/azure/active-directory/reports-monitoring/concept-audit-logs).

1. In Microsoft Sentinel, in the navigation menu on the left, under **Configuration**, select **Data connectors**.
2. In the **Data connectors** list, select **Microsoft Entra ID** and then select **Open connector page**.
    
   :::image type="content" source="../media/sentinel-add-azure-active-directory-connector.png" alt-text="Screenshot of the data connectors screen with the Microsoft Entra ID connector and Open Connector page highlighted.":::
    
3. Under **Configuration**, select the **Microsoft Entra Sign in logs** and **Audit logs** checkboxes and then select **Apply changes**.
    
   :::image type="content" source="../media/sentinel-configure-azure-active-directory-connector.png" alt-text="Screenshot of the logs collected by Azure Sentinel selections highlighted.":::
    
4. Close the Microsoft Entra ID connector page.
