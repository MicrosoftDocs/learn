## Specification

Your current architecture uses Availability Zone support on all of the components in the solution, and until recently a single region has been deemed sufficient for the application. However, a regional outage that impacted networking brought your system offline from an end-user perspective. Scaling out within the region or even deploying a new stamp in the region wouldn’t have allowed you to recover.

The team decided it was important to invest in a strategy that can survive and total regional failure of one or more components in the architecture. That added cost and complexity comes with an extended reliability perk and even a better customer experience for those clients that can now access the API geographically closer to them. Also, the cost (actual and reputational) of being down for extended periods of time is greater than the cost of running in a second region.

Extend the architecture to work in an active-active, multi-region topology. Clients should not be pinned to a region. Clients should not need to change URLs for contacting the API.  The API currently has a DNS CNAME of api.cotososhoesorwhateveritwas.com for cotososhoesorwhateveritwasapi.azurewebsites.net. In the case of a regional failure that impacts the ability for the API to serve requests, traffic so stop attempting to flow to that faulted region and instead be redirected to the non-faulted region without notable impact to clients already in the non-faulted region.

Convert the architecture to an active-active, shared-state, multi-region topology designed to withstand one faulted region. (For this challenge you do not need to consider the CI/CD implications as part of the deliverable.)

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
