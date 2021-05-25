## What are extended events and why do I need to know about them?

Extended events are a lightweight and very extensive diagnostic system that is built into SQL Server and Azure SQL Database and managed instance. Extended events allow you to collect additional information about the internal operations of your databases. Historically, DBAs used a tool call Profiler to trace inbound queries and gather execution plans to identity to problematic queries and their execution plans. Extended events build on the functionality of SQL Server Profiler by allowing you to trace queries and by exposing additional data (events) that you can monitor. Some examples of issues you might troubleshoot with Extended Events include:

- Troubleshooting blocking and deadlocking performance issues
- Identifying long-running queries
- Monitoring Data Definition Language (DDL) operations
- Logging missing column statistics
- Observing Memory Pressure in your database
- Long-running physical I/O operations

The extended event framework also allows you to use filters to limit the amount of data you collect in order to reduce the overhead of data collection, and allows you to more easily identify your performance problem by targeting your focus onto specific areas.

## What can I monitor with extended events?

Extended events cover the full surface area of SQL Server, and are divided into four channels, which define the audience of an event.

- **Admin** - Admin events are targeted for end users and administrators. The events included indicate a problem within a well-defined set of actions an administrator can take. An example of this is the generation of an XML deadlock report to help identity the root cause of the deadlock.
- **Operational** - Operational events are used for analysis and diagnostics or common problems. These events can be used to trigger an action or task based on an occurrence of the event. An example of an operational event would be a database in an availability group changing state, which would indicate a failover.
- **Analytic** - Analytic events are typically related to performance events and are published in high volume. Tracing stored procedure or query execution would be an example of an analytic event.
- **Debug** - Debug events are not necessarily fully documented and you should only use them when troubleshooting in conjunction with Microsoft support.

Events are added to sessions, which can host multiple events. Typically, multiple events are grouped together in a session to capture a related set of information.
