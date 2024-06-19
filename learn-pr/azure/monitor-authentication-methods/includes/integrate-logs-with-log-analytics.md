
The activity logs in Microsoft Entra ID store the information you need to determine how your system is doing. You've seen how to manually access the activity logs to do a quick investigation. For all other scenarios, you can route your Microsoft Entra activity logs to different endpoints. 


Currently, you can route the logs to:

- **An Azure storage account** - To retain the logs data for longer than the default retention period in Microsoft Entra ID.

- **An Azure event hub** -  To integrate the logs data with third-party SIEM tools like Sumologic and Splunk.

- **An Azure Log Analytics workspace** - To analyze the logs data, create dashboard, and alert on specific events.


With the integration of Microsoft Entra activity to an Azure Log Analytics, you can perform tasks like:

- Compare your Microsoft Entra sign-in logs against security logs published by Microsoft Defender for Cloud.

- Troubleshoot performance bottlenecks on your application’s sign-in page by correlating application performance data from Azure Application Insights.

- Analyze Identity Protection risky users and risk detections logs to detect threats in your environment (public preview)

- Identify sign-ins from applications that use the Active Directory Authentication Library (ADAL) for authentication. ADAL is nearing end-of-support.


## Prerequisites

To use a Log Analytics workspace to view and analyze Microsoft Entra logs, make sure that you have the following items available or set up:

- Access to a Log Analytics workspace.
- Access to Microsoft Entra logs.
- Access to Microsoft Entra diagnostics settings.
- A Microsoft Entra ID P1 or P2 or Premium 2 subscription.
- Any of the following Microsoft Entra roles:
  - Security Administrator
  - Security Reader
  - Report Reader
  - Global Administrator

You can use advanced logging in Azure to see users who signed in to your network and to see what users did while they were signed in to your network. 

You've seen how to access the sign-in and audit logs and how you might use the logs to search for unexpected user behavior. Having access to this data is a significant first step in protecting your network and its assets and resources. Gathering and processing sign-in and activity log files can be labor-intensive. This process might identify suspicious user behavior after the event, but it still doesn't meet your security team's need for a real-time view of the behavior.

Azure Monitor can provide the real-time views and alerting your security team needs. You can use a Log Analytics workspace for Azure Monitor to hold, store, and visualize sign-in and activity log data. To reassure the security team in your organization, you want to learn more about Azure Monitor and how you can use it to identify suspicious sign-in behavior.

This unit describes how to set up a Log Analytics workspace for Azure Monitor. You then learn how to send log files to your Log Analytics workspace. Finally, you learn how to create alerts to notify you when suspicious user behavior or activity occurs. In a later exercise, you can try it yourself.


## Create a Log Analytics workspace

You know that Azure collects user data in the form of sign-in and audit log files, but you can't import the data directly into Azure Monitor. First, you must gather the log data in a Log Analytics workspace. Each Log Analytics workspace is unique and has its own data repository and configuration. When you configure the workspace, you can analyze the data by using log searches and table-based queries.

Creating a Log Analytics workspace is straightforward. In the Azure portal, search for **log analytics** to create a new Log Analytics workspace resource.

:::image type="content" source="../media/log-analytics-search-concept.png" alt-text="Screenshot of Log Analytics search results to demonstrate the concept.":::

As you create a new Log Analytics workspace, select or enter details for the workspace. Be sure to create a new workspace, because the workspace is unique to the user who currently is signed in. Each workspace must have a name that's globally unique among Azure Monitor subscriptions. Optionally, you can create tags to use for the workspace,

The pricing tier is automatically assigned as **Pay-as-you-go** and is based on a per-gigabyte (GB) cost.

:::image type="content" source="../media/log-analytics-workspace-concept.png" alt-text="Screenshot of Log Analytics workspace setup pane.":::

With a Log Analytics workspace created, you can gather and do analytics on your user audit and sign-in data.

### Storage sizes for activity logs

It's important to understand how much storage your workspace is likely to consume. A typical sign-in event log is about 4 kilobytes (KB) in size, and the audit log takes up about 2 KB.

To put that into perspective, if your tenant has 1,000 users, your audit log would generate about 15,000 events each day. There would be a daily storage volume of about 30 megabytes (MB) per day or 900 MB per month. The numbers are a little larger for the sign-in logs. Assuming an Azure tenant of 1,000 users, the sign-in logs will generate 34,800 events per day, which is about 140 MB per day or 4 GB of storage per month.

## Send logs to the Log Analytics workspace

Now that you've created a Log Analytics workspace, you assign the user audit logs and sign-in logs. All the data you want to use in Azure Monitor logs must be stored in a Log Analytics workspace. In the Azure portal, go to your Microsoft Entra instance. Select the **Monitoring** tab, and then select **Diagnostics settings**.

To create a connection between the two log files and your Log Analytics workspace, select **Add diagnostic setting**.

:::image type="content" source="../media/diagnostic-setting-concept.png" alt-text="Screenshot that shows how to create a new diagnostic setting.":::

Enter a name to use for the setting and select the logs you want to send to the workspace.

Select the **Send to Log Analytics** option, and then specify or create a Log Analytics workspace.

:::image type="content" source="../media/diagnostic-setting-create-concept.png" alt-text="Screenshot that shows the concept of creating a new diagnostic setting.":::

You've now set up a data streaming process that will push audit and sign-in data to the Log Analytics workspace. Because it's a new service, it takes about 15 minutes for any data to appear in the workspace.
