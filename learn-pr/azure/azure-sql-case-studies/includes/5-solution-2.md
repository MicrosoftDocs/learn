In the previous unit, you worked through a scenario that involved high availability for a 911 dispatch system. In this unit, you'll review one potential solution and some other items to consider.

As you review, you should compare the provided solution to the one that you developed in the previous unit. Often, more than one correct solution exists for any problem, but there are always tradeoffs. Which items in your solution differ from the proposed one? Is there anything in your solution you might rethink? Is there anything in the provided solution that you think is addressed more thoroughly in your solution?

## Deployment option and configuration

The first selection in addressing a scenario is often to identify which Azure SQL deployment option will potentially be the best fit. If you consider service-level agreement (SLA) alone, the requirement is for an SLA of 99.995 percent, which only Azure SQL Database can provide. To get this SLA, you must deploy the Business Critical service tier and enable the use of availability zones.

Another set of decisions is related to how to enable geo-redundancy and maintain high availability in disasters. Although geo-replication and auto-failover groups are both options here, auto-failover groups will enable the customer to fail over if it's required, without changing any connection strings. This setup can potentially help in reducing downtime to update the applications' connection strings, because it won't be needed. You can also configure monitoring queries to check the status. That way, if something goes wrong, you can even force a failover.

In this configuration, it's also important to think about the role that colocation plays. To maintain high availability, your application needs to be as close to your database as possible, certainly in the same region. You'll want to make sure your application is deployed in both regions of the auto-failover group, so a redundant copy of the application (for example, a web app) exists. If there's a failover, you can use Azure Traffic Manager to reroute traffic to the application in the secondary region.

## DBAs and sensitive data

The 911 dispatch system coordinators have expressed concern about protecting sensitive data (like health history and other personal information), while allowing DBAs to do their jobs.

To ensure that DBAs can't see sensitive data stored in specific columns and that all access to tables that contain sensitive data is monitored, you can use a few Azure SQL technologies. Using SQL Audit is a best practice to monitor access, but DBAs will still be able to see the data. Classifying the sensitive data by using Data Classification will help, because the sensitive data will be labeled and you can track it with SQL Audit. However, with these implemented, DBAs will still be able to see sensitive data. You can use dynamic data masking to help mask sensitive data, but it's not possible to keep a db_owner from viewing user data with permissions only. 

If highly sensitive data is in a database, you can use Always Encrypted to safely prevent even db_owners from seeing it. You can manage the Always Encrypted keys with role separation, so that the security admin doesn't access the database and the DBA doesn't access the physical keys in plaintext. By using this strategy in combination with monitoring through SQL Audit, you can monitor, mask, and track access to sensitive data, even from DBAs with db_owner rights.

DBAs need to have sensitive data masked, but they still need to be able to troubleshoot performance by using the Azure portal and SQL Server Management Studio or Azure Data Studio. And they need to be able to create new contained database users who must be mapped to Microsoft Entra principals. 

One solution is to create a Microsoft Entra group called SQL DBA for the DBAs on each instance. Then, assign the group to the Azure role-based access control (RBAC) role of SQL Server Contributor. Finally, you can set the group to be the Microsoft Entra admin on the logical server.
