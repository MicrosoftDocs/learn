In this exercise, we'll continue with the health model structure you created previously. Your task is to quantify health states of individual components for the example application. 

In the health model structure, start by evaluating the layers starting at the top with user flows and proceed to the lower layers.

## User flow health state

So far, we've identified two user flows: **List catalog items** and **Add comment**. To determine health states for each flow, ask questions such as:

- *When is the user flow considered healthy?*
- *Can it operate in a degraded state?*

Based on the implementation and functional requirements, identify the application components that participate in the user flow. The components are described in [Example architecture components](/training/modules/design-health-model-mission-critical-workload/3-exercise-layered-model#components).

|User flow|Components|
|---|---|
|**List catalog items**|Front-end internal web application, Catalog API|
|**Add comment**|Front-end internal web application, Catalog API, Background processor|

If any of those components become unhealthy, the user flow is expected to become unhealthy.

> [!NOTE]
> Some applications can operate in a special *degraded* mode. For example, if Contoso Shoes implements local browser caching, employees who are using the web application can create comments, but comments can't be sent and the customer view isn't updated until the Catalog API becomes healthy, which the browser can continuously check.

## Application component health state

Determine metrics that contribute to the component's health state. For this step, you'll need to know the functionality of the component. Ask questions like:

- *What processing time in the API is acceptable to maintain a good user experience?*
- *Are there any expected errors? What's the "normal" error rate?*
- *What's the "normal" processing time? What does it mean if processing time is higher than normal?*
- *What happens to write operations if Azure Cosmos DB is unreachable?*

These questions should lead you to specific and measurable thresholds for key metrics. For example, you might consider these threshold values for the Catalog API component.

|Metrics and threshold|Health state|
|---|---|
|Response Time < 150 ms</br> Failed request count < 10 | Healthy |
|Response Time < 300 ms</br> Failed request count < 50 | Degraded|
|Response Time > 300 ms</br> Failed request count > 50 | Unhealthy|

You can get the values from an application monitoring solution, such as Application Insights.

## Azure resource health state

Azure service health states are based on specific resources. For example, Azure Cosmos DB reports DTU utilization, and Azure App Services provides information about CPU utilization.

For information about metrics by resource type, see [Supported metrics with Azure Monitor](/azure/azure-monitor/essentials/metrics-supported). 

## Health states and thresholds

After you've evaluated all layers of the application, you should have a list of components and their health state definitions that look similar to this example.

| Component | Indicator/metric | Healthy | Degraded | Unhealthy |
| --------- | ---------------- | ------- | -------- | --------- |
| *List catalog items* user flow | Underlying health state | Front end healthy and Catalog API healthy |
| *Add comment* user flow | Underlying health state | Front end healthy, Catalog API healthy, and background processor healthy |
| Front-end web application | # of non-20x HTTP responses/min | 0 | 1-10 | > 10 |
| Catalog API | # of exceptions/sec | < 10 | 10-50 | > 10 |
|  | Average processing time (ms) | < 150 | 150-500 | > 500 |
| Background processor | Average time in queue (ms) | < 200 | 200-1,000 | > 1,000 |
|  | Average processing time (ms) | < 100 | 100-200 | > 200 |
|  | Failure count | < 3 | 3-10 | > 10 |
| Azure Cosmos DB | DTU utilization | < 70% | 70%-90% | > 90% |
| Azure Key Vault | Failure count | < 3 | 3-10 | > 10 |
| Azure Event Hubs | Processing backlog length (outgoing/incoming messages) | < 3 | 3-20 |  > 20 |
| Azure Blob Storage | Average latency (ms) | < 100 | 100-200 | > 200 |

In this example, the error tolerance for the front-end web application and the Catalog API is different. This difference relates to the technical understanding of the application. All front-end errors should be handled client-side, so there's a zero threshold. However, on the API layer, 10 exceptions are allowed to account for user-caused errors. For example, errors such as *404 - Not Found* don't necessarily indicate a health issue.
