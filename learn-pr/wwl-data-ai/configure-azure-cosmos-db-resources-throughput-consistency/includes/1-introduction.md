Every Azure Cosmos DB for NoSQL workload balances throughput costs and read guarantees. Reserve too much throughput and you pay for idle capacity. Reserve too little and requests get rate-limited. Strong and bounded staleness reads cost more request units than weaker reads, and strong consistency across regions adds write latency.

Consider a developer at Contoso that has to size a new container. Traffic arrives in unpredictable spikes, some reads tolerate stale data while others can't, and records lose value after a fixed window. Before the container reaches production, the developer needs to estimate its request-unit consumption, pick a throughput model and a consistency level, and set a retention policy.

You work through those same decisions here. You estimate request units, then choose between provisioned and serverless and between standard and autoscale throughput. You provision that throughput at the database or container level, compare the five consistency levels, and configure time to live.

By the end of this module, you can evaluate throughput and consistency requirements and configure Azure Cosmos DB account and container settings that balance cost and performance.
