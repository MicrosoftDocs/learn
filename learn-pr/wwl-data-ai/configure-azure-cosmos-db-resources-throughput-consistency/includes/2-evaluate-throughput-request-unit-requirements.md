In most cases, you should start a new workload using Serverless. Then as you develop the workload, decide on which throughput model (provisioned or serverless) is right for you, and if provisioned, the amount of throughput that meets your needs. That estimate is the foundation of every cost decision that follows.

## Request units as the currency of throughput

Azure Cosmos DB expresses the cost of every operation in **request units**. A request unit is a single number that measures the cost of an operation. It combines the CPU, IOPS (Input/Output Operations Per Second), and memory used, so you don't have to track each resource separately. Thinking in RUs (request units) lets you compare operations without reasoning about the underlying hardware: '10' RUs is twice the cost of '5' RUs.

Every request against a container consumes RUs, including:

- Reads and point lookups
- Writes (inserts, replaces, upserts, and deletes), which include the cost of updating indexes
- Queries

You measure throughput as request units per second (RU/s). With provisioned throughput, you configure RU/s and pay for provisioned capacity. With serverless, you don't configure RU/s and instead pay for the RUs consumed. Both models can rate-limit requests that exceed the available throughput.

## Estimate RU/s from your access pattern

Some operations have predictable, normalized costs that let you make an initial estimate. As a baseline, a point read of a 1-KB item by its ID and partition key costs about '1' RU with session, consistent prefix, or eventual consistency. Strong and bounded staleness reads cost twice as many RUs. Creating or deleting that same item costs about '5' RUs, and updating it costs about '10' RUs, assuming fewer than five indexed properties. Write cost rises with item size and with the number of properties the container indexes, so an item with many indexed properties costs more than those baselines. Queries vary widely with their complexity, the number of items they scan, and whether they use the index.

:::image type="content" source="../media/request-unit-cost-operation.png" alt-text="Diagram comparing request unit costs for point reads, creates, deletes, updates, and queries.":::

To estimate a workload, identify its dominant operations and multiply each operation's RU cost by how often it runs per second, then sum the results:

| Operation type | Requests per second | RU per request | RU/s needed |
| ---: | :---: | :---: | :--- |
| Update single item | 10,000 | 10 | 100,000 |
| Top query 1 | 700 | 100 | 70,000 |
| Top query 2 | 200 | 100 | 20,000 |
| Top query 3 | 100 | 100 | 10,000 |
| **Total** | | | **200,000 RU/s** |

To build this table for your own workload, gather your top few queries and your peak read and write rates per second.

::: zone pivot="csharp"

> [!TIP]
> Estimates get you close, but the most reliable number comes from measurement. In .NET, an operation's response exposes a `RequestCharge` property. For a paginated query, sum `RequestCharge` across all result pages to get the total query cost. Run your real queries against representative data volumes and partition distributions rather than trusting a paper estimate.

::: zone-end

::: zone pivot="python"

> [!TIP]
> Estimates get you close, but the most reliable number comes from measurement. In Python, an operation's response carries an `x-ms-request-charge` header. For a paginated query, capture and sum the charges for all responses, not just the last response. Run your real queries against representative data volumes and partition distributions rather than trusting a paper estimate.

::: zone-end

Learn more about [planning and managing Azure Cosmos DB costs](/azure/cosmos-db/plan-manage-costs), including the Azure Cosmos DB Cost Estimator that turns a described workload into an RU/s estimate.


With a throughput estimate in hand, you can choose a model that serves that demand at the lowest cost.
