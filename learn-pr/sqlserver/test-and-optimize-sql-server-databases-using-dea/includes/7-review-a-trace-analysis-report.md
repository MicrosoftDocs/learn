The trace analysis report gives you information how queries have improved or degraded between the two versions. It also highlights any errors where the DEA was unable to evaluate the changes.

Suppose you support a customer call center application, and you have used the **Microsoft Database Experimentation Assistant (DEA)** to run a capture on your call center database during a time of typical heavy activity. After twice restoring the backup of the call center database, you have upgraded one of the backups to SQL Server 2017. Then you used DEA to run the capture on the two target servers.

Management has asked for evidence that the call center database will not suffer reduced performance after the upgrade, so you want to provide a report to show how the queries will perform on SQL Server 2017.

In this unit, you will look at how to use the analysis report in the Database Experimentation Assistant.

## Reviewing a trace analysis report

After running a trace on the **Target 1** server, which is the restored backup of the source database the trace was run on, you then run the same trace on **Target 2**, which has the applied change. When you replay a trace on a target, DEA gathers event statistics. You can then tell DEA the two targets to compare, and it generates an analysis report.

To generate a new report, you must first connect to the SQL Server instance where the report will be stored. Then you supply a name for the report and the path for the trace files from replaying the captures on the two targets. DEA creates an analysis report based on the **A/B test**, which was the change you applied to Target 2.

The first page of the report displays the instance name and version of the two target servers. You can set the threshold for determining the performance variance between the servers. By default, the threshold is set to **5%**. The lower the value of the threshold, the more sensitive the results. The threshold determines whether a query is improved or degraded. For example, if a query is 5% or more faster on Target 2, this is considered a performance improvement. Conversely, if the query is slower by 5% or more, than the query is considered degraded.

Also on this page are two pie charts representing the performance difference between the two targets based on execution count, and distinct queries. The threshold is then used to statistically grade the queries into the following categories:

- **Improved**: the query performed better on Target 2 than Target 1.
- **Degraded**: the query performed worse on Target 2 than Target 1.
- **Same**: no difference between Target 1 and Target 2
- **Cannot Evaluate**: the size of the sample isn't enough for statistical analysis. This means the query was executed less than 30 times on each target.
- **Error**: the query threw an error on one of the targets and didn't complete.

These categories form the slices of the pie charts, and you can click on a slice to drill into the performance metrics. The drill-down page for each category lists the queries in that category. The error page includes the following sections:

- **New Errors**: errors that appeared on Target 2, but not Target 1
- **Existing Errors**: errors that appeared on both targets
- **Resolved Errors**: errors that appeared on Target 1, but not on Target 2

Click on a query to go to the **Comparison Summary** page, to see the number of executions, mean duration, mean CPU, mean reads/writes, and error count. The **Query Plan Information** tab provides details on the plans used for Target 1 and Target 2.

You can print the current page in the report, if you want to save the results.

## Key steps for using a trace analysis report

1. In the Database Experimentation Assistant, select **Analyze traces**, provide a server name, and authentication method.
1. Select to create a new analysis report, and provide a name for the report.
1. Browse and select the Target 1 and Target 2 trace files.
1. Start the analysis.
1. You can now view the completed report.

## Summary

Choosing the Database Experimentation Assistant as the A/B testing solution for your SQL Server change, gives you useful and extensive information for comparing the change between the source and target environments. After running your capture on the source and target, DEA can use the gathered metrics to create a detailed comparison of the performance of each query. The threshold setting enables you to set the sensitivity of the report breakdown, as you may have some databases that need a greater improvement than others.

DEA quickly shows you whether each query has improved or degraded performance on the target. What is helpful is that DEA highlights queries that error on the target, so even if improved performance isn't vital, broken code that would cause an application to fail can be fixed in advance. The Database Experimentation Assistant delivers an advance insight into the outcome of implementing a change, without you having to deploy that change directly into production and then hoping for the best.
