With an estimate of the throughput your workload needs, the next decision is how to provision it. Azure Cosmos DB gives you two choices: provisioned or serverless capacity, and, if provisioned, standard or autoscale throughput. In the Contoso scenario, the bursty, unpredictable traffic favors one combination, and the same reasoning applies to any workload once you can describe its traffic.

## Provisioned or serverless

**Provisioned throughput** reserves a set number of request units per second (RU/s) for a container or database. You pay for that reserved capacity whether or not you use it, and requests beyond it get rate-limited.

**Serverless** removes throughput provisioning entirely. Throughput charges cover only the RUs (request units) each request consumes, with no reserved capacity and no minimum throughput charge. Serverless fits workloads with intermittent, unpredictable, or low-average traffic, such as a new application or prototype whose load is hard to forecast.

:::image type="content" source="../media/serverless.png" alt-text="Diagram showing individual requests, each consuming 'RUs' in a serverless model." lightbox="../media/serverless.png":::

The distinction comes down to utilization. If traffic keeps reserved capacity busy most of the time, provisioned throughput costs less per request. If traffic is sparse or spiky with long idle gaps, serverless avoids paying for idle capacity.

## Standard or autoscale

When you choose provisioned throughput, you make a second choice about how the reserved RU/s behaves.

**Standard (manual)** throughput holds a fixed RU/s that you set. It stays constant until you change it, and requests above it are rate-limited. Standard throughput suits steady, predictable demand with high utilization. To compare costs, use the same capacity for the manual setting and the autoscale maximum.

**Autoscale** throughput scales the RU/s automatically between 10% of a maximum you set and that maximum, reacting to real-time demand instantly. Billing uses the highest throughput reached during each hour, with a minimum of 10% of the maximum even when idle. For a single-write-region account, the rate per 100 RU/s is 1.5 times the standard rate. At equal maximum capacity, autoscale costs less when its average billable hourly throughput is below about 66% of the fixed manual throughput. Compare hourly peaks, including the billing floor, not just the percentage of hours that reach the maximum.

Autoscale fits variable or unpredictable traffic, but it doesn't eliminate rate-limiting. Requests can receive HTTP 429 responses when demand exceeds the configured maximum or a physical partition's throughput allocation. To choose the maximum and monitor for hot partitions, use measured demand.

:::image type="content" source="../media/autoscale.png" alt-text="Diagram showing autoscale throughput oscillating between a minimum and maximum RU/s based on real-time usage." lightbox="../media/autoscale.png":::

Accounts configured with multiple write regions are the exception. There, autoscale and standard throughput cost the same per 100 RU/s, so autoscale is the better choice no matter how steady the traffic is.

Accounts created after September 25, 2024 also get **dynamic scaling** enabled by default. Dynamic scaling applies autoscale per partition and per region rather than uniformly across the whole resource, so one hot partition no longer forces every partition to scale up with it. That behavior lowers cost for workloads whose traffic lands unevenly across partitions and for accounts spread over multiple regions. Older accounts enable it from the **Features** pane in the Azure portal, or programmatically with Azure PowerShell, the Azure CLI, or the REST API.

## A decision matrix

Map the choice to your traffic pattern:

| Traffic pattern | Recommended model |
| :--- | :--- |
| Steady and predictable, high utilization | Provisioned, standard |
| Variable or spiky, but sustained overall | Provisioned, autoscale |
| Intermittent, bursty, or low average with idle gaps | Serverless |

:::image type="content" source="../media/throughput-model-decision-tree.png" alt-text="Diagram of a decision tree selecting serverless, standard, or autoscale throughput from workload patterns." lightbox="../media/throughput-model-decision-tree.png":::


The provisioned models aren't permanent. A container switches between standard and autoscale at any time as a workload's traffic evolves, a point the next unit returns to when you provision throughput in practice.

> [!NOTE]
> Migration between standard and autoscale throughput runs in the Azure portal, the Azure CLI, PowerShell, or an Azure management SDK. The client SDKs (Software Development Kits) create resources with either model, but they don't switch an existing resource from one model to the other.

Serverless is different, because capacity mode belongs to the account rather than the container. A serverless account for the NoSQL API migrates in place to provisioned throughput, which converts every container at once and can't be undone. To switch from provisioned throughput to serverless, create a new account and migrate the data.
