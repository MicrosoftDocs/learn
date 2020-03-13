Azure provides advanced logging that lets you see the users who logged into your system, and what they did while connected. You've seen how to access the sign-in and audit logs, and how you might use them to search for unexpected behavior.  Having access to this data is a significant first step in protecting your network, assets, and resources. Gathering the log files and processing them can be labor-intensive. This process might identify suspicious behavior after the event but still doesn't meet your security team's need for a real-time view of user behavior.

Azure Monitor can provide real-time views and alerting that your security team needs.  To reassure your team, you want to learn more about Azure Monitor and how it's used to identify suspicious sign-in behavior.

In this unit, you'll set up a Log Analytics workspace to hold and store the audit and sign-in log data. Then you'll learn how to send the log files to Azure Monitor. Finally, you'll see how to create Azure Monitor alerts to notify when there's suspicious user behavior or activities.

## Prerequisites

To use the Log Analytics workspace and Azure Monitor Logs, you'll need to make sure you have the following available or set up:

- Access to the Log Analytics workspace
- Access to Azure Monitor Logs
- Access to the Azure Active Directory diagnostic settings
- An Azure AD Premium 1, or Premium 2 subscription
- Any of the following Azure AD roles:
  - Security Administrator
  - Security Reader
  - Report Reader
  - Global Administrator

## The Log Analytics workspace

You know that Azure collects user data in the form of audit and sign-in log files, but it can't be directly imported into Azure Monitor.  First, the data needs to be gathered in a Log Analytics workspace.  Each workspace is unique and has its own data repository and configuration. When you configure the workspace, you can analyze the data using log searches and table-based queries.

Creating a Log Analytics workspace is straightforward.

1. Log into your Azure portal or Sandbox instance.
1. Select **all service**, and in the search field, enter **log analytics**.
1. Select **Log Analytics workspaces**, and choose the **Add** option to create a new Log Analytics workspace. To create a new Log Analytics workspace, you'll need to supply some details.
   - Select **Create New**, because this workspace will be unique to the user logging. Each workspace needs a **name** that's globally unique across any Azure Monitor subscriptions.
   - Now select the subscription the workspace will use, such as an existing **Resource group**.
   - The pricing tier is automatically assigned as **pay-as-you-go** and is based on a per GB cost.
1. When you've added all the details, select **Ok** to create the workspace.

You've now created a Log Analytics workspace where you can gather and do analytics on your user audit and sign-in data.

### Storage sizes for activity logs

It's important to understand how much storage your workspace is likely to consume. A typical sign-in event log is around 4 KB in size, and the audit log takes up about 2 KB. To put that into some perspective, if your tenant had 1,000 users, then your audit log would generate around 15,000 events each day. There would be a daily storage volume of around 30 MB per day, or 900 MB per month. The numbers are a little larger for the sign-in logs. Assuming an Azure tenant of 1,000 users, the sign-in logs will generate 34,800 events a day, which is around 140 MB per day, or 4 GB of storage a month.

## Sending user logs to the Log Analytics workspace

Now you've created a Log Analytics workspace, you assign the user audit and sign-in logs. All data you want to use in Azure Monitor Logs must be stored in a Log Analytics workspace.

To stream the audit and sign-in logs to your Log Analytics workspace, you'll need to:

1. Open your Azure Active Directory.
1. Under the **Monitoring** section, select **Diagnostic settings**.
1. From this page, you need to set the diagnostic setting. This is where you'll create the connection between the log files and your Log Analytics workspace. Each diagnostic setting needs a name.  You check the **Send to Log Analytics** option, and then specify or create a Log Analytics workspace. In this case, you'd select the Log Analytics workspace you created previously. Lastly, you'd need to:
   - Select the **Configure** option and select the Log Analytics workspace you created earlier.
   - Finally, you decide which of the log files you want to stream to the workspace. You select from Audit log and Sign-up logs, or both.
1. Select **Save** when you're done.  

You've now set up a data streaming process that will push audit and sign-in data to the Log Analytics workspace. Because this is a new service, it will take about 15 minutes for any data to appear in the workspace.

## Analyze the log files in Azure Monitor Logs

You've set up your Log Analytics workspace to receive user activity data. Now you can use the power of Azure Monitor Logs to look at activity within your environment. Azure Monitor Logs lets you query your data to spot trends, specific events, or correlate multiple data sources.  

### Log Data Schemas

The data streams for both the audit and sign-in logs are stored in your Log Analytics workspace in two separate tables, **AuditLogs** and **SignInLogs**, respectively.  Each table has its own schema you use to query against.

| Audit Log Schema   | Sign-in Log Schema        |
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

### Writing activity log queries

With the audit logs stored in your workspace tables, you can now run queries against them. There are two types of query you can write, table-based and search. The schema structures in the previous section show you all the fields you can query against.

The query language used here is Kusto.  It's designed to process data and return a result set.

Each Kusto query follows a common pattern:

- The query always starts with the name of the table you're running the query against.  Here, that name would be either **SignInLogs** or **AuditLogs**.
- Every command is separated by a pipe (|), and typically begins on a new line. You can have multiple pipes in a query.

Unless you nominate specific columns, the result set you see will contain all schema fields.

The **where** command is the most common means of filtering the data in your query.  When writing a condition to filter your data, the following expressions are valid:

| Expression  | Description                                       | Example                                                    |
| :---------- | :------------------------------------------------ | :--------------------------------------------------------- |
| ==          | Check equality (case-sensitive)                   | `Level == 8`                                               |
| =~          | Check equality (case-insensitive)                 | `EventSourceName =~ "microsoft-windows-security-auditing"` |
| !=, <>      | Check inequality (both expressions are identical) | `Level != 4`                                               |
| *and*, *or* | Required between conditions                       | `Level == 16 or CommandLine != ""`                         |

Other common filter commands include:

| Command                            | Description                                                   | example                                                      |
| ---------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| take *n*                           | ideally suited to small result sets. Take will return *n* rows from the result set in no particular order. | AuditLogs \| Take 10                                         |
| top *n* by *field*                 | Use this filter command to return the top *n* rows, sorted by the nominated *field*. | AuditLogs \| Top 10 by timeGenerated                         |
| sort by *field* (desc)             | If you just want to sort the result set, you can use the sort command. You'll need to specify the field to sort on. Then you can optionally add the *desc* instruction to specify a descending sort pattern. | AuditLogs \| Sort by timeGenerated desc                      |
| Where *field* (expression) *value* | This is the principle filtering command.  You nominate the field, expression, and comparator value.  You can stack multiple where commands, each separated by a pipe. | AuditLogs \| where CreatedDataTime >= ago(2d)                |
| project *fields*                   | If you want to restrict the result set to view only nominated fields/columns, you can use the project command with a comma-separated list of the fields. | AuditLogs \| project timeGenerated, OperationName, ResourceGroup, Result |

There are many other commands you can use to build your queries. Check the Microsoft docs pages for more details on query commands you can use to filter your data.

#### An example sign-in query

Suppose you wanted to know the most used applications requested and signed in to over the last week. Your query would look something like this:

```SQL
SigninLogs
| where CreatedDataTime >= ago(7d)
| summarize signInCount = count() by AppDisplayName
| sort by signInCount desc
```

Or, if you wanted to see how many of your users were flagged as risky in the last fortnight, you'd use:

```SQL
SigninLogs
| where CreatedDataTime >= ago(14d)
| where isRisky == true
```

#### An example audit query

Now suppose you wanted to know the most common user event for the last week. You'd use a query like this:

```SQL
AuditLogs
| where TimeGenerated >= ago(7d)
| summarize auditCount = count() by OperationName
| sort by auditCount desc
```

## Creating alerts from your activity log data

Alerts aren't dissimilar to queries, the principle difference being that they run automatically. You can set a threshold against the result set, and if it's met, trigger an alert to let you know about it.

To get started, select the **Set alert** option from the menu bar.

![screenshot showing the set alert option](../media/3-set-query-alert.png)

The **Create rule** page will open.

Suppose you want to be alerted when more than 10 applications are used in the past week.

You'd run the following query:

```SQL
SignInLogs
| where CreatedDateTime >= ao(7d)
| summarize signInCount = count() by AppDisplayName
| sort by signInCount desc
```

Because this is an alert, you'll need to indicate how often the query will be run against the data. You can specify down to the minute, but you should consider the volume of data, and the time it takes to run the query.

Next, you assign the alert logic to specify the threshold limits that will trigger the alert.

| Field     | Value                 |
| --------- | --------------------- |
| Based On  | **Number of results** |
| Condition | **Greater than**      |
| Threshold | **10**                |

You'll give the alert a name, description, and severity of the alert when it's triggered. Because this is a low-level alert, we'll set it to **Informational**.

Next, select the action group that will receive the alert.  This group could be your support team, your security team, or anyone else that needs to be alerted when the threshold conditions are met.

Lastly, select the type of alert you want. You can choose a number of different alerting methods, from a simple email to text messages. Or you could link to more complex Azure resources like Azure functions, webhooks, or logic apps.

When you're satisfied with your alert, select the **Create alert** option to enable it.
