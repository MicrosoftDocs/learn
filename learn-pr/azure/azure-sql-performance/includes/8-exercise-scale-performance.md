### Scaling Azure SQL Performance

In this exercise you will take the problem you encountered in the first exercise and improve performance by scaling more CPUs for Azure SQL Database

1. Decide options on how to scale performance

Since workload is CPU bound, one way to improve performance is to increase CPU capacity or speed. A SQL Server user would have to move to a different machine or reconfigure a VM to get more CPU capacity. In some cases, even a SQL Server administrator may not have permission to make these scaling changes or the process could take time.

For Azure, we can use ALTER DATABASE, az cli, or the portal to increase CPU capacity.

Using the Azure Portal we can see options for how you can scale for more CPU resources. Using the Overview blade for the database, select the Pricing tier current deployment.<br>

![Azure_Portal_Change_Tier](../media/Azure_Portal_Change_Tier.png)

Here you can see options for changing or scaling compute resources. For General Purpose, you can easily scale up to something like 8 vCores.<br>

![Azure_Portal_Compute_Options](../media/Azure_Portal_Compute_Options.png)

Instead of using the portal, I'll show you a different method to scale your workload.

2. Increase capacity of your Azure SQL Database

There are other methods to change the Pricing tier and one of them is with the T-SQL statement ALTER DATABASE.

>**IMPORTANT:** For this demo you must first flush the query store using the following script **flushhquerystore.sql** or T-SQL statement:

```sql
EXEC sp_query_store_flush_db;
```

- First, learn how to find out your current Pricing tier using T-SQL. The Pricing tier is also known as a *service objective*. Using SSMS, open the script **get_service_object.sql** or the T-SQL statements to find out this information (**you need to substitute in your database name**)

```sql
SELECT database_name,slo_name,cpu_limit,max_db_memory, max_db_max_size_in_mb, primary_max_log_rate,primary_group_max_io, volume_local_iops,volume_pfs_iops
FROM sys.dm_user_db_resource_governance;
GO
SELECT DATABASEPROPERTYEX('<database name>', 'ServiceObjective');
GO
```

For the current Azure SQL Database deployment, your results should look like the following:<br><br>

![service_objective_results](../media/service_objective_results.png)

Notice the term **slo_name** is also used for service objective. The term **slo** stands for *service level objective*.

The various slo_name values are not documented but you can see from the string value this database uses a General Purpose SKU with 2 vCores:

>**NOTE:** SQLDB_OP_... is the string used for Business Critical.

When you view the ALTER DATABASE documentation, notice the ability to click on your target SQL Server deployment to get the right syntax options. Click on SQL Database single database/elastic pool to see the options for Azure SQL Database. To match the compute scale you found in the portal you need the service object **'GP_Gen5_8'**

Using SSMS, run the script modify_service_objective.sql or T-SQL command:

```sql
ALTER DATABASE AdventureWorks<ID> MODIFY (SERVICE_OBJECTIVE = 'GP_Gen5_8');
```

This statement comes back immediately but the scaling of the compute resources take place in the background. A scale this small should take less than a minute and for a short period of time the database will be offline to make the change effective. You can monitor the progress of this scaling activity using the Azure Portal.<br>

![Azure_Portal_Update_In_Progress](../media/Azure_Portal_Update_In_Progress.png)

Another way to monitor the progress of a change for the service object for Azure SQL Database is to use the DMV **sys.dm_operation_status**. This DMV exposes a history of changes to the database with ALTER DATABASE to the service objective and will show active progress of the change. 

Run this query to see the output of this DMV at any point in time (You must be in the context of master):

```sql
SELECT * FROM sys.dm_operation_status;
```
Here is an example of the output of this DMV after executing the above ALTER DATABASE statement:

<table>
  <tr>
    <th>session_activity_id</th>
    <th>resource_type</th>
    <th>resource_type_desc</th>
    <th>major_resource_id</th>
    <th>minor_resource_id</th>
    <th>operation</th>
    <th>state</th>
    <th>state_desc</th>
    <th>percent_complete</th>
    <th>error_code</th>
    <th>error_desc</th>
    <th>error_severity</th>
    <th>error_state</th>
    <th>start_time</th>
    <th>last_modify_time</th>
  </tr>
  <tr>
    <td>97F9474C-0334-4FC5-BFD5-337CDD1F9A21</td>
    <td>0</td>
    <td>Database</td>
    <td>AdventureWorks0406</td>
    <td></td>
    <td>ALTER DATABASE</td>
    <td>1</td>
    <td>IN_PROGRESS</td>
    <td>0</td>
    <td>0</td>
    <td></td>
    <td>0</td>
    <td>0</td>
    <td>[date time]</td>
    <td>[date time]</td>
  </tr>
</table>

During a change for the service objective, queries are allowed against the database until the final change is implemented so an application cannot connect for a very brief period of time. For Azure SQL Database Managed Instance, a change to Tier (or SKU) will allow queries and connections but prevents all database operations like creation of new databases (in these cases operations like these will fail with the error message "**The operation could not be completed because a service tier change is in progress for managed instance '[server]' Please wait for the operation in progress to complete and try again**".)

When this is done using the queries listed above to verify the new service objective or pricing tier of 8 vCores has taken affect.

3. Run the workload again

Now that the scaling has complete, we need to see if the workload duration is faster and whether waits on CPU resources has decreased.

Run the workload again using the command **sqlworkload.cmd** that you executed in the first exercise of this module

4. Observe the new performance of the workload

- Observe DMV results

Use the same queries from the first exercise of this module to observe results from **dm_exec_requests** and **dm_db_resource_stats**.

```sql
SELECT * FROM sys.dm_db_resource_stats;
```

```sql
SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
FROM sys.dm_exec_requests er
INNER JOIN sys.dm_exec_sessions es
ON er.session_id = es.session_id
AND es.is_user_process = 1;
```

You will see there are more queries with a status of RUNNING (less RUNNABLE although this will appear some) and the avg_cpu_percent should drop to 40-60%.

- Observe the new workload duration.

The workload duration from **sqlworkload.cmd** should now be much less and somewhere ~30 seconds.

- Observe Query Store reports

Using the same techniques as the first exercise in this module, look at the **Top Resource Consuming Queries** report from SSMS:<br>

![SSMS_QDS_Top_Query_Faster](../media/SSMS_QDS_Top_Query_Faster.png)

You will now see two queries (query_id). These are the same query but show up as different query_id values in Query Store because the scale operation required a restart so the query had to be recompiled. You can see in the report the overall and average duration was significantly less.

Look also at the Query Wait Statistics report as you did in Section 4.3 Activity 1. You can see the overall average wait time for the query is less and a lower % of the overall duration. This is good indication that CPU is not as much of a resource bottleneck when the database had a lower number of vCores:<br>

![SSMS_Top_Wait_Stats_Query_Faster](../media/SSMS_Top_Wait_Stats_Query_Faster.png)

- Observe Azure Portal Compute Utilization

Look at the Overview blade again for the Compute Utilization. Notice the significant drop in overall CPU resource usage compared to the previous workload execution:<br>

![Azure_Portal_Compute_Query_Comparison.png](../media/Azure_Portal_Compute_Query_Comparison.png)

>**TIP:** If you continue to increase vCores for this database you can improve performance up to a threshold where all queries have plenty of CPU resources. This does not mean you must match the number of vCores to the number of concurrent users from your workload. In addition, you can change the Pricing Tier to use **Serverless** *Compute Tier* instead of **Provisioned** to achieve a more "auto-scaled" approach to a workload. For example, for this workload if you chose a min vCore value of 2 and max VCore value of 8, this workload would immediately scale to 8vCores.

If you used Azure Log Analytics, you would see performance differences like the following (image has been annotated)

![kusto_query_metric_cpu_percent_faster](../media/kusto_query_metric_cpu_percent_faster.png)

You will now go through another exercise where you observe a performance problem and resolve it by improving application performance.