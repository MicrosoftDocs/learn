In this module, you learned to evaluate throughput and consistency requirements and configure the account and container settings that balance cost against performance. Starting from the Contoso developer's task of sizing a container for bursty, mixed-workload traffic, you built a way to reason about these settings that transfers to your own containers.

## What you learned

- Request units (RUs) are the currency of throughput: every read, write, and query consumes RUs. You estimate a workload's request units per second (RU/s) from its operation mix and rates. Then confirm the estimate with the request charge that every response reports.
- The throughput model follows the traffic shape: provisioned for sustained, high-utilization traffic and serverless for intermittent traffic, with standard versus autoscale governing how provisioned capacity behaves.
- Throughput scope trades cost against isolation: dedicated container throughput is the recommended default because it guarantees predictable performance, while shared database throughput lowers cost for many light, similar containers at the price of per-container guarantees.
- Consistency is a five-level sliding scale from strong to eventual. You set the strongest routinely needed level as the account default and relax individual reads that tolerate staleness. A `ConsistencyLevel` override can only relax consistency, never strengthen it.
- Time to live expires data automatically at the container level, with per-item overrides, reducing storage cost and eliminating manual cleanup.

## Learn more

- [Request units in Azure Cosmos DB](/azure/cosmos-db/request-units)
- [Provision throughput on containers and databases](/azure/cosmos-db/set-throughput)
- [Choose between standard (manual) and autoscale throughput](/azure/cosmos-db/how-to-choose-offer)
- [Serverless in Azure Cosmos DB](/azure/cosmos-db/serverless)
- [Consistency levels in Azure Cosmos DB](/azure/cosmos-db/consistency-levels)
- [Time to live (TTL) in Azure Cosmos DB](/azure/cosmos-db/time-to-live)
- [Configure time to live in Azure Cosmos DB for NoSQL](/azure/cosmos-db/how-to-time-to-live)

## Clean up resources

If you created an account for the exercise and no longer need it, delete its resource group in the Azure portal to stop incurring charges.
