You've used the tools and services in the Azure portal to gather logging details about your users and their activities. You've taken the audit and sign-in data, and built queries to gain answers and insights into specific behaviors. These queries will also alert you when there's suspicious behavior. This process has gone a long way towards meeting your team's security concerns.

Your security team is pleased. They'll be alerted when identified behaviors are found, but they know those alerts are tightly focused. Now the team wants to know whether Azure can give real-time views of the security of their estate. The team can then identify and respond to new threats.

Azure provides several visualization tools and reports that can meet your security team's needs. You want to understand how to put these tools and reports into practice.

In this unit, you'll explore some of the prebuilt views available for reporting on sign-in events. You'll also learn how to enhance and customize the underlying report queries, and save them to a security dashboard. Finally, you'll learn how to export these reports to Excel and Power BI.

## Understanding prebuilt views

In addition to building your own reports and queries to report on user activity, you can also use prebuilt log analytics views. These views help you report on frequently encountered scenarios using the sign-in and audit log events. All reports and views can be linked with alerts to warn of any unusual results.

Prebuilt views are available on GitHub in the [AzureAD/Deployment-Plans](https://github.com/AzureAD/Deployment-Plans/tree/master/Log%20Analytics%20Views?azure-portal=true) repository. There are two views available to use:

- Azure AD Account Provisioning Events
- Sign-in Events

### Azure AD Account Provision Events view

This view is a collection of reports based on audit log data, focused around account provisioning. You can use reports to:

- See the number of newly provisioned users, and how many failed.
- Gauge the number of users successfully updated, and how many failed.
- Get the number of users deprovisioned, and any that failed.

You'll need to download the [Azure AD Account Provisioning Events.omsview](https://github.com/AzureAD/Deployment-Plans/blob/master/Log%20Analytics%20Views/Azure%20AD%20Account%20Provisioning%20Events.omsview?azure-portal=true) file from the GitHub repository.

### Sign-in Events view

This view is a collection of reports that monitor your users' sign-in attempts. With this view, you can report and monitor:

- Sign in by application
- Sign in by user
- Sign in by device
- Sign-ins over time

You'll need to download the [AzureADSignins.omsview](https://github.com/AzureAD/Deployment-Plans/blob/master/Log%20Analytics%20Views/AzureADSignins.omsview?azure-portal=true) file from the GitHub repository.

### Install a prebuilt view

You can choose to download and install one or both of these prebuilt views into your Log Analytics workspace.  You'll be using the one to which you previously directed the audit and sign-in data streams.

1. In the Azure portal, select **All services**, and type **Log Analytics**. Select the Log Analytics workspace you created earlier.
1. Select **View Designer**.
1. Select **Import**, select **Choose file**, and then browse to the location where you downloaded both views. Select the **Azure AD Account Provisioning Events** file, and select **Save**.
1. Repeat step 3, but select the **Sign-in Events** file, and select **Save**.

You've now imported both prebuilt views into your Log Analytics workspace.

### Using the prebuilt views

With the two prebuilt views installed, you can start using them to assess your users' activity and behaviors.  From the **Log Analytics workspace** summary, you'll see the views you installed.

- Sign-in Events
- Azure AD Account Provisioning Events

To access the view, select the one you're interested in.  Each view comes with many reports you can tailor to give the insight you're looking for.

## Create a security dashboard

Dashboards provide an organized view of the resources in your Azure cloud instance. From the dashboard, you organize and arrange your day-to-day and recurring operational tasks and activities. Each dashboard can be built around a specific activity, like a task or a project.

Start by creating a new dashboard for your security team.

From your Azure portal:

1. Search for **Dashboard**.
1. Select **New Dashboard**, which will create an empty dashboard.
1. Give the dashboard a name, and select **Done**.
1. Even though the dashboard contains no data, you can still share it.  Select the **Share** option, then confirm the sharing and access controls are correct. Give this dashboard a unique and recognizable name; for instance, "security dashboard".  

With the empty dashboard created, you'll need to add a query report. You might think that you could directly add your audit, or sign-in log data, to your dashboard, but that isn't the case. You'll need to return to the Log Analytics workspace you created earlier, to build a query for the dashboard.

### Building a dashboard query

From the log analytics workspace, create a new query. Suppose you wanted to identify the most common user event for the last week. You'd use a query like this one:

```kusto
AuditLogs
| where TimeGenerated >= ago(7d)
| summarize auditCount = count() by OperationName
| sort by auditCount desc
```

It's good practice to check any query by running it. When the query returns a valid result set, you can save it.

![screenshot showing the save and pin to dashboard options for a Log Analytics Query](../media/4-save-query.png)

When the save query control panel appears:

1. Give the query a meaningful **Name**; for instance, "Common User Events Last 7 days".
1. Select the **Category** of **Dashboards**.
1. Select the **Save** option. Saving queries like this allows you to build up a library of the ones most often used.
1. Finally, select **Pin to dashboard**. You'll need to choose the dashboard you created earlier.

With the query pinned, you can now return to the security dashboard you've already created.  When you open the **Security Dashboard**, you'll see the analytics result displayed.

The name of the report needs to be improved, so you should rename it to something meaningful.

![Screenshot showing the updated dashboard with the edit name and edit button highlighted](../media/4-log-analytics-modify-dashboard.png)

Select the edit option to change the **title** to a more meaningful name. For example, "Top User Events past seven days". When you've made all your changes, select **Update**.

## Exporting reports

When you're satisfied with the report, you can export it to Excel or the Power BI desktop application. From the navigation bar, select the **Export** option. You'll then have a couple of choices: Export to Excel (all columns or displayed columns), or Export a Power BI M Query.

![Screenshot showing the export options](../media/4-export-options.png)

### Export a report to Excel

When exporting to Excel, you have two choices.  You can export the whole report, or export selected columns.  This action will export all the result set data for the query you've built. You can save the CSV file to your local computer.

### Export a report to Power BI (M)

Power BI lets you build complex and dynamic reports and dashboards from the data you supply it.  From your Log Analytics workspace, you export the report to Power BI by selecting **Export** and choosing the **Power BI (M)** option.  This export doesn't export the data, but builds a complex M Query.  The Power BI desktop application will use the M Query to make a connection to your Azure instance, and pull active data from it.

1. **Save** the text file to a location on your local computer.
1. Open the saved file in your chosen a text editor. You'll need to copy the content to Power BI.
1. Open the **Power BI Desktop** application.
1. Select **Get Data**, and then choose **Blank Query**.

When the query editor opens:

1. Select the **View** menu option, and choose **Advanced Editor**.
1. **Copy** the content from the saved Power BI (M) file.
1. Paste the **M Language script** into the editor pane.
1. Select **Done** when ready.

Because this query originated in Azure, you'll need to use the **Organizational account** option, and your Azure authentication credentials to grant Power BI access to your Azure instance.

With the link created, you can now select any of the reporting chart styles to represent your data in the way you want.  

![Screenshots showing how to build a report in Power BI](../media/4-power-bi-analytics-visualize.png)

When you've laid out the report as you want, you can select **Publish to Web** to publish the report to your Azure Power BI cloud workspace. From there, the report can be used on other web pages.
