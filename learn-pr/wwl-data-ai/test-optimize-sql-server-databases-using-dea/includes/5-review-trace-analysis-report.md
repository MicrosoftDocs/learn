The trace analysis report gives you information on how queries have improved or degraded between the two versions. The report also highlights any errors where the **Microsoft Database Experimentation Assistant (DEA)** was unable to evaluate the changes.

You support a customer call center application, and have used the DEA to run a capture on the database during typically heavy activity. After twice restoring the backup of the call center database, you've upgraded one of the backups to SQL Server 2019. Then you used DEA to run the capture on the two target servers.

Management requires evidence that the call center database won't suffer reduced performance after the upgrade. You want to provide a report that shows how the queries will function on SQL Server 2019.

In this unit, you'll look at how to use the analysis report in the DEA.

## Reviewing a trace analysis report

You run a trace on the **Target 1** server, which is the restored backup of the source database where the trace was run. Then you run the same trace on **Target 2**, which has the applied change. When you replay a trace on a target, DEA gathers event statistics. You can then tell DEA the two targets to compare, and it generates an analysis report.

To generate a new report, you must first connect to the SQL Server instance where the report will be stored. Then you name the report and the path for the trace files from replaying the captures on the two targets. DEA creates an analysis report based on the **A/B test**, which was the change you applied to Target 2.

The first page of the report displays the instance name and version of the two target servers. You can set the threshold for determining the performance variance between the servers. By default, the threshold is set to **5%**. The lower the value of the threshold, the more sensitive the results. The threshold determines whether a query is improved or degraded. For example, if a query is 5% or more faster on Target 2, it's considered a performance improvement. Conversely, if the query is slower by 5% or more, than the query is considered degraded.

On this page, there are also two pie charts that represent the performance difference between the two targets, based on execution count, and distinct queries. The threshold is then used to statistically grade the queries into the following categories:

- **Improved**: the query did better on Target 2 than Target 1.
- **Degraded**: the query did worse on Target 2 than Target 1.
- **Same**: no difference between Target 1 and Target 2.
- **Cannot Evaluate**: the size of the sample isn't enough for statistical analysis. The query was executed less than 30 times on each target.
- **Error**: the query threw an error on one of the targets and didn't complete.

These categories form the slices of the pie charts. You click on a slice to drill into the performance metrics. The drill-down page for each category lists the queries in that category. The error page includes the following sections:

- **New Errors**: errors that appeared on Target 2, but not Target 1.
- **Existing Errors**: errors that appeared on both targets.
- **Resolved Errors**: errors that appeared on Target 1, but not on Target 2.

Click a query to reach the **Comparison Summary** page. You'll see the number of executions, mean duration, mean CPU, mean reads/writes, and error count. The **Query Plan Information** tab provides details on the plans used for Target 1 and Target 2.

If you want to save the results, print the current page in the report.

## Key steps for using a trace analysis report

1. In the DEA, select **Analysis Reports**, then provide a server name, and authentication method.
1. Select **+ New analysis report** to create a new analysis report, and provide a name for the report.
1. Browse and select the Target 1 and Target 2 trace files.
1. Start the analysis.
1. You can now view the completed report.

Choosing the DEA as the A/B testing solution for your SQL Server change gives useful and extensive information for comparing the change between the source and target environments. After running your capture on the source and target, DEA uses the gathered metrics to create a detailed comparison of the performance of each query. Use the threshold setting to set the sensitivity of the report breakdown. You might have some databases that need a greater improvement than others.

DEA quickly shows you whether each query has improved or degraded performance on the target. DEA helps to highlight queries that error on the target. Even if improved performance isn't vital, broken code that would cause an application to fail can be fixed in advance. The DEA delivers an advance insight into the outcome of implementing a change, without you having to deploy that change directly into production, and then hoping for the best.