Contoso Shoes needs a way to check the health of the web application at the API level and also its dependencies. You would like to build an overall health model to make sure issues are caught early in the development cycle. You will define an overall health status and examine user flows through the model to catch failures before they can cause an outage. Based on the observability data, you'll identify failure points and have resiliency checks.

## Current state and problem

In the current implementation, the API logs application errors that result from:

- Runtime issues in the API code
- Dependency failures, such as failed database queries

Azure App Service and the external monitoring tools don't have a way to check for health status on the API itself in order to build resiliency or make outage decisions. A lack of a dedicated health check endpoint has led to traffic being routed to unhealthy App Service instances resulting in failed requests.

An operator isn't able to see the cascading impact of an issue resulting from the API and platform dependency. In some cases, time taken to triage an issue and respond with has led to longer downtime. 

## Specification

Introduce a health check API in your application. This new component must report the health status of the API and it's dependencies so that the application can perform its duties as expected. The health check API must be  called twice a minute, by multiple sources, and should not degrade the performance of the API.
Azure App Service should be able to use that data to make informed decisions about which App Service instances to include in the built-in Azure App Service load balancer. You also want the health check data available to you in Azure Monitor for future needs.

Design a health model that hierarchically shows the relationship between the application components and the platform dependencies. 

Define an overall health status that is based on aggregated historical data. The status should be represented in three health states: unhealthy, degraded, and healthy.

TODO: List expected functional and non-functional requirements may be in prepare.

## How to proceed with the health check API

## How to proceed with health model

Health modeling in a top-down design activity and you'll need a complete list of components used in the architecture. This includes the application components as well as the Azure services used in the architecture.

Place those components in a dependency graph that shows a hierarchical view of solution. The top of the graph are the user flows that track request from the end user, to the web site, and flows at the application API level. At the bottom are the platform or the Azure services that the application has dependencies on. Also map dependencies between Azure resources.

For each component, collect metrics and metric thresholds and define health score. then decide unhealthy, degraded, and healthy states. That decision is should be influenced by expected performance and non-functional business requirements.


## Check your work