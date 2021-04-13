Beyond proper indexing, index maintenance is in important part of performance, especially for queries which scan tables or indexes. The query optimizer utilizes statistical information from the indexes to attempt to build the most optimal execution plan. While this execution plan is usually “good enough” having healthy indexes and statistics will ensure that any given plan will perform at optimal efficiency. Index maintenance should be performed regularly as data in your databases changes over time. You could change your index maintenance strategy based on the frequency of modifications to your data.

## Rebuild and reorganize

Index fragmentation occurs when logical ordering within index pages does not match the physical ordering. Pages can out of order during routine data modification statements such as UPDATE, DELETE, and INSERT. Fragmentation can introduce performance issues because of the additional I/O that is required to locate the data that is being referenced by the pointers within the index pages.

A reorganization of an index is an online operation that will defragment the leaf level of the index (both clustered and nonclustered). This defragmentation process will physically reorder the leaf-level pages to match the logical order of the nodes from left to right. During this process, the index pages are also compacted based on the configured fillfactor value.

A rebuild can be either online or offline depending on the command executed or the edition of SQL Server being utilized. An offline rebuild process will drop and re-create the index itself. If you can do so online, a new index will be built in parallel to the existing index. Once the new index has been built, the existing one will be dropped and then the new one will be renamed to match the old index name. Keep in mind that the online version will require additional space as the new index is built in parallel to the existing index.

The common guidance for index maintenance is:

- &gt;5% but &lt;30%   Reorganize the index

- &gt;30%  Rebuild the index

Use these numbers as general recommendations, but not as hard and fast rules. Depending on your workload and data, you may need to be more aggressive, or in some cases you may be able to defer index maintenance for databases that mostly perform queries that seek specific pages.

Starting with SQL Server 2017, Microsoft introduced the ability to have resumable rebuild operations. This option provides more flexibility in controlling how much of an impact a rebuild operation might impose on a given instance. With SQL Server 2019, the ability to control an associated maximum degree of parallelism was introduced further providing more granular control to database administrators.

## SQL Server on an Azure Virtual Machine

With SQL Server being installed within an Azure virtual machine you have access to scheduling services such as the SQL Agent or the Windows Task Scheduler. These automation tools can assist in keeping the amount of fragmentation within indexes to a minimum. With larger databases, a balance between a rebuild and a reorganization of indexes must be found to ensure optimal performance. The flexibility provided by SQL Agent or Task Scheduler allows you to run custom jobs.

## Azure SQL Database

Due to the nature of Azure SQL Database, you do not have access to SQL Server Agent nor Windows Task Scheduler. Without these services, index maintenance must be controlled from outside of the database. There are three ways to manage maintenance operations:

- Azure Automation Runbooks

- SQL Agent Job from SQL Server in an Azure Virtual Machine

- Azure SQL elastic jobs

## Azure SQL managed instance

As with SQL Server on an Azure Virtual Machine, you can schedule jobs on an Azure SQL Managed Instance via the SQL Server Agent. Using the SQL Server Agent provides flexibility to execute code specifically designed to reduce fragmentation within the indexes in the database.
