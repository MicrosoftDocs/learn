Data loss occurs primarily when user accounts are compromised and then used to access confidential assets or resources on your network. Azure offers logging and auditing capabilities that can help you assess whether your users' recent behavior is consistent with their typical behavior. When user behavior deviates from normal, it's flagged as suspicious. 

Your security team members are worried about a repeat of a recent breach. They want to know what Azure features and services might help prevent it. To reassure the team, you want to learn more about what Azure offers for logging user activities and how to use logging to identify suspicious sign-in behavior.

In this unit, you'll see two approaches to monitoring user behavior. The first approach focuses on user sign-in details, which are stored in *sign-in* log files. The second approach looks at user activity while signed in. These activities are stored in *audit* files.

## Azure Active Directory logs

Azure AD captures log information for your entire Azure tenant. You can use this information in analysis and reporting. When you assess user behavior, you want to look at the activity and security logs.  

Activity logs cover all of a user's behaviors and interactions with your network and its assets. You want to pay particular attention to two types of log files:

- **Sign-in logs**: The logs hold details about all user activity and the applications that requested them.
- **Audit logs**: The logs show what a user or group did while they were signed in to your network.

Security logs represent a list of the exceptions found in the activity logs. It's important to pay attention to two key log files:

- **Risky sign-ins**: The logs hold data about user accounts where the sign-in behavior is inconsistent with earlier sign-in attempts.
- **Users flagged for risk**: The logs show all users who have been flagged as a risky user.

For the moment, though, you're interested in tracking only user sign-ins and activity logs.

## Azure sign-in log files

Sign-in log files hold a copy of all attempts to sign in to your network. The logs track only traditional sign-ins that use user credentials. The sign-in log files don't record automatic authentication that's used in server-to-server connections.

You can use sign-in log files to identify:

- Patterns of user sign-in behavior.
- Trends in user sign-in activity over time.
- The overall status of all users who access your network.

### Prerequisites

Because of the sensitive nature of log data that's captured by sign-in logs, access to the logs is reserved and limited. To use the sign-in log files, you must have:

- An Azure AD Premium or higher subscription.
- At least one user who has a Global Administrator, Report Reader, Security Reader, or Security Administrator role.

### Structure of a sign-in log file

The first time the sign-in logging service is enabled, you might not see data for up to an hour. Azure captures a wide range of data about user activity, from access periods to the application that made the request, and more.  Access the sign-in log file through the Azure portal.  

1. In the Azure portal, go to your Azure AD instance.

1. In the left menu under **Monitoring**, select **Sign-ins**.

A page similar to the following displays a typical view of the sign-in table data:

:::image type="content" source="../media/2-sign-in-activity.png" alt-text="Screenshot of the default sign-in table columns.":::

The default table columns display the following information:

- Sign-in date
- User making the sign-in request
- Application making the sign-in request
- Sign-in status
- Risk detection status
- Multifactor authentication status

As with all reporting in Azure, you can customize the report structure by adding and removing columns. To change the columns, in the menu bar, select **Columns**.

In the **Columns** pane, you can add or remove columns based on your need. In addition to the default columns, you can choose columns that display the following options:

- Request ID
- User
- User name
- IP address
- Location
- Operating system
- Device browser
- Conditional Access
- Alternate sign-in name

### Filter log data

Even after you've selected all the sign-in columns you're interested in viewing, you still have a large amount of data. To manage data volumes and to get to the data you need, you can apply filters. For example, you might want to see only sign-in records in which users have been flagged as a risk, or records in which multifactor authentication failed.  By using filters, you can view the raw data in various ways to identify trends or patterns.

To use filters, in the menu bar, select **Add filters**, and then select the filters you want to use.

![Screenshot of the "Add filters" button and the list of filters.](../media/2-sign-in-activity-filter-list.png)

Here are a few key filters and what you would use them for:

- **User**: Look for specific users, by either name or by user principal name.
- **Application**: Find sign-in requests from specific applications.
- **Status**: Narrow results to users who successfully signed or those who failed.
- **Conditional Access**: Examine whether any applicable Conditional Access policies have been applied.
- **Date**: Adjust the timeframe of the data you're looking at, from a month to a single day.

### Download the sign-in logs

You've determined which columns have the information you want, and you've applied the filters to narrow the data to a specific, manageable subset. Now you can process the data. Although Azure offers some great tools for data visualization and further analysis, you might already use specific applications to process data. With Azure, you can download the sign-in data based on your current filters.

When you download sign-in log records, you're limited to the most recent 250,000 records, based on the filter criteria that you've applied.

To download the data in your view, in the menu bar, select **Download**.

:::image type="content" source="../media/2-sign-in-change-download.png" alt-text="Screenshot of the menu bar with the Download button selected.":::

In the **Download Sign-ins** pane, select a format to use for the data, CSV or JSON. Enter a file name, and then select **Download**.

### Sign-in error codes

Analyzing failed sign-ins is key to maintaining a secure and healthy Azure environment. When you review your sign-in log files, you can filter on the status to show only failed sign-ins.  

:::image type="content" source="../media/2-sign-in-status-failure.png" alt-text="Screenshot of the Sign-in status drop-down control, with Failure selected.":::

As described earlier, when this filter is applied, the table displays only failed sign-ins.

When you select any sign-in record in the results list, you see a snapshot of the record, including sign-in status, sign-in error code, and the failure reason.  

:::image type="content" source="../media/2-sign-in-failure-codes.png" alt-text="Screenshot of a sign-in failure details pane with the error code and failure reason highlighted.":::

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

## Azure audit log files

Audit files provide a history of every task that's done in your Azure AD tenant. Audit logs are maintained for compliance. They keep records of all your system activities. Recent activities might not be included in results for up to an hour after they occur.

### Prerequisites

To access the audit log files, at least one user in your tenant must have a Global Administrator, Report Reader, Security Reader, or Security Administrator role.

### Structure of an audit log file

Access the audit logs through the Azure portal:

1. In the Azure portal, go to your Azure AD instance.

1. In the left menu under **Monitoring**, select **Audit logs**.

Like sign-in logs, you can modify audit logs to meet your specific needs. The default audit log view displays the following columns:

- Date
- Service
- Category
- Status
- Target
- Initiated By

You also can add the following columns:

- Activity
- Status Reason

### Filter the audit log results

Audit logs might contain hundreds of thousands of entries from your entire Azure environment. To manage the data volume, you can apply filters to the results to display the data you need. You can filter data in the following fields only:

- **Service**: Narrows down the services in the results. The Service field is limited to access reviews, accounts provisioning, application SSO, authentication methods, B2C, Conditional Access, core directories, entitlement management, identity protection, invited users, Privileged Identity Management (PIM), self-service group and password management, and terms of use.
- **Category**: Specifies what category of audit you want. The selection might be: administrative unit, application management, authentication, authorization, contact, device, device configuration, directory management, entitlement management, group management, policy resource management, role management, and user management.
- **Activity**: Options depend on the type of service and category you've previously selected.
- **Status**: Identifies the activity's success or failure.
- **Target**: Lets you use a target name or a user principal name.
- **Initiated by**: Lets you specify a user name or a universal principal name. Both are case-sensitive.
- **Date (range)**: Lets you specify a date range, which can vary from one month to one day.

### Download the audit log

When you've applied the filters to narrow the data to a manageable and specific subset, you can download it. When you download audit log records, you're limited to the most recent 250,000 records, based on the applied filter criteria.

In the **Download Audit Logs** pane, select a format to use for the data, CSV or JSON. Enter a file name, and then select **Download**.

### Access audit logs through users, groups, and enterprise applications

You access audit log data through your Azure AD instance. But you can also access the audit log directly through users, groups, and enterprise applications. The data is prefiltered according to the access point that's being used.  If you access the audit logs through users, you see only audit log data that's related to users. The same applies to groups and enterprise applications.

To access the user audit logs from your Azure AD instance:

1. In the left menu under **Manage**, select **Users**.

1. In the left menu under **Activity**, select **Audit logs**:

:::image type="content" source="../media/2-audit-logs-users.png" alt-text="Screenshot of the Users Audit logs option.":::

To access a group's audit logs from your Azure AD instance, select **Groups** in the left menu.
