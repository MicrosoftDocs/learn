Contoso Shoes needs a way to check the health of the web application at the API level and also its dependencies. You would like to build an overall health model that's measurable through a health status. You'll apply the health status to all user and system flows. The goal is to identify failure points before they can cause an outage.

## Current state and problem

In the current implementation, the API logs application errors that result from:

- Runtime issues in the API code
- Dependency failures, such as failed database queries

Azure App Service and the external monitoring tools don't have a way to check for health status on the API itself in order to build resiliency or make outage decisions. A lack of a dedicated health check endpoint has led to traffic being routed to unhealthy App Service instances resulting in failed requests.

An operator isn't able to see the cascading impact of an issue resulting from the API and platform dependencies. In some cases, time taken to triage an issue and respond with has led to longer down times. 

## Specification

**Application exercise**

- Introduce a health check API in your application. 

    - This new component must report the health status of the API and it's dependencies so that the application can perform its duties as expected. 
    
    - The health check API must be called twice a minute, by multiple sources, and should not degrade the performance of the API.

    - Azure App Service should be able to use that data to make informed decisions about which App Service instances to include in the built-in Azure App Service load balancer. 

    - Make health check data available in Azure Monitor for future needs.

## How to proceed with the health check API


## Check your work

To validate that you have completed the work to the requirements, test your app behavior out by following these steps.
- The health check endpoint in the API is compatible with Azure App service’s Health check feature
- Include checks for runtime dependencies. And what did you use as a proxy/test 
    - Cosmos DB read/write
    - Third party API  
- Include checks for non-request-flow dependencies. Those services are Azure Key Vault and Azure Container Registry. If those services were experiencing an outage, that might impact the ability to scale out or survive an app service instance restart, but wouldn’t necessarily impact API requests.
- Cache the results of health checking to reduce performance overhead. 
- Build the dedicated health service as an extension to the already-deployed code.
- Log events in your health checks. Note the successes in addition to failures.
- Apply Azure Application Insights log sampling to the health check logs.

