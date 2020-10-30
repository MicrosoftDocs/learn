A common scenario that the DBA faces is when a user notifies the DBA about problems with the performance of a report or operation. Typically, this notification happens well after the problem occurs. In the past, it was difficult or impossible to retrieve data related to query execution, because the data was stored in memory caches and was very transient.

In order to gather this data with SQL Server, you needed to have a third-party tool or build a custom monitoring solution. This tool would actively collect and maintain performance information. Third-party or custom solutions are no longer necessary. In SQL Server 2016, Microsoft introduced the Query Store, which acts as a data recorder for the database engine. The Query Store is focused on query performance and changes in execution plans.

## Learning objectives

In this module, you will:

- Understand the purpose and benefits of the Query Store
- Investigate the available reports and data in the Query Store
- See the impact of forcing execution plan selection
- Learn how blocking and locking work in the SQL Server database engine
- Learn about database isolation levels
- Gain understanding of database fragmentation and its impact
