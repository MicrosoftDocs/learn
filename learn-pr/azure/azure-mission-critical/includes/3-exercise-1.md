Contoso Shoes needs a way to check the health of the web application at the API level, as well as its dependencies. You want to implement a dedicated health check endpoint on the application, which reports the API health status at regular intervals.

## Current state and problem

In the current design, the application logs errors when there are runtime issues in the API code or calls to dependent services fail, such as failed database queries. This approach is useful in troubleshooting issues after an incident has occurred.

However, the approach isn't proactive. Azure App Service and the external monitoring tools don't have a way to check the health status of the application itself. This gap impacts many use cases, like how load is distributed. The current implementation solely relies on the App Service plan's best effort to distribute traffic evenly across instances without ever checking the application's health. In one reported incident, traffic was routed to unhealthy App Service instances, resulting in failed requests.

## Specification

Your task is to build the dedicated health service as an extension to the already-deployed code.

- Introduce a health check API in your application. The API must check the application's health status and its dependencies and return a status indication. For example, the API periodically should check read and write operations to Azure Cosmos DB. Implement those functions as separate probes so that reads and writes are checked independently.

    > [!TIP]
    > Extend the health check to non-functional services, such as Azure Key Vault and Azure Container Registry. This step is important, because if those services experience an outage, you might notice an impact in the ability to scale out or withstand an App Service instance restart.

- The health check API endpoint shall be called frequently, by multiple sources, and shouldn't degrade the performance of the API. For example, the Azure App Service plan must send requests to an endpoint twice a minute and make informed decisions about which App Service instances to distribute traffic to.

- Optimize the performance of the health check API by caching results in memory for 10 seconds. Not every query to the health check endpoint should result in a backend call. Some of those responses can be served from the cache.

- Make health check data available in Azure Monitor for future analysis.

## Recommended approach

To get started on your design, we recommend the following approach:

### 1&ndash;Health checks

All queries the health check API sends must be performed asynchronously and in parallel. Design health checks against the critical components like the database. The API should periodically check read and write operations. Implement those functions as separate probes so that reads and writes are checked independently.

Use requests that mimic real application behavior without putting too much load on the services just from the health probes. To also test write requests, you need to design a way to remove test data efficiently so that it doesn't get mixed with real user data.

### 2&ndash;Caching pattern

To avoid overloading the downstream services with health checks, the health check API should cache results for a configurable number of seconds. Think of possible ways to achieve this goal.

## Check your work

Here's an example [**Application Health Service**](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-health-modeling#application-health-service). Did you cover all aspects in your design?

- Is the health check endpoint compatible with Azure App service's Health check feature?
- Did you include checks for runtime dependencies? What did you use as a proxy/test?
  - Cosmos DB read/write
  - Third-party API  
- Did you cache the results of health checking to reduce performance overhead?
- Did you log events in your health checks? Note the successes and the failures?
- Have you applied Azure Application Insights log sampling to the health check logs?
