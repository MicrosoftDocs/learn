In this exercise, continue with the layered health model structure you created in the last exercise. You'll quantify health states of individual components. This step is mostly about experience with running the system and understanding what the expected values are under a standard workload. It demonstrates the purpose of health modeling, while injecting this experience and knowledge into the health model for easier analysis.

Begin by looking at the health model structure and proceed top-to-bottom through layers, starting with user flows.

## User flows

- *When is "List catalog items" healthy? Can it operate in a degraded state?*
- *When is "Add comment" healthy? Can it operate in a degraded state?*

Based on the implementation and functional requirements, neither of these user flows can operate without its underlying services, not even in degraded mode. The health states of the user flows are determined as follows:

- **List catalog items**: This user flow reflects the health state of the **front-end web application**, and the **Catalog API**.
- **Add comment**: This user flow reflects the health state of the **front-end web application**, the **Catalog API**, and the **background processor**.

If any of these dependencies become unhealthy, the user flow is expected to become unhealthy.

> [!NOTE]
> Some applications can operate in a special *degraded* mode. For example, if Contoso Shoes implements local browser caching, employees who are using the internal web application can create comments, but comments can't be sent and the customer view isn't updated until the Catalog API becomes healthy (which the browser can continuously check).

## Application components

Health states are based on a combination of application metrics. For example, metrics might include the number of exceptions, response time, and service metrics. Application components can have dependencies on Azure resources, and even on other components. You need to factor in those health state.

Defining metrics and thresholds for application components requires knowledge and understanding of their functionality. Ask questions like:

- *What processing time in the API is acceptable to maintain a good user experience?*
- *Are there any expected errors? What is the "normal" error rate?*
- *What's the "normal" processing time? What does it mean if processing time is higher than normal?*
- *What happens to write operations if Azure Cosmos DB is unreachable?*

These questions should lead you to define specific and measurable thresholds for key metrics. The source of these values is an application monitoring solution, like Application Insights.

## Azure resources

Azure service health states are based on specific resources. For example, Azure Cosmos DB reports DTU utilization, and Azure App Services provides information about CPU utilization.

## Health states and thresholds

Ultimately, you should have a list of components and their health state definitions that looks similar to this example for Contoso Shoes:

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

In this example, the error tolerance for the front-end web application and the Catalog API is different. This difference relates to the technical understanding of the application. All front-end errors should be handled client-side, so there's a zero threshold. However, on the API layer, we allow 10 exceptions to account for user-caused errors (such as *404 - Not Found*) that don't necessarily indicate a health issue.
