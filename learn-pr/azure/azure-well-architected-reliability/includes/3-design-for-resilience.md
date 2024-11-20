| :::image type="icon" source="../media/goal.svg"::: The workload must continue to operate with full or reduced functionality. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

You should expect component malfunctions, platform outages, performance degradations, and other faults to occur. Build resiliency in the system so that it's fault-tolerant and can degrade gracefully.

**Example scenario**

Contoso Air is a commercial airline that has an in-house development department. The main LOB application is a booking solution that allows customers to book flights directly with Contoso Air. The app is built in Azure and uses Azure App Service, Cosmos DB, Azure Functions, Azure Logic Apps, and Azure Service Bus.

## Determine failure risks

**Identify potential failure points in the system, especially for the critical components, and determine the effect on user and system flows.**

Analyze the failure case, blast radius, and intensity of fault for each potential failure point. Failure cases and their intensity can range from relatively low-impact scenarios like the temporary loss of a backend process to full-scale outages resulting from disasters. Performing this analysis helps you determine the design of error handling capabilities at the component level.

*Contoso's challenge*

- The LOB application provides many key functions ranging from marketing through commerce. The ticket purchase user flow has been identified as the most critical flow.  The workload team has determined that more reliability measures should be implemented to ensure that the flow is optimized for resilience.
- The team has time budgeted for improvements like decoupling components and redesigning flows, but wants to ensure that they're using that time to focus on the highest value improvements.

*Applying the approach and outcomes*

- The team identifies the external payment gateway as a potential failure point. The gateway is highly available but there’s a potential for users experiencing occasional transient faults resulting from network issues or bursts of extremely high requests. The gateway might reject some requests when it’s overloaded by multiple simultaneous requests being sent.
- The team determines that users must resubmit requests when the gateway rejects their initial requests, causing a negative user experience.

## Implement self-preservation mechanisms

**Build self-preservation capabilities by using design patterns correctly and modularizing the design to isolate faults.**

By building self-preservation capabilities into the system, you'll be able to prevent a problem from affecting downstream components. The system will be able to mitigate transient and permanent failures, performance bottlenecks, and other problems that might affect reliability. You'll also be able to minimize the blast radius.

*Contoso's challenge*

- The team wants to minimize the risk of transient failures causing users' requests to be rejected by the payment gateway.  Because of the transient nature of some of the error conditions, there’s a high probability the same request will succeed if resubmitted.

*Applying the approach and outcomes*

- The team develops custom logic in the flow to retry the transaction after a short delay when a failure that can be retried is detected.
- The solution design will be modified to incorporate the Retry Pattern, slightly increasing the wait time between retries until the request is successfully processed or the maximum number of failures is reached.
- The team also decides to decouple the user interaction and backend payment processing functionality of this flow using an event-driven approach with Azure Service Bus. When unrecoverable failures occur while processing the message (after the maximum number of retries), the backend processor abandons processing that request, leaving the message in the queue so it can be reprocessed at a later time.

## Build comprehensive redundancy and resiliency

**Build redundancy in layers and resiliency on various application tiers.**

Aim for redundancy in physical utilities and immediate data replication. Also aim for redundancy in the functional layer that covers services, operations, and personnel. Redundancy helps minimize single points of failure. For example, if there’s an outage affecting one or more components, an availability zone, or an entire regional, a redundant (active-active or active-passive) deployment allows you to meet uptime targets.

Adding intermediaries prevents direct dependency between components and improves buffering. Both of these benefits harden the resiliency of the system.

*Contoso's challenge*

- Implementing retries and decoupling the payment gateway calls from the UI using Service Bus has dramatically increased the reliability of this flow, but the business stakeholders still worry about data loss that might happen due to a catastrophic failure in the primary region.  

*Applying the approach and outcomes*

- The team decides to upgrade to Service Bus premium tier. By doing so, they can take advantage of that tier's Availability Zones support functionality. With this functionality, multiple copies of the data are stored across three physically separated facilities (availability zones), and the service has enough capacity reserves to instantly cope with the complete, catastrophic loss of a datacenter.
- Additionally, the team configures Azure Service Bus Geo-Disaster recovery to continuously replicate data to a secondary region that will be used in the unlikely case of a complete failure of the primary region.
