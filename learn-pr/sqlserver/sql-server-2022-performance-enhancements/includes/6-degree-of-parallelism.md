

#  Degree of Parallelism Feedback
The optimizer in SQL Server will in some cases run pieces of the query plan called operators using parallelism with multiple concurrent threads. The number of threads used for a query plan operator is called Degree of Parallelism (DOP).  
 
The degree of parallelism (DOP) with which a query is executed can greatly impact its performance. Any time a query is using parallelism, there is always the question of if it’s using the right amount of parallelism. Sometimes, if the degree of parallelism is too high, it can introduce inefficiencies into the query execution. If the degree of parallelism is too low, we may be missing out on some of the speed-up that parallelism can provide.  

SQL Server can control the maximum number of threads per operator using server, database, resource group, or query settings called max degree of parallelism or MAXDOP. Setting the right MAXDOP for a SQL Server deployment can be a complex and sometimes difficult exercise.


<!-- Pattern for complex chunks (repeat as needed) -->
### Feature overview
In SQL Server 2022, we introduced a new feature called DOP feedback. The optimizer uses DOP feedback to find the parallel efficiency for a query. Parallel efficiency is the minimum DOP for a query that can result in the same overall query duration (factoring our common waits).   This feature will look at any parallel query and determine if it might perform better with a lower degree of parallelism than currently being used. Reducing the DOP for a query can provide more threads and CPU resources for other queries of the application.  

DOP feedback never increases the degree of parallelism, at best, it will revert to a stable previous DOP, and it works incrementally, meaning instead of trying to drastically lower the degree of parallelism all at once, it will try a slightly lower degree of parallelism. Then if that’s good, it might try another slightly lower degree of parallelism. If the new, even lower degree of parallelism is good, it might try to reduce again down to the degree of parallelism of two, although it will not make a parallel plan become serial. If the new, lower DOP is not as good, we go back to the previous known good DOP and keep the query at that level.


![DOP feedback reduces the degree of parallelism in a stepwise fashion, incrementally decreasing the degree of parallelism and verifying at each step.](../media/Feedbackstep.png)



### Example
A query is compiled with a degree of parallelism of 8.  If DOP feedback detects a fair amount of wait times between threads and CPU overhead, it will suggest a lower DOP—say, 6. On the next execution, the query will execute with a DOP of 6. If the performance is better over the next several executions, the DOP of 6 will be considered stabilized. However, DOP feedback may then determine that there are still too many waits and further attempt a DOP of 4. Again, several executions are used to verify the feedback. Then, perhaps, a DOP of 2 is tried. If after several executions the DOP 2 performance is not better, then the system will return to suggesting a DOP of 4 as the most recent, stable, and verified DOP.

### DOP Feedback Architecture
:::image type="content" source="../media/DOPFeedbackarch.png" alt-text="DOP Feedback architecture.":::

DOP feedback requires the Query Store to be enabled, database compatibility level 160, and a database setting called `DOP_FEEDBACK` to be turned on.  
With these settings, the optimizer will work in coordination with Query Store background tasks to look for repetitive and long-running queries that could benefit from a lower DOP. A feedback cycle will be used to validate an adjusted query duration (factoring out waits) won't regress with a lower DOP value and that lower overall CPU is observed for the query. After a period of validation, a lower DOP is considered stabilized and will be persisted in the Query Store. The optimizer will continue to validate lower DOP values in a stepwise down fashion to find the best parallel efficiency or a minimum DOP, which is 2. DOP feedback will never increase DOP and will honor the MAXDOP setting for a query depending on server, database, resource governor, or query hint that has been applied.  



### Simple setup and easy optimization
With DOP feedback enabled, all of this is done without triggering query recompiles, and without user action.  

DOP feedback for SQL Server 2022 addresses a long-held challenge for our customers: finding the right degree of parallelism for each query without having to manually test and tweak each query for optimal performance. 



For more information, refer to Degrees of Parallelism (DOP) feedback  
https://learn.microsoft.com/en-us/sql/relational-databases/performance/intelligent-query-processing-feedback?view=sql-server-ver16#degree-of-parallelism-dop-feedback  



<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->