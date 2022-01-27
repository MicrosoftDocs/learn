## What is Microsoft Sentinel

:::image type="content" source="../media/sc300-azure-sentinel-8c292cfe.png" alt-text="Azure Sentinel screenshot showing the initial configuration screen that allows you to create a new event review, manage views, and open to open KQL queries.":::


Microsoft Microsoft Sentinel is a scalable, cloud-native, security information event management (SIEM) and security orchestration automated response (SOAR) solution. Microsoft Sentinel is your birds-eye view across the enterprise alleviating the stress of increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

 -  Collect data at cloud scale across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds
 -  Detect previously undetected threats, and minimize false positives using Microsoft's analytics and unparalleled threat intelligence
 -  Investigate threats with artificial intelligence, and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft
 -  Respond to incidents rapidly with built-in orchestration and automation of common tasks

## Prerequisites

 -  Any Azure AD license (Free/O365/P1/P2) is sufficient to ingest sign-in logs into Microsoft Sentinel. Additional per-gigabyte charges may apply for Azure Monitor (Log Analytics) and Microsoft Sentinel.
 -  Your user must be assigned the Microsoft Sentinel Contributor role on the workspace.
 -  Your user must be assigned the Global Administrator or Security Administrator roles on the tenant you want to stream the logs from.
 -  Your user must have read and write permissions to the Azure AD diagnostic settings to be able to see the connection status.

## Create and add an Microsoft Sentinel workspace

Use these instructions if you do not already have a workspace available to Microsoft Sentinel.

1.  Sign in to the [Azure portal](https://portal.azure.com/) as a tenant administrator.
2.  Search for and select **Microsoft Sentinel**.
3.  In the Microsoft Sentinel workspaces blade, on the menu, select **+ Add**. If you already have an Microsoft Sentinel workspace, you can select that and continue to the next task.
4.  In the Add Microsoft Sentinel to a workspace blade, select **Create a new workspace**.
5.  Use the following information to create a new log analytics workspace:
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Use your current subscription.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        Use an existing resource group or create a new one.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        
    
     -  **Lab-workspace-yourinitialsanddate**
     -  The workspace must be a globally unique value.
    
    
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Pricing tier
      :::column-end:::
      :::column:::
        Pay-as-you-go
      :::column-end:::
    :::row-end:::
    
6.  When complete, select your new workspace and then select **Add** to add the workspace to Microsoft Sentinel.

## Connect to Azure Active Directory

You can use Microsoft Sentinel's built-in connector to collect data from [Azure Active Directory](/azure/active-directory/fundamentals/active-directory-whatis) and stream it into Microsoft Sentinel. The connector allows you to stream [sign-in logs](/azure/active-directory/reports-monitoring/concept-sign-ins) and [audit logs](/azure/active-directory/reports-monitoring/concept-audit-logs).

1.  In Microsoft Sentinel, in the navigation menu on the left, under **Configuration**, select **Data connectors**.
2.  In the **Data connectors** list, select **Azure Active Directory** and then select **Open connector page**.

:::image type="content" source="../media/sentinel-add-azure-active-directory-connector-d6d578f0.png" alt-text="Screen image displaying the data connectors blade with the Azure Active Directory connector and Open Connector page highlighted":::


3.  Under **Configuration**, select the **Azure Active Directory Sign-in logs** and **Audit logs** checkboxes and then select **Apply changes**.

:::image type="content" source="../media/sentinel-configure-azure-active-directory-connector-a4688542.png" alt-text="Screen image displaying the Azure Active Directory logs collected by Azure Sentinel selections highlighted":::


4.  Close the Azure Active Directory connector page.
