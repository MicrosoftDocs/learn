In this exercise we'll continue with the layered health model structure that was created in the previous exercise, and quantify health states of individual components. This step is mostly about experience with running the system and understanding what the expected values are under regular load. It nicely demonstrates the whole purpose of health modeling - injecting this experience and knowledge into the health model for easier analysis.

Begin by looking at the health model structure and proceed top-to-bottom through layers, starting with user flows.

## User flows

- *When is "List catalog items" healthy?*, *Can it operate in a degraded state?*
- *When is "Add comment" healthy?*, *Can it operate in a degraded state?*

Based on the implementation and functional requirements, neither of the user flows can operate without its underlying services. Not even in degraded mode. So,

- The health state of **List catalog items** user flow reflects the health of the **frontend web application**, and the **Catalog API**.
- The health state of **Add comment** user flow reflects the health of the **frontend web application**, the **Catalog API**, and **Background Processor**.

If any of these dependencies become unhealthy, the user flow is expected to become unhealthy.

> [!NOTE]
> Some applications can operate in a special "degraded" mode. For example, implementing local browser caching would allow creating comments, but not sending them until the Catalog API becomes healthy (which the browser can continuously check).

## Application components

Health states are based on a combination of application metrics. For example, number of exceptions, response time, and service metrics. Application components can have dependencies on Azure resources and even other components). Factor in those health states too.

Defining metrics and thresholds for application components requires knowledge and understanding of their functionality. Ask questions like:

- *What processing time in the API is acceptable to maintain good user experience?*
- *Are there any expected errors? What is the "normal" error rate?*
- *What the "normal" processing time? And what does it mean if it's higher?*
- *What happens to write operations when Cosmos DB is unreachable?*
- etc.

Those questions should lead to defining specific and measurable thresholds for key metrics. The source of these values will be the application monitoring solution (such as Application Insights).

## Azure resources

Azure service health states are based on a particular resource. For example, Azure Cosmos DB reports DTU utilization, Azure App Services provides information about CPU utilization, and so on.

## Health states and thresholds

In the end you should have a list of components, along with their health state definition. Your heath states representation should look similar to this example:

| Component | Indicator/metric | Healthy | Degraded | Unhealthy |
| --------- | ---------------- | ------- | -------- | --------- |
| List catalog items user flow | Underlying health state | Front end healthy and Catalog API healthy |
| Add comment user flow | Underlying health state | Front end healthy, Catalog API healthy, and background processor healthy |
| Front-end web application | # of non-20x HTTP responses/min | 0 | 1-10 | > 10 |
| Catalog API | # of exceptions/sec | < 10 | 10-50 | > 10 |
|  | Avg. processing time | < 150 ms | 150-500 ms | > 500 ms |
| Background processor | Avg. time in queue (ms) | < 200 | 200-1000 | > 1000 |
|  | Avg. processing time (ms) | < 100 | 100-200 | > 200 |
|  | Failure count | < 3 | 3-10 | > 10 |
| Azure Cosmos DB | DTU utilization | < 70% | 70-90% | > 90% |
| Azure Key Vault | Failure count | < 3 | 3-10 | > 10 |
| Azure Event Hubs | Processing backlog length (outgoing/incoming messages) | < 3 | 3-20 |  > 20 |
| Azure Blob Storage | Average latency (ms) | < 100 | 100-200 | > 200 |

In this example you can notice that there's a difference between the error tolerance for the front-end web application and the Catalog API. This goes back to the technical understanding of the application: all frontend errors should be handled client-side, so there's a 0 threshold. However, on the API layer we allow 10 exceptions to account for user-caused errors (such as 404 - Not Found) that don't necessarily mean a health issue.
