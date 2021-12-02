In this module, you learned how the Database Experimentation Assistant (DEA) builds on the Distributed Replay technology to deliver a complete solution for running and analyzing an A/B test.

You saw how to use the DEA to capture a workload on your production server and gather the typical queries that would run under normal operation. These queries are stored in a trace file. You learned it's critical to back up the source database before running the capture. It's also good practice to restore the backup before proceeding. After you restore the backup to the Target 1 and Target 2 server, the single change, such as the SQL Server upgrade, is applied to Target 2.

After running the trace against the two targets, you saw how to use DEA to compare the statistics collected during this operation. You learned how to change the threshold for the comparison, and how this action affects the way queries are graded. DEA provides a summary report that compares the results of running the trace on the two targets. You saw how to identify queries with improved or degraded performance, and the ones that had errors.

The DEA is an essential tool that determines the outcome of applying a single change to a database before deploying to production. When upgrading your databases, improved performance isn't guaranteed, because of changes in the Cardinality Estimator since SQL Server 2014. Using DEA to test the consequences in advance enables you to plan required fixes and changes before the upgraded database goes into production. DEA is also helpful for testing additions or alterations to your databases. You can add a new index or rewrite an under-performing query. DEA also helps you experiment on an isolated database, without affecting production systems.

## Further reading

- [Download the Database Experimentation Assistant](https://www.microsoft.com/download/details.aspx?id=54090)
- [Overview of Database Experimentation Assistant](/sql/dea/database-experimentation-assistant-overview)