Database systems need regular maintenance, which includes tasks like making backups and updating statistics. Maintenance may also include regularly scheduled jobs that execute against a database. Some common examples of these jobs would be to extract, transform, and load data from a transaction processing system into a data warehouse. In SQL Server and Azure SQL managed instance, the SQL Server Agent service allows you to schedule jobs to perform these maintenance tasks (as well as providing other management functions). For Azure SQL Database and Azure Database for MariaDB/MySQL/Postgres, there are other options available for scheduling maintenance operations, including Azure automation.

One of the ways you can benefit from Azure is using the built-in resource monitoring that the platform provides. You can also take advantage of the options that the Azure platform offers for handling and responding to events. It’s also important to understand SQL Server’s event handling system, called extended events, and to be familiar with how you can leverage it to perform extensive monitoring of your systems.

## Learning objectives

At the end of this module, you will understand:

- What maintenance activities you should perform on your databases
- How to configure notifications and alerts on SQL Server Agent jobs and SQL Server
- How to monitor for server/database configuration changes with Extended Events
- How to use extended events for performance analysis 
 