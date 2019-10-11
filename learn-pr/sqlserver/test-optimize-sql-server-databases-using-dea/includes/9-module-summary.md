In this module, you learned how the Database Experimentation Assistant builds on the Distributed Replay technology to deliver a complete solution for running and analyzing an A/B test.

You saw how to use DEA to capture a workload on your production server and gather the typical queries that would run under normal operation. These queries are stored in a trace file. You learned it is critical to back up the source database before running the capture, and it's good practice to restore the backup before proceeding. After you restore the backup to the Target 1 and Target 2 server, the single change, such as the SQL Server upgrade, is applied to Target 2.

After running the trace against the two targets, you saw how to use DEA to compare the statistics collecting during this operation. You learned how to change the threshold for the comparison, and how this affects the way in which the queries are graded. DEA provides a summary report comparing the results of running the trace on the two targets, and you saw how to identify queries with improved or degraded performance, and those had errors.

The Microsoft Database Experimentation Assistant is an essential tool for determining the outcome of applying a single change to a database before deploying to production. When upgrading your databases, it isn't guaranteed the performance will be improved because of changes in the Cardinality Estimator since SQL Server 2014. Using DEA to test the consequences in advance, enables you to plan required fixes and changes before the upgraded database goes into production. Furthermore, DEA is helpful for testing additions or alterations to your databases, such as adding a new index or rewriting an under-performing query, and it enables you to experiment on an isolated database, without affecting production systems.

## Further Reading

- [Download the Data Experimentation Assistant](https://www.microsoft.com/download/details.aspx?id=54090)
- [Technical Preview: Database Experimentation Assistant](https://blogs.msdn.microsoft.com/datamigration/2016/10/24/database-experimentation-assistant-v1-0-preview/)
- [Technical Preview: Database Experimentation Assistant](https://cloudblogs.microsoft.com/sqlserver/2017/03/31/technical-preview-database-experimentation-assistant-2/)