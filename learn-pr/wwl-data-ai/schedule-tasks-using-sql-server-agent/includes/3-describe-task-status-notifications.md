One important part of automation is providing notifications in the event of job failure or if certain system errors are encountered. SQL Server Agent provides this functionality through a group of objects. Alerting is most commonly done via email using the Database Mail functionality of SQL Server. The other agent objects that are used in this workflow are:

- Operators—alias for people or group who receives notifications.
- Notifications—notify an operator of the completion, success, or failure of a job.
- Alerts—are assigned to an operator, for either a notification or a defined error condition.

## Operators

Operators act an alias for a user or group of users that have been configured to receive notifications of job completion, or to be informed of alerts have been sent to the error log. An operator is defined as an operator name and contact information. Typically, an operator will map to a group of people using an email group. Having multiple people in the email group provides redundancy so that a notification is not missed if someone is unavailable. Groups are also beneficial if an employee leaves the organization; the single person can be removed from the email group and you do not have to update all of your instances. To send email to an operator, you need to enable the email profile of the SQL Server Agent as shown below:

:::image type="content" source="../media/module-66-automation-final-08.png" alt-text="SQL Server Agent Mail Profile Configuration":::

## Notifications

Notification of completion is part of each SQL Server Agent job. You have the option of sending a notification on Job completion, failure, or success. Most DBAs notify on failure only, to avoid an influx of notifications for successful jobs. Notifications have a dependency on an operator existing in order to send a notification as shown below:

:::image type="content" source="../media/module-66-automation-final-09.png" alt-text="Assigning a Notification recipient for Job Failure":::

## Alerts

SQL Server Agent alerts allow you to be proactive with monitoring of your SQL Server. The agent reads the SQL Server error log and when it finds an error number for which an alert has been defined, it notifies an operator. In addition to monitoring the SQL Server error log, you can set up alerts to monitor SQL Server Performance conditions, as well as Windows Management Instrumentation (WMI) events. You can specify an alert to be raised in response to one or more events. A common pattern is to raise an alert on all SQL Server errors of level 16 and higher, and then add alerts for specific event types related to critical storage errors or Availability Group failover. Another example would be to alert on performance conditions such as high CPU utilization or low Page Life Expectancy.

Another common use case for alerts is that DBAs may want to be notified in the event of certain server conditions. For example, if CPU utilization is over 90% for a period of five minutes, or Page Life Expectancy drops below a certain value. This is accomplished by creating performance condition alerts. These conditions are based on the Windows Performance Monitor (perfmon) metrics that are tracked within the SQL Server database engine. You can reach the screen shown below by right-clicking **SQL Server Agent** (if it is running) and choosing **New|Alert**.

:::image type="content" source="../media/module-66-automation-final-10.png" alt-text="SQL Server Agent Metric Alert Configuration":::

You have options for how to respond to the performance condition — you can notify an operator via email, which is the most common approach, or you can execute another SQL Server Agent job, which could resolve the problem. Executing another SQL Server Agent job is most commonly used in the scenario where the condition is well-known, and easily handled without manual intervention. A good example of this would be to create an alert on for SQL Server storage error conditions (errors 823, 824, 825), and then to execute a job to perform a database consistency check. The notifications for these alerts use the same SQL Server Agent subsystem.
