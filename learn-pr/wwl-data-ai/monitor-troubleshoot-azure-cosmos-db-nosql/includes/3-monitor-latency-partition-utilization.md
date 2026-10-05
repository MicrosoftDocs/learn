Response codes tell you that something failed. They don't tell you that something is *degrading*. The Contoso product page still returns 200 for nearly every request, and its 99th-percentile (P99) latency still tripled. In this unit, you separate the latency the service is responsible for from the latency your application adds, read normalized request unit (RU) consumption without misinterpreting it, and use physical partition metrics to tell a container that needs more throughput from one that needs a better partition key.

Azure Monitor collects these metrics automatically. You configure nothing, and there's no cost to look. Most arrive at one-minute granularity, and a few report less often. Platform metrics are retained for 93 days. The metrics explorer displays up to 30 days on a single chart, and you can move that interval through the retained history.

## Separate server-side latency from end-to-end latency

The number your users experience is end-to-end latency: the time from your application issuing a call to it receiving a result. The number Azure Cosmos DB reports is server-side latency: the time the service spends on the request after it arrives and before the response leaves. The gap between them is network transit, SDK retries, and time your own process spends waiting for a thread.

:::image type="content" source="../media/latency-signal-layers.png" alt-text="Diagram showing end-to-end latency measured by the client SDK enclosing network transit and the server-side latency the service reports." lightbox="../media/latency-signal-layers.png":::

Two metrics report server-side latency, split by connection mode:

- **Server Side Latency Direct**, for operations that use direct mode over TCP.
- **Server Side Latency Gateway**, for operations that use gateway mode over HTTPS.

Choose the one that matches how your client connects. Direct mode is available in the .NET SDK and Java SDK only, so applications built on the Python SDK, Node.js SDK, or Go SDK report against the gateway metric. An older combined **Server Side Latency** metric predates this split and is deprecated, so build new charts and alerts on the connection-mode metrics rather than on it.

Both metrics accept filters for `DatabaseName`, `CollectionName`, `OperationType`, `Region`, and `PublicAPIType`. Filter to a specific container before drawing conclusions. Requests that target the account rather than a container, such as creating a database, still count toward server-side latency and appear with an empty `CollectionName`, which quietly inflates an unfiltered chart.

When server-side latency stays flat while your application's measured latency climbs, investigate the gap before assigning a cause. Look at retries, at client CPU, and at the distance between your compute and your account's region. Flat server-side processing time doesn't rule out throttling or time spent retrying requests. The client-side diagnostics from unit 2 give you the elapsed time to compare against.

## Track normalized RU consumption

**Normalized RU Consumption** is a percentage between 0 and 100 that reports how fully you're using the throughput you provisioned, measured in request units per second (RU/s). Its definition is more specific than it first looks, and misreading it sends investigations in the wrong direction.

The metric is emitted every minute, and its value is the **maximum** utilization across all partition key ranges during that minute, not the average. Each partition key range maps to one physical partition, and provisioned throughput is divided evenly among them. So a container provisioned at 20,000 RU/s across two physical partitions gives each partition 10,000 RU/s. If one partition consumes 6,000 RU/s and the other consumes 8,000 RU/s in a given second, the two partitions sit at 60 percent and 80 percent, and the container reports 80 percent.

That construction has a consequence worth internalizing: **100 percent normalized RU consumption isn't automatically a problem.** It means at least one partition used its entire allowance for at least one second. A single stored procedure can produce that spike. If the overall rate of 429 responses stays low and your latency is acceptable, no action is required.

The complementary metric is **Throttled Request Percentage**, which reports the share of requests rate limited because the throughput limit was exceeded. Together, the two answer different questions: normalized RU consumption tells you how close you're running to capacity, and throttled request percentage tells you how often that closeness turned into a rejected request.

> [!NOTE]
> For a production workload, 1 to 5 percent of requests returning 429 with acceptable end-to-end latency is a healthy sign that you're fully using the throughput you pay for. That range assumes your partitions are evenly distributed. When they aren't, one problem partition can return a large number of 429 responses while the overall rate still looks low.

### Read normalized RU consumption under autoscale

Autoscale adds a condition for scaling to the maximum. The metric reports 100 percent whenever a partition key range uses its full allowance in any one second, but autoscale only raises throughput to the maximum when consumption stays at 100 percent for a sustained five-second interval. That threshold limits unnecessary scaling to the maximum. A momentary spike can still cause a partial scale-up below the maximum.

So a chart showing normalized RU consumption at 100 percent alongside provisioned throughput well below the autoscale maximum isn't necessarily a contradiction or a bug. A short spike can explain it without the system scaling to the maximum. If instead the metric sits at 100 percent continuously and you're consistently scaled to the maximum, manual throughput might be more cost-effective. For accounts with multi-region writes and more than one region, manual and autoscale use the same rate per RU/s, so this cost comparison differs.

## Watch physical partition utilization

The metric that separates a capacity problem from a distribution problem is normalized RU consumption **split by partition key range**. In the portal, open **Insights** > **Throughput** > **Normalized RU Consumption (%) By PartitionKeyRangeID** and filter to your database and container.

Read the shape of the result:

- Every range near the same high percentage means the container is genuinely at capacity. More throughput helps.
- One range consistently at 100 percent while the rest sit at 30 percent or lower means a hot partition. More throughput is divided evenly, so the hot partition receives only its even share of the increase while you pay for the rest.

Three further metrics describe the physical layout directly. Physical Partition Size and Physical Partition Throughput take a `PhysicalPartitionId` dimension, so you can split either one per partition. Physical Partition Count reports a single number for the container:

| Metric | Reports |
| :--- | :--- |
| Physical Partition Count | How many physical partitions the container currently has |
| Physical Partition Size | The bytes stored in each physical partition |
| Physical Partition Throughput | The RU/s allocated to each physical partition |

Physical partition size is the early warning for a skew that isn't a throughput problem yet. A physical partition holds up to 50 GB, and the service splits partitions automatically as storage grows. An uneven split can still leave one partition holding far more data than its neighbors. Raising throughput until every partition splits and then lowering it again evens out the distribution. What throughput can't fix is a single logical partition approaching its own 20-GB limit, because all the data for one partition key value stays on one physical partition.

## Compare what you measure against a service objective

A metric only means something against a target. Azure Cosmos DB publishes a service level agreement of less than 10 milliseconds server-side for point reads and point writes over direct connectivity. Apply the relevant operation and region filters when investigating latency. An average below 10 milliseconds doesn't establish compliance with the agreement or rule out slow requests. Compare the chart with client diagnostics and your application's latency objective.

Availability has its own metric. **Service Availability** reports the percentage of successful account requests at hourly, daily, or monthly granularity, which matches the way availability commitments are written.

Set your own objectives before an incident rather than during one. Decide what P99 latency your application tolerates, what rate of 429 responses is acceptable, and how much normalized RU consumption headroom you want to keep. Those three numbers turn a chart from something you interpret in the moment into something you can alert on, which is the subject of the next unit.
