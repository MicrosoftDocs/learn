As an IT administrator, you want to know how your identity and access management (IAM) environment is doing. The information about your system’s health enables you to assess whether and how you need to respond to potential issues. With the activity logs, Microsoft Entra ID provides you with a comprehensive view of activity in your environment. The provided data enables you to:

- Determine how your apps, services, and AD features are utilized by your users

- Detect potential risks affecting the health of your environment

- Troubleshoot issues preventing your users from getting their work done




<a name='azure-ad-activity-logs'></a>

## Microsoft Entra activity logs

To help you assess how your environment is doing, the Microsoft Entra admin center gives you access to three activity logs:

- **Sign-ins** – Information about sign-ins and how your resources are used by your users, services and apps.

- **Audit** – Information about changes applied to your tenant such as users and group management or updates applied to your tenant’s resources.

- **Provisioning** – Activities performed by the provisioning service, such as the creation of a group in ServiceNow or a user imported from Workday.

### Sign-in logs

Each sign-in of a user to your Microsoft Entra tenant generates a record in your sign-in log. You can use the data in your sign-in log to find answers to questions like:

- What is the sign-in pattern of a user?

- How many users have signed in over a week?

- What’s the status of these sign-ins?

- How often are apps and services used?

 
### Audit logs 

With the audit logs in Microsoft Entra ID, you get access to records of system activities for compliance. The most common views of this log are based on the following categories:

- User management

- Group management

- Application management

With a user-centric view, you can get answers to questions such as:

- What types of updates have been applied to users?

- How many users were changed?

- How many passwords were changed?

- What has an administrator done in a directory?

With a group-centric view, you can get answers to questions such as:

- What are the groups that have been added?

- Are there groups with membership changes?

- Have the owners of a group been changed?

- What licenses have been assigned to a group or a user?

With an application-centric view, you can get answers to questions such as:

- What applications have been added or updated?

- What applications have been removed?

- Has a service principal for an application changed?

- Have the names of applications been changed?

- Who gave consent to an application?



### Provisioning logs

You can use the provisioning logs to find answers to questions like:

- What groups were successfully created in ServiceNow?

- What users were successfully removed from Adobe?

- What users from Workday were successfully created in Active Directory?




## How to access activity logs 

To cover a broad range of scenarios, Microsoft Entra ID provides you with various options to work with your activity log data. As an IT administrator, you need to understand the intended uses cases for these options, so that you can select the right access method for your scenario.

There are three options you have to access your activity logs:

- Through the Azure portal
- From code
- From a different endpoint

### Access through Azure portal 

You can access activity logs in the **Monitoring** section of the **Microsoft Entra ID** Page in the Azure portal. 


:::image type="content" source="../media/activity-logs-azure-portal.png" alt-text="Screenshot that shows the location of the activity logs.":::


Accessing activity logs through the Azure portal is helpful if you need to review a few entries. For example, you need to investigate a small set of sign-ins caused by a user or app over a short period. Investigating a single sign-in includes scenarios, in which you need to:

- Do a quick investigation of a single user over a limited scope. For example, a user may report having trouble signing in when they began work. You can look at the user's sign-in activity within an hour of when the user reported the issue.

- Quickly look through a set of related events. For example, comparing device details from a series of sign-ins from the same user.

To customize how the Azure portal renders your data, you can:

- Modify the displayed columns

    :::image type="content" source="../media/column-picker-activity-log.png" alt-text="Screenshot that shows the columns picker.":::

- Set filters 
    
    :::image type="content" source="../media/filter-picker-activity-log.png" alt-text="Screenshot that shows the filter picker.":::



The Azure portal also provides you with an option to download your activity logs as JSON or CSV.



### Access from code

The right access method for accessing activity logs from code depends on the scope of your project. One option you have is to access your activity logs from the Microsoft Graph API.

The **Microsoft Graph API**:

- Provides a RESTful way to query sign-in data from Microsoft Entra ID in Microsoft Entra ID P1 or P2 tenants.

- Doesn't require an administrator or developer to set up extra infrastructure to support your script or app.

- Is **not** designed for pulling large amounts of activity data. Pulling large amounts of activity data using the API leads to issues with pagination, performance, and throttling.
 
Another method for accessing activity logs from your code is to use Azure Event Hubs. An Azure Event Hub is a big data streaming platform and event ingestion service. It can receive and process millions of events per second. Data sent to an Event Hub can be transformed and stored by using any real-time analytics provider or batching/storage adapters.

**Use:**

- **The Microsoft Graph API** - For scoped queries (a limited set of users or time). For more information, see access Microsoft Entra logs with the Microsoft Graph API.

- **Azure Event Hubs** - For pulling large sets of sign-in data. 

### Access from a different endpoint

If you can't solve your business problems by accessing your activity logs through the portal, or code, the solution might be using a different endpoint.
Microsoft Entra ID provides support for activity logs in the following three endpoints:

- **Azure storage account** - To create a long-term backup of your activity logs.

- **Microsoft Sentinel** – To integrate your activity logs with the Sentinel SIEM using the native Sentinel connector to Microsoft Entra ID.  

- **Azure Event Hub** - To integrate your activity logs with SIEM tools such as Sumologic, or Splunk.

- **Azure Log Analytics workspace** -  To analyze the data, create dashboard and alert on specific events.


To access your activity logs from a different endpoint, you need to route your logs to the endpoint, first.


#### Route logs to storage account

By routing logs to an Azure storage account, you can retain it for longer than the default retention period outlined in our retention policies. Learn how to route data to your storage account.

#### Send logs to Microsoft Sentinel

Microsoft Sentinel is a SIEM tool that provides advanced log analysis across enterprise workloads, including Microsoft Entra ID. Sentinel’s native connector with Microsoft Entra ID makes transferring data from Microsoft Entra simple. It can combine your Microsoft Entra ID log data with telemetry from across your enterprise for analysis, threat hunting, and security detections.  


#### Stream logs to Event Hubs

Routing logs to an Azure Event Hub allows you to integrate with third-party SIEM tools like Sumologic and Splunk. This integration allows you to combine Microsoft Entra activity log data with other data managed by your SIEM, to provide richer insights into your environment.

#### Send logs to Azure Monitor logs

Azure Monitor logs is a solution that consolidates monitoring data from different sources and provides a query language and analytics engine that gives you insights into the operation of your applications and resources. By sending Microsoft Entra activity logs to Azure Monitor logs, you can quickly retrieve, monitor and alert on collected data.

You can also install the pre-built views for Microsoft Entra activity logs to monitor common scenarios involving sign-ins and audit events.



## Summary

Using the activity logs, you can get an understanding of how your Microsoft Entra ID is doing. For basic scenarios, accessing your activity logs in the Azure portal, or by code might be good enough. For advanced analysis and reporting, you need to route your logs to a remote endpoint.
