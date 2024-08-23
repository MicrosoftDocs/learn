Contoso Shoes needs a way to withstand regional outages. You want to deploy the current stamp to an active-active, shared-state, and multiregion topology. The architecture must be designed to redirect traffic to another region in case a region fails.

## Current state and problem

A single region has been sufficient for the application. However, a recent regional outage that impacted networking caused the system to go offline from an end-user perspective. Horizontal scaling within the region—or even deploying a new stamp in that region—wouldn't have recovered the application from the failed state.

DNS is held by an existing registrar for `api.contososhoes.com`. The DNS record resolves to the backend App Services endpoint (`apicontososhoes.azurewebsites.net`) with a time-to-live (TTL) period of two days. When the solution is deployed to multiple regions, DNS needs to be migrated.

## Specification

- Extend the architecture to work in an active-active, multiregion topology.
- Modify the deployment stamp model that allows you to dynamically add and remove regions as needed instead of a list of hardcoded resources across two regions.
- If there's a regional failure, traffic needs to be routed to the non-faulted region without any notable impact to clients already in the non-faulted region.
- Clients shouldn't be pinned to a region.
- Clients shouldn't need to change URLs for contacting the API. DNS should be migrated to the global router.

## Recommended approach

To get started on your design, we recommend that you follow these steps:

### 1&ndash;Multiregion topology

The architecture must be distributed to two or more Azure regions to protect against regional outages. Consider these factors when choosing a region:

- The region must be able to withstand datacenter outages in that region.
- The Azure services and the capabilities used in the architecture must be supported in the region.
- The region and the resources deployed in the region must have proximity to the end users and dependent systems to minimize network latency.

Think through a failure scenario. Suppose Region 1 gets 75% of the traffic and your newly added Region 2 gets the remaining traffic. They're both scaled appropriately to handle that load. There's a regional outage in Region 1, and all traffic is now routed to Region 2. Can you make that transition smooth? Can the Region 2 support that increased traffic load?

> **Check your progress: [Global distribution](/azure/architecture/framework/mission-critical/mission-critical-application-design#global-distribution)**

### 2&ndash;Global routing

In order for the clients to get transparently routed to either working region, add a global load balancer. The load balancer should use the health checks that you added in the previous exercise to determine whether a stamp is healthy. Can you think of ways to serve frequent and similar requests that can be fulfilled without reaching the backend?

- Choose a native Azure service that integrates with the existing architecture and is able to fail over quickly.
- Make sure that the network ingress path has controls in place to deny unauthorized traffic.
- Minimize network latency by serving end users from an edge cache.
- Migrate the existing DNS without affecting existing clients.
- Have an automated way to indicate a regional failure to ensure traffic isn't routed to the faulted region. Also, get notified when the region is available again so that the load balancer can resume routing to that region.

> **Check your progress: [Global traffic routing](/azure/architecture/framework/mission-critical/mission-critical-networking-connectivity#global-traffic-routing)**

### 3&ndash;Deployment stamp changes

The ideal state is an active-active configuration that doesn't require any manual failover, and client requests can be served from any region. Think about what that implies for your architecture. For example, do you have any state that's stored in the regional stamp?

Certain services in the current architecture have geo-replication capabilities. Consider separating the services into different stamps: one stamp that contains global resources and another regional stamp that shares resources with the global stamp. One of deciding factors should be the lifecycle of those resources. What's the expected lifetime of the resource relative to other resources in the architecture? Should the resource outlive or share the lifetime with the entire system or region, or should it be temporary?

Explore the reliability features of the Azure services used in the architecture. You can start with these features and explore further to maximize reliability.

|Azure service|Feature|
|---|---|
|Azure Cosmos DB|[Multi-region write](/azure/architecture/framework/mission-critical/mission-critical-data-platform#globally-distributed-multi-region-write-datastore)|
|Azure Container Registry|[Geo-replication](/azure/well-architected/mission-critical/mission-critical-application-platform)|
|Azure App Service plan|[Availability zone support](/azure/reliability/reliability-app-service?tabs=cli#availability-zone-support)|

> **Check your progress: [Application platform](/azure/architecture/framework/mission-critical/mission-critical-application-platform) | [Data platform](/azure/architecture/framework/mission-critical/mission-critical-data-platform)**

## Check your work

Here are the [**Application**](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-app-platform) and [**Data**](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-data-platform) design choices for a similar architecture. Did you cover all aspects in your design?

- Which other Azure region did you select for your multi-region topology, and why?
- Did you enable two or more Azure Availability Zones in each Azure region to protect against datacenter outages?
- Did you include Web Application Firewall to control ingress traffic? What routing rules did you put in place and why?
- How does the load balancer support your existing DNS record?
- How did you use your health check API from the previous exercise?
- Have you protected the application from DDoS attacks, especially preventing malicious clients from bypassing the load balancer and reaching regional instances?
- How did you approach DNS migration?
- Did you make any SKU changes to the existing component to support multi-region topology?
- Which Azure services did you leave as singletons? How have you justified your choice for each service? Did you make any configuration changes?
- Are you logging resources? Do you think that will impact your ability to inspect the logs for the overall system?
