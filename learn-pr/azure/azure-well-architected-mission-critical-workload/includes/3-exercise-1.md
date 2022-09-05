Contoso Shoes needs a way to check the health of the web application at the API level and also its dependencies. You want to implement a dedicated health check endpoint on the application, which reports the health status of the API at regular intervals. 

## Current state and problem

In the current design, the application logs errors when there are  runtime issues in the API code or calls to dependent services fail, such as failed database queries. This approach is useful in troubleshooting issues after an incident has occurred. 

However, the approach isn't proactive. Azure App Service and the external monitoring tools don't have a way to check the health status of the application itself. This gap impacts many use cases, for instance, how load is distributed. The current implementation solely relies on the App Service plan's best effort to distribute traffic evenly across instances without ever checking the health of the application. In a reported incident, traffic was routed to unhealthy App Service instances resulting in failed requests.

## Specification

Build the dedicated health service as an extension to the already-deployed code.

- Introduce a health check API in your application. The API must check the health status of the application and its dependencies and return an indication of the status. For example, the API periodically should check the health of functional services that process a request:

    - Checks read and write operations to Azure Cosmos DB. Implement those functions as separate probes so that reads and writes are checked independently.
    - Sends a message to Azure Event Hubs.
    
    > [!NOTE] 
    > Extend the health check to non functional services, such as Azure Key Vault and Azure Container Registry. This step is important because if those services experience an outage, you might notice an impact in the ability to scale out or withstand an App Service instance restart.

- The health check API endpoint must be called twice a minute, by multiple sources, and shouldn't degrade the performance of the API. For example, the Azure App Service plan must send requests to an endpoint and make informed decisions about which App Service instances to distribute traffic to. 

- Optimize the performance of the health check API by caching results in memory for 10 seconds. Not every query to the health check endpoint should result in a backend call. Some of those responses can be served from the cache.

- Make health check data available in Azure Monitor for future analysis.

## Recommended approach
To get started on your design, we recommend these configurations settings.

### 1&ndash;Health checks

All queries sent by the health check API must be performed asynchronously and in parallel.

Send a new message to Azure Event Hubs. If it was sent successfully, report the service `Healthy`. Set an identifying property on the message to tell Event Hubs to ignore the processing of the message. Make sure that Event Hubs processing code checks for that property.

Query Azure Cosmos DB to verify that the connection can be established and the query could be performed. Your query can be as simple as:

```
SELECT GetCurrentDateTime ()
```

Attempt to write a test document to the database. Set a short `Time-to-Live` value so that Cosmos DB can automatically remove it.

### 2&ndash;Caching pattern

Cache the check results in memory. You can use the standard, non-distributed ASP.NET Core `MemoryCache`. Control cache expiration by setting `HealthServiceCacheDurationSeconds` to 10 seconds.

## Check your work

Read the [**Application Health Service**](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-health-modeling#application-health-service) article for the implementation details. Did you cover all aspects in your design?

- Is the health check endpoint compatible with Azure App service’s Health check feature?
- Did you include checks for runtime dependencies? What did you use as a proxy/test? 
    - Cosmos DB read/write
    - Third party API  
- Did you cache the results of health checking to reduce performance overhead? 
- Did you log events in your health checks? Note the successes as well as the failures?
- Have you applied Azure Application Insights log sampling to the health check logs?

