::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=9faa805c-5dd2-4e40-9083-fb89cac4c8a8]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

A slow query during peak hours can cascade into a service outage. A poorly chosen isolation level can cause users to see stale data or block each other for seconds at a time. Performance problems in Azure SQL Database rarely have a single cause. They emerge from the interaction between hardware configuration, concurrency behavior, query execution, and workload patterns. Diagnosing these problems requires understanding each layer and knowing which tools to use at each level.

Imagine a team managing an e-commerce application on Azure SQL Database. During a holiday sale, transaction throughput drops and customers report timeouts. Is the database under-provisioned? Are queries scanning entire tables instead of seeking through indexes? Are blocking chains forming between concurrent transactions? Is the query optimizer choosing a bad plan? Each possibility requires a different investigation tool and a different resolution strategy. This module gives you the skills to work through each of those questions systematically.

After completing this module, you're able to:

- Evaluate and recommend database configurations including service tiers, compute tiers, and resource limits.
- Choose transaction isolation levels and concurrency controls that balance consistency with throughput.
- Analyze query performance using execution plans and dynamic management views.
- Monitor and tune queries with Query Store and Query Performance Insight.
- Identify and resolve blocking and deadlocks using DMVs and Extended Events.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
