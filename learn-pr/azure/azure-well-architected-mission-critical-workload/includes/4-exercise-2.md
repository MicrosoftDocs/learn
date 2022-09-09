Contoso Shoes needs a way to withstand regional outages. You want to deploy current stamp to an active-active, shared-state, and multi-region topology. The architecture must be designed to redirect traffic to another region in case a region fails.  

## Current state and problem

In the current design, a single region has been sufficient for the application. However, a recent regional outage that impacted networking caused the system to go offline from an end user perspective. Scaling out within the region or even deploying a new stamp in that region wouldn’t have recovered the application from the failed state.

## Specification

- Extend the architecture to work in an active-active, multi-region topology. 
- If there's a regional failure, traffic needs to be routed to the non-faulted region without notable impact to clients already in the non-faulted region. 
- Clients should not be pinned to a region. 
- Clients should not need to change URLs for contacting the API. 

## Recommended approach
To get started on your design, we recommend that you follow these steps.

## 1&ndash;Global routing

In order for the clients to get transparently routed to either working region, add a global load balancer. This new component will helping in routing and managing traffic globally. Choose a native Azure service that seamlessly integrates with the existing architecture.

The health checks that you added in the previous exercise should be used by the global load balancer to determine when a stamp is unhealthy.

## 1&ndash;Component and configuration changes
You need to deploy your application into addtional azure regions. Ideally you want to move to a deployment stamp model that allows you to dynamically add and remove regions as needed, not just a list of hardcoded resources across two regions

You need to update your Cosmos DB with global distribution. You need to define the best model for this.

The ideal state is an active-active configuration which does not require any active failover and client requests can be served from any region. Think about what that implies for your architecture. Do you have any state that only exists inside one regional stamp?

## Check your work
- What did you use as a gateway service to ingress the client traffic for regional routing determination?
- How did that choice support your existing DNS record?
- What routing rules did you put in place and why?
- Did your health check API come into play?
- Now that you have this gateway service in place, can you see other benefits that might come from this service, such as the inclusion of Web Application Firewall?
- How did you approach DNS and TLS migration?
- Did you do anything specific to prevent a client (including malicious clients) from bypassing your gateway service and going directly to the regional instances?
- Did you need to make any SKU changes to any component in the architecture?
- What Azure services did you:
    - leave as singletons in the solution, and did you make any configuration changes to them? (I.e. geo-replication features)
    - decide to have per-region?
    - What did you use as your deciding factors?
•	Any specific handling for logging resources, and do you think that’ll impact your ability to inspect the logs for the system “all up?”
•	What other region did you select, and why?
•	Think through the problem you’ve solved for. Let’s say that eastus2 gets about 75% of the traffic and the other region you added gets the remaining (both scaled perfectly to handle that load).  Eastus2 faults, and the other region is now being asked to absorb all of that traffic. How smooth will that transition be? Can the other region support that increased traffic load?
•	What did you use as the “region is down” signal to ensure traffic isn’t being routed there anymore? Is that automated? How will you know when the “region is back” and safe to start accepting traffic again?
