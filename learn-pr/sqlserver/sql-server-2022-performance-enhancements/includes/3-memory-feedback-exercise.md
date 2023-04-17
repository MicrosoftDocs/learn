<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: none

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-exercise-unit-introduction-format)
-->
## Exercise - Memory Grant Feedback Persistence in SQL Server 2022

>This exercise will be leveraging the following githib repository:
>
>[sqlworkshops-sql2022workshop/sql2022workshop at main ·
>microsoft/sqlworkshops-sql2022workshop ·
>GitHub](https://github.com/microsoft/sqlworkshops-sql2022workshop/tree/main/sql2022workshop)
>
>Before continuing with the exercise access lab ensure that the pre-requisites have been completed and setup has been completed.
>
> ## Prerequisites
>SQL Server 2022 Evaluation or Developer Edition
>VM or computer with at min 2 CPUs and 8Gb RAM.
>Install SQL Server Management Studio (SSMS) latest 18 or 19 build from https://aka.ms/ssms18 or https://aka.ms/ssms19 
>
>## Setup the exercise
>Create a directory called c:\sql_sample_databases to store backups and files.
>
>Download the customized WideWorldImportersDW database backup from https://aka.ms/wwidw_mgf and copy it into c:\sql_sample_databases directory.
>
>Note: If you try to restore the default sample WideWorldImportersDW you can use the extendwwidw.sql script to customize the database for the exercise.
>
>Restore this database to your SQL Server 2022 instance. You can use the provided restorewwi.sql script. You may need to change the directory paths for the location of your >backup and where you will restore the database files.
>
>IMPORTANT: If you have permission issues to restore the backup you can try to copy the backup into the default "data" folder for your SQL Server installation and try the >restore again. You will need to edit the restorewwi.sql script accordingly. The default for most instances is C:\Program Files\Microsoft SQL Server\MSSQL16.>MSSQLSERVER\MSSQL\DATA
>
>Execute the script setup.sql from SSMS. This will ensure the WideWorldImporters database is at dbcompat 150 and clear the query store.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise

    Heading: a separate heading is optional; you can combine this with the topic sentence into a single paragraph

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
In this exercise you will learn how to see how memory grant feedback can improve query performance automatically including persisting feedback to the Query Store.

## Scenario

As a database administrator for World Wide Importers Corporation you need to understand how Memory Grant feedback is different in SQL 2022 than in previous versions.  To understand this we will simulate an out of date statistics exercise.  Then we will review the persistance of the Memory Grant Feedback that is new to SQL Server 2022 and requires the Query Data Store.

## Exercise 1

In order to evaluate Persisted Memory Grant Feedback we first need to simulate creating out of date statistics on a table.  To do this we will execute the set_stats.sql script in SSMS or execute the following script in SSMS.

![set_stats.sql](../media/mgf/Exercise%201/01%20Exercise.png)

```sql
USE WideWorldImportersDW;
GO
UPDATE STATISTICS Fact.OrderHistory 
WITH ROWCOUNT = 1000;
GO
```

Now that the statistics are out of date, we can execute our query to determine the effect this has on performance.  Open the script execute_query.sql in SSMS or execute the following script in SSMS.  Before executing the script make sure to include the actual execution plan.  This will take around 30 to 45 seconds to run.

![execute_query.sql](../media/mgf/Exercise%201/02%20Exercise.png)

```sql
USE WideWorldImportersDW;
GO
SELECT fo.[Order Key], fo.Description, si.[Lead Time Days]
FROM  Fact.OrderHistory AS fo
INNER HASH JOIN Dimension.[Stock Item] AS si 
ON fo.[Stock Item Key] = si.[Stock Item Key]
WHERE fo.[Lineage Key] = 9
AND si.[Lead Time Days] > 19;
GO
```
![Include the actual execution plan](../media/mgf/Exercise%201/03%20Exercise.png)

When the query returns select the Execution Plan tab.  Notice the yellow warning on the hash join operator.  Hover over the Hash Match operator on the query plan.  

![Actual vs. Estimated Rows](../media/mgf/Exercise%201/04%20Exercise.png)

Our script which did not do a full scan of statistics lead to an inaccurate estimate of the number of rows the query would return.  The query estimated 52.8634 and we actually returned 66,416 rows.

Note that this also caused 52008 pages, each 8 KB in size totalling up to over 400 MB, to spill and be read from the tempdb.

Now let's hover over the SELECT operator in the query plan. 

![Memory Grant](../media/mgf/Exercise%201/05%20Exercise.png)

The Memory Grant for this query was around 1.4 MB which is far short of the more than 400 MB that was spilled to tempdb.  Right click on the SELECT operator and select properties.

![Memory Grant](../media/mgf/Exercise%201/06%20Exercise.png)

![Memory Grant](../media/mgf/Exercise%201/07%20Exercise.png)

Notice that <b>IsMemoryGrangFeedbackAdjusted</b> = <b>NoFirstExecution</b>.  This means no adjustment has been made since there is no feedback and they query was just compiled. The "used" memory is only the memory used as part of the grant and does not account for the spill.

We can query the Query Data Store in order to find.  Open script get_plan_feedback.sql and execute the script in SSMS or execute the following script in SSMS.

![get_plan_feedback](../media/mgf/Exercise%201/08%20Exercise.png)

```sql
USE WideWorldImportersDW;
GO
SELECT qpf.feature_desc, qpf.feedback_data, qpf.state_desc, qt.query_sql_text, (qrs.last_query_max_used_memory * 8192)/1024 as last_query_memory_kb 
FROM sys.query_store_plan_feedback qpf
JOIN sys.query_store_plan qp
ON qpf.plan_id = qp.plan_id
JOIN sys.query_store_query qq
ON qp.query_id = qq.query_id
JOIN sys.query_store_query_text qt
ON qq.query_text_id = qt.query_text_id
JOIN sys.query_store_runtime_stats qrs
ON qp.plan_id = qrs.plan_id;
GO
```

Looking at the output you will see that feedback has been stored to allocate a significantly larger memory grant on the next execution than was used on our previous execution.

![QDS Memory Grant Feedback](../media/mgf/Exercise%201/09%20Exercise.png)

Now that the Query Data Store has this feedback we should run the execute_query.sql script or execute the following script in SSMS.  

```sql
USE WideWorldImportersDW;
GO
SELECT fo.[Order Key], fo.Description, si.[Lead Time Days]
FROM  Fact.OrderHistory AS fo
INNER HASH JOIN Dimension.[Stock Item] AS si 
ON fo.[Stock Item Key] = si.[Stock Item Key]
WHERE fo.[Lineage Key] = 9
AND si.[Lead Time Days] > 19;
GO
```

Notice it should have run significantly quicker than last time. 

After executing the query we should see if we have any further feedback updates run get_plan_feedback.sql again in SSMS or execute the following script in SSMS. 
```sql
USE WideWorldImportersDW;
GO
SELECT qpf.feature_desc, qpf.feedback_data, qpf.state_desc, qt.query_sql_text, (qrs.last_query_max_used_memory * 8192)/1024 as last_query_memory_kb 
FROM sys.query_store_plan_feedback qpf
JOIN sys.query_store_plan qp
ON qpf.plan_id = qp.plan_id
JOIN sys.query_store_query qq
ON qp.query_id = qq.query_id
JOIN sys.query_store_query_text qt
ON qq.query_text_id = qt.query_text_id
JOIN sys.query_store_runtime_stats qrs
ON qp.plan_id = qrs.plan_id;
GO
```

![QDS Memory Grant Feedback](../media/mgf/Exercise%201/10%20Exercise.png)

Notice that the Memory Grant utilized is now significantly more than the previous run.

## Exercise 2

SQL Server 2022's feature we are reviewing is Memory Grant Feedback Persistance.  Now that we have tested the Memory Grant, you want to test the persistance.

To do this we will clear the plan cache and prior to SQL Server 2022, this would have "lost" the Memory Grant Feedback. Open clear_proc_cache.sql in SSMS or execute the following script in SSMS.

![QDS Memory Grant Feedback](../media/mgf/Exercise%202/01%20Exercise.png)

```sql
USE [WideWorldImportersDW];
GO
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
GO
```
Run the execute_query.sql script or execute the following script in SSMS.  

```sql
USE WideWorldImportersDW;
GO
SELECT fo.[Order Key], fo.Description, si.[Lead Time Days]
FROM  Fact.OrderHistory AS fo
INNER HASH JOIN Dimension.[Stock Item] AS si 
ON fo.[Stock Item Key] = si.[Stock Item Key]
WHERE fo.[Lineage Key] = 9
AND si.[Lead Time Days] > 19;
GO
```

The run time should still be as quick as it was in our second execution.

![QDS Memory Grant Feedback](../media/mgf/Exercise%202/02%20Exercise.png)

Notice that even though we still have an underestimation of the rows in the query, we will have the Memory Grant despite having cleared the procedure cache on the SQL Server 2022 instance.  This demonstrates the capability of Memory Grant Feedback Persistance in SQL Server 2022.

## Explore the exercise
What did you notice about the Memory Grant Feedback Persistance?  Here are a few takeaways:

 - When a query first executes with insufficient Memory Grant it is recorded and viewable in the Query Data Store
 - The second time the query runs the Memory Grant is adjusted based on the feedback from the first run
 - Even after clearing the procedure cache or restarting the SQL Server 2022 service the Memory Grant Feedback will persist 

<!-- 3. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->


<!-- 4. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->



<!-- 5. Validation -------------------------------------------------------------------------------------------

    Goal: Enables the learner to evaluate if they completed the exercise correctly. Feedback like this is critical for learning.

    Structure:
        1. A heading of "## Check your work".
        2. An introductory paragraph describing how they'll validate their work at a high level.
        3. Numbered steps (if the learner needs to perform multiple steps to verify if they were successful).
        4. Video of an expert performing the exact steps of the exercise (optional).

    Example:
         "At this point, the app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
