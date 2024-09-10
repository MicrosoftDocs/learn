Data loss occurs primarily when user accounts are compromised and then used to access confidential assets or resources on your network. Azure offers logging and auditing capabilities that can help you assess whether your users' recent behavior is consistent with their typical behavior. When user behavior deviates from normal, it's flagged as suspicious. 

Your security team members are worried about a repeat of a recent breach. They want to know what Azure features and services might help prevent a data breach. To reassure the team, you want to learn more about what Azure offers for logging user activities and how to use logging to identify suspicious sign-in behavior.

In this unit, you'll see two approaches to monitoring user behavior. The first approach focuses on user sign-in details, which are stored in *sign-in* log files. The second approach looks at user activity while signed in. These activities are stored in *audit* files.

<a name='azure-active-directory-logs'></a>

## Microsoft Entra logs

Microsoft Entra ID captures log information for your entire Azure tenant. You can use the information in analysis and reporting. When you assess user behavior, you want to look at the activity logs and security logs that are collected for your tenant.  

Activity logs cover all of a user's behaviors and interactions with your network and its assets. You want to pay particular attention to two types of log files:

- **Sign-in logs**: Sign-in logs hold details about all user activity and the applications that requested authentication for sign-in.
- **Audit logs**: Audit logs show what a user or group did while signed in to your network.

Security logs represent a list of the exceptions found in the activity logs. It's important to pay attention to two key security log files:

- **Risky sign-ins**: Risky sign-in logs hold data about user accounts in which the sign-in behavior is inconsistent with earlier sign-in attempts.
- **Users flagged for risk**: Logs of users flagged for risk show all users who are flagged as risky users.

For the moment, though, you're interested in tracking only user sign-ins and activity logs.

## Sign-in log files

Sign-in log files hold a copy of all attempts to sign in to your network. The logs track only traditional sign-ins that used user credentials. The sign-in log files don't record automatic authentication that's used in server-to-server connections.

You can use sign-in log files to identify:

- Patterns of user sign-in behavior.
- Trends in user sign-in activity over time.
- The overall status of all users who access your network.

### Sign-in logs prerequisites

Because of the sensitive nature of log data that's captured by sign-in logs, access to the logs is reserved and limited. To use the sign-in log files, you must have:

- A Microsoft Entra ID P1 or P2 or Premium 2 subscription.
- At least one user who has a Global Administrator, Report Reader, Security Reader, or Security Administrator role.

### Sign-in logs view

Azure captures a wide range of data about user activity, from access periods to the application that made a sign-in request, and more. You access the sign-in log file in your Microsoft Entra instance in the Azure portal. The first time the sign-in logging service is enabled, you might not see data for up to an hour.

To see the sign-in logs for your tenant, in the left menu under **Monitoring**, select **Sign-in logs**. The following example displays a typical view of the sign-in table data:

:::image type="content" source="../media/sign-in-activity-concept.png" alt-text="Screenshot that shows default table columns in sign-in logs.":::

Default table columns display information like sign-in date, the user name, sign-in status, and location.

As with all reporting in Azure, you can customize the report structure by adding and removing columns. To change the columns, in the sign-in logs menu bar, select **Columns**. In the **Columns** pane, you can add or remove columns based on your needs. In addition to the default columns, you can choose columns to display more information.

:::image type="content" source="../media/columns-select-concept.png" alt-text="Screenshot that shows how to select columns to display for sign-in logs.":::

### Filter log data

Even after you've selected all the sign-in columns you're interested in viewing, you still have a large amount of data. To manage data volumes and to get to the data you need, you can apply filters. For example, you might want to see only sign-in records in which users have been flagged as a risk or records in which multifactor authentication failed. By using filters, you can view the raw data in various ways to identify trends or patterns.

To use filters, in the sign-in logs menu bar, select **Add filters**, and then select the filters you want to use.

:::image type="content" source="../media/sign-in-activity-filter-list.png" alt-text="Screenshot of the Add filters button and the list of filters.":::

Here are a few key filters and what you would use them for:

- **User**: Use to look for specific users, by either name or by user principal name.
- **Application**: Use to find sign-in requests from specific applications.
- **Status**: Use to narrow results to users who successfully signed in or to users for whom sign-in failed.
- **Conditional Access**: Use to examine whether any applicable Conditional Access policies have been applied.
- **Date**: Use to adjust the timeframe of the data you're looking at, from a month to a single day.

### Download sign-in logs

You've determined which columns have the information you want, and you've applied the filters to narrow the data to a specific, manageable subset of data. Now you can process the data. Although Azure offers some great tools for data visualization and further analysis, you might already use specific applications to process data. With Azure, you can download the sign-in data based on your current filters.

When you download sign-in logs, you're limited to the most recent 250,000 records, based on the filter criteria that you've applied.

To download the data in your view, in the sign-in logs menu bar, select **Download**. You'll select a format to use for the data, CSV or JSON, and thenenter a file name for the download file.

:::image type="content" source="../media/download-select-concept.png" alt-text="Screenshot that shows Download dialog details.":::

### Sign-in error codes

Analyzing failed sign-ins is a key way to help you maintain a secure and healthy Azure environment. When you review your sign-in log files, you can filter on the status to show only failed sign-ins:  

:::image type="content" source="../media/sign-in-status-failure-concept.png" alt-text="Screenshot that shows how to use the Sign-in status control, with Failure selected.":::

When you select any sign-in record in the results list, you see a snapshot of the record, including sign-in status, sign-in error code, and the failure reason.  

:::image type="content" source="../media/sign-in-failure-codes.png" alt-text="Screenshot of a sign-in failure details pane with the error code and failure reason highlighted.":::

In the summary unit of this module, you'll find a link to a complete list of error codes. A few example error codes and their official descriptions are listed in the following table:

| Error | Description                                                  |
| :---- | :----------------------------------------------------------- |
| 50002 | Sign-in failed because of restricted proxy access on the tenant. If it's your own tenant policy, you can change your restricted tenant settings to fix this issue. |
| 50005 | Users tried to sign in to a device from a platform that's currently not supported through Conditional Access policy. |
| 50020 | The user is unauthorized for one of the following reasons: the user is attempting to sign in with an MSA account with the v1 endpoint, or the user doesn't exist in the tenant. Contact the application owner. |
| 50055 | Invalid password entered or expired password.                  |
| 50057 | User account is disabled. The account has been disabled by an administrator. |
| 50074 | User didn't pass the multifactor authentication (MFA) challenge.                         |
| 50126 | Invalid username or password, or invalid on-premises username or password. |
| 50133 | Session is invalid because of expiration or recent password change. |
| 50173 | Fresh auth token is needed. Have the user sign in again using fresh credentials. |
| 53003 | Access has been blocked because of Conditional Access policies.  |
| 65004 | User declined to consent to access the app. Have the user retry the sign-in and consent to the app. |
| 70019 | Verification code expired. Have the user retry the sign-in.  |
| 80007 | Authentication Agent can't validate the user's password.     |
| 81007 | Tenant isn't enabled for Seamless SSO.                      |

## Audit log files

Audit files provide a history of every activity in your Microsoft Entra tenant. Audit logs are maintained for compliance and they keep records of all your system activities. Recent activities might not be included in results for up to an hour after they occur.

### Audit logs prerequisites

To access the audit log files, at least one user in your tenant must have a Global Administrator, Report Reader, Security Reader, or Security Administrator role.

### Audit logs view

Access the audit logs through your Microsoft Entra instance in the Azure portal. In the left menu under **Monitoring**, select **Audit logs**.

Like sign-in logs, you can modify audit logs to meet your specific needs. The default audit log view displays the following columns:

- Date
- Service
- Category
- Activity
- Status
- Status reason
- Target (s)
- Initiated by (actor)

You also can add the column **User Agent**.

:::image type="content" source="../media/audit-logs-columns.png" alt-text="Screenshot that shows audit log columns and options.":::

### Filter audit log results

Audit logs might contain hundreds of thousands of entries from your entire Azure environment. To manage the data volume, you can apply filters to the results to display the data you need. You can filter data in the following fields only:

- **Date**: Specify a date range, which can vary from one month to one day, or a custom interval.
- **Show dates as**: Select **Local** or **UTC**.
- **Service**: Narrow the services that are included in the results.
- **Category**: Specify what category of audit you want. For example, you might choose administrative unit or user management.
- **Activity**: Options depend on the type of service and category you've selected.
- **Status**: Filter by the activity's success or failure.

Select **Add filters** to select one of the following filters:

- **Target**: Filter on a target name or a user principal name.
- **Initiated by (actor)**: Specify a user name or a universal principal name to filter on. Both are case-sensitive.
- **User Agent**: Filter by a user agent name.

### Download audit logs

When you've applied the filters to narrow the data to a manageable and specific subset, you can download the data. When you download audit log records, you're limited to the most recent 250,000 records, based on the applied filter criteria.

Like with sign-in logs, select a format to use for the data, CSV or JSON, and then enter a file name for the download.

## Access logs through users, groups, and enterprise applications

You can access sign-in logs and audit logs that are collected for your Microsoft Entra instance through users, groups, and enterprise applications. The data is prefiltered according to the access point that's being used. If you access the logs through the users menu, you see only log data that's related to users. The same applies to groups and enterprise applications.

To access user sign-in logs or user audit logs from your Microsoft Entra instance, in the left menu under **Manage**, select **Users**. Then, under **Activity**, select the type of log you want to view.

:::image type="content" source="../media/audit-logs-users-concept.png" alt-text="Screenshot of the logs you can select through the Users menu.":::

To access a group's audit logs from your Microsoft Entra instance, select **Groups** in the left menu.
