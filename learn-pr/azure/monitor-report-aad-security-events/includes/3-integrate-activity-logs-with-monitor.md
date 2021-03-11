Azure provides advanced logging, which lets you see both the users who have signed in to your system and what they did while connected. 

You've seen how to access the sign-in and audit logs, and how you might use them to search for unexpected user behavior.  Having access to this data is a significant first step in protecting your network, assets, and resources. Gathering and processing the log files can be labor-intensive. This process might identify suspicious user behavior after the event, but it still doesn't meet your security team's need for a real-time view of such behavior.

Azure Monitor can provide the real-time views and alerting that your security team needs. To reassure your team, you want to learn more about Azure Monitor and how it's used to identify suspicious sign-in behavior.

In this unit, you set up a Log Analytics workspace to hold and store the audit and sign-in log data. You then learn how to send the log files to Azure Monitor. Finally, you see how to create Azure Monitor alerts to notify the team when there's suspicious user behavior or activity.

## Prerequisites

To use the Log Analytics workspace and Azure Monitor logs, make sure that you have the following items available or set up:

- Access to the Log Analytics workspace
- Access to Azure Monitor logs
- Access to Azure Active Directory (Azure AD) diagnostic settings
- An Azure AD Premium 1 or Premium 2 subscription
- Any of the following Azure AD roles:
  - *Security Administrator*
  - *Security Reader*
  - *Report Reader*
  - *Global Administrator*

## Log Analytics workspace

You know that Azure collects user data in the form of audit and sign-in log files, but the data can't be directly imported into Azure Monitor. First, it needs to be gathered in a Log Analytics workspace. Each workspace is unique and has its own data repository and configuration. When you configure the workspace, you can analyze the data by using log searches and table-based queries.

Creating a Log Analytics workspace is straightforward.

1. Sign in to your Azure portal or sandbox instance.

1. Select **All service** and, in the **Search** box, enter **log analytics**.

1. In the results list, select **Log Analytics workspaces**, and then select **Add** to create a new Log Analytics workspace. To create a new Log Analytics workspace, supply the following details:

   a. Select **Create New**, because this workspace is unique to the user who's signing in. Each workspace needs a **Name** that's globally unique among Azure Monitor subscriptions.  
   b. Select the subscription, and then select the workspace you want to use, such as an existing **Resource group**.

   The pricing tier is automatically assigned as **pay-as-you-go** and is based on a per-gigabyte (GB) cost.

1. Select **OK** to create the workspace.

You've now created a Log Analytics workspace, where you can gather and do analytics on your user audit and sign-in data.

### Storage sizes for activity logs

It's important to understand how much storage your workspace is likely to consume. A typical sign-in event log is about 4 kilobytes (KB) in size, and the audit log takes up about 2 KB.

To put that into some perspective, if your tenant has 1,000 users, your audit log would generate about 15,000 events each day. There would be a daily storage volume of about 30 megabytes (MB) per day, or 900 MB per month. The numbers are a little larger for the sign-in logs. Assuming an Azure tenant of 1,000 users, the sign-in logs will generate 34,800 events per day, which is about 140 MB per day, or 4 GB of storage per month.

## Send user logs to the Log Analytics workspace

Now that you've created a Log Analytics workspace, you assign the user audit and sign-in logs. All the data you want to use in Azure Monitor logs must be stored in a Log Analytics workspace.

To stream the audit and sign-in logs to your Log Analytics workspace, you need to:

1. Open Azure Active Directory.

1. In the **Monitoring** section, select **Diagnostics settings**.

   The **Diagnostics settings** pane opens. This is where you create the connection between the log files and your Log Analytics workspace. Each setting needs a name.  

1. Select the **Send to Log Analytics** option, and then specify or create a Log Analytics workspace. In our scenario, you select the Log Analytics workspace you've just created, and then do the following:  

   a. Select the **Configure** option, and then select the Log Analytics workspace you created earlier.  
   b. Decide which of the log files you want to stream to the workspace. You can select **Audit log**, **Sign-up log**, or both.

1. Select **Save**.  

You've now set up a data streaming process that will push audit and sign-in data to the Log Analytics workspace. Because this is a new service, it takes about 15 minutes for any data to appear in the workspace.

## Analyze the log files in Azure Monitor logs

You've set up your Log Analytics workspace to receive user activity data. Now you can use the power of Azure Monitor logs to view the activity within your environment. With Azure Monitor logs, you can query your data to spot trends, specific events, or correlate multiple data sources.  

### Log data schemas

The data streams for both the audit and sign-in logs are stored in your Log Analytics workspace in two separate tables, **AuditLogs** and **SignInLogs**. Each table has its own schema that you can use to query against.

| Audit log schema   | Sign-in log schema        |
| ------------------ | ------------------------- |
| Additional Details | AppDisplayName            |
| Category           | AppId                     |
| CorrelationId      | Category                  |
| DurationMs         | ClientAppUsed             |
| Id                 | ConditionalAccessPolicies |
| Identity           | ConditionalAccessStatus   |
| InitiatedBy        | CorrelationId             |
| Level              | CreatedDateTime           |
| Location           | DeviceDetail              |
| LoggedByService    | DurationMs                |
| OperationName      | Id                        |
| OperationVersion   | Identity                  |
| Resource           | IPAddress                 |
| ResourceGroup      | IsRisky                   |
| ResourceId         | Level                     |
| ResourceProvider   | Location                  |
| Result             | LocationDetails           |
| ResultDescription  | MfaDetails                |
| ResultReason       | OperationName             |
| ResultSignature    | OperationVersion          |
| ResultType         | Resource                  |
| SourceSystem       | ResourceGroup             |
| TargetResources    | ResourceId                |
| TimeGenerated      | ResourceProvider          |
| Type               | ResultDescription         |
|                    | ResultSignature           |
|                    | ResultType                |
|                    | RiskLevel                 |

### Write activity log queries

With the audit logs stored in your workspace tables, you can now run queries against them. You can write two types of queries, *table-based* and *search-based*. The schema structures in the preceding section show you all the fields you can query against.

The query language you use is Kusto. It's designed to process data and return a result set.

Each Kusto query follows a common pattern:

- The query always starts with the name of the table you're running the query against.  Here, that name would be either **SignInLogs** or **AuditLogs**.
- Each command is separated by a pipe (|) and typically begins on a new line. You can have multiple pipes in a query.

Unless you nominate specific columns, the result set you see contains all schema fields.

The *where* command is the most common means of filtering the data in your query.  When you write a condition to filter your data, the following expressions are valid:

| Expression  | Description                                       | Example                                                    |
| :---------- | :------------------------------------------------ | :--------------------------------------------------------- |
| ==          | Check equality (case-sensitive)                   | `Level == 8`                                               |
| =~          | Check equality (case-insensitive)                 | `EventSourceName =~ "microsoft-windows-security-auditing"` |
| !=, <>      | Check inequality (both expressions are identical) | `Level != 4`                                               |
| *and*, *or* | Required between conditions                       | `Level == 16 or CommandLine != ""`                         |

Other common filter commands include:

| Command                            | Description                                                   | Example                                                      |
| ---------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| take *n*                           | Ideally suited to small result sets. Take returns *n* rows from the result set in no particular order. | AuditLogs \| Take 10                                         |
| top *n* by *field*                 | Use this filter command to return the top *n* rows, sorted by the nominated *field*. | AuditLogs \| Top 10 by timeGenerated                         |
| sort by *field* (desc)             | If you want to sort only the result set, you can use the sort command. You need to specify the field to sort on, and then you can optionally add the *desc* instruction to specify a descending sort pattern. | AuditLogs \| Sort by timeGenerated desc                      |
| Where *field* (expression) *value* | This is the principal filtering command.  You nominate the field, expression, and comparator value.  You can stack multiple where commands, each separated by a pipe. | AuditLogs \| where CreatedDataTime >= ago(2d)                |
| project *fields*                   | If you want to restrict the result set to display only nominated fields or columns, you can use the project command with a comma-separated list of the fields. | AuditLogs \| project timeGenerated, OperationName, ResourceGroup, Result |

You can use many other commands to build your queries. You can find out more information about the query commands you can use to filter your data at the links provided at the end of this module.

#### Example sign-in query

Let's suppose you want to know the most-used applications requested and signed in to over the last week. Your query would look something like this:

```kusto
SigninLogs
| where CreatedDataTime >= ago(7d)
| summarize signInCount = count() by AppDisplayName
| sort by signInCount desc
```

Or, if you want to see how many of your users were flagged as risky in the last 14 days, you would use:

```kusto
SigninLogs
| where CreatedDataTime >= ago(14d)
| where isRisky == true
```

#### Example audit query

Now let's suppose you want to know the most common user event for the last week. You would use a query like this:

```kusto
AuditLogs
| where TimeGenerated >= ago(7d)
| summarize auditCount = count() by OperationName
| sort by auditCount desc
```

## Create alerts from your activity log data

Alerts aren't dissimilar to queries, the principal difference being that they run automatically. You can set a threshold against the result set and, if it's met, trigger an alert to let you know about it.

1. To get started, select **Set alert**.

   ![Screenshot of the "Set alert" button.](../media/3-set-query-alert.png)

   The **Create rule** pane opens.

   If you want to be alerted when more than 10 applications are used in the past week, you would run the following query.

   ```kusto
   SignInLogs
   | where CreatedDateTime >= ago(7d)
   | summarize signInCount = count() by AppDisplayName
   | sort by signInCount desc
   ```

1. Because this is an alert, indicate how often the query is to be run against the data. You can specify the frequency down to the minute, but you should consider both the volume of data and the time it takes to run the query.

1. Assign the alert logic to specify the threshold limits that will trigger the alert.

   | Field     | Value                 |
   | --------- | --------------------- |
   | Based On  | *Number of results* |
   | Condition | *Greater than*      |
   | Threshold | *10*                |

1. Give the alert a name and description, and assign the severity of the alert when it's triggered. Because this is a low-level alert, let's set it to **Informational**.

1. Select the action group that will receive the alert. This group could be your support team, your security team, or any other group that needs to be alerted when the threshold conditions are met.

1. Select the type of alert you want. You can choose from a variety of alerting methods, from a simple email to text messages. Or you could link to more complex Azure resources, such as Azure functions, webhooks, or logic apps.

1. When you're satisfied with your alert, select **Create alert** to enable it.
