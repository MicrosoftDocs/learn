::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8fc39a20-a68b-482d-9cb6-f9af49eb386b]

::: zone-end

::: zone pivot="text"

Every Azure Cosmos DB for NoSQL workload balances throughput costs and read guarantees. Reserve too much throughput and you pay for idle capacity. Reserve too little and requests get rate-limited. Strong and bounded staleness reads cost more request units than weaker reads, and strong consistency across regions adds write latency.

Consider a developer at Contoso who has to size a new container. Traffic arrives in unpredictable spikes, some reads tolerate stale data while others can't, and records lose value after a fixed window. Before the container reaches production, the developer needs to estimate its request-unit consumption, pick a throughput model and a consistency level, and set a retention policy.

You work through those same decisions here. You estimate request units, then choose between provisioned and serverless and between standard and autoscale throughput. You provision that throughput at the database or container level, compare the five consistency levels, and configure time to live.

By the end of this module, you can evaluate throughput and consistency requirements and configure Azure Cosmos DB account and container settings that balance cost and performance.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
