| :::image type="icon" source="../media/goal.svg"::: Ensure that the workload continues to run with full or reduced functionality. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

You should be ready for component malfunctions, platform outages, performance degradations, and other problems. Build your system to be resilient and handle these faults gracefully.

**Example scenario**

Contoso Air is a commercial airline that has an in-house development department. The main line of business (LOB) application is a booking solution that lets customers book flights directly with Contoso Air. The app is built in Azure and uses Azure App Service, Azure Cosmos DB, Azure Functions, Azure Logic Apps, and Azure Service Bus.

## Determine failure risks

**Identify where the system might fail, especially in critical areas, and determine the effect on user and system flows.**

Analyze the failure case, blast radius, and intensity of fault for each potential failure point. Failures can range from relatively minor problems like the temporary loss of a back-end process to major outages from disasters. Performing this analysis helps you design ways to handle faults at the component level.

*Contoso's challenge*

- The LOB app provides many key functions, from marketing to commerce. The workload teams identified the ticket purchase user flow as the most critical flow. They want to add more reliability measures to ensure that this flow is resilient.

- They set aside time for improvements like separating components and redesigning flows, but they want to focus on the highest value improvements.

*Applying the approach and outcomes*

- The team identifies the external payment gateway as a potential failure point. The gateway is highly available, but users might experience occasional transient faults from network problems or high request volumes. If multiple requests happen at the same time, the gateway might reject some requests because it's overloaded.

- The team determines that users have to resubmit requests if the gateway rejects them, causing a negative user experience.

## Implement self-preservation mechanisms

**Use design patterns and separate the design into modules to isolate faults so that your system can protect itself.**

By building self-preservation capabilities into the system, you can prevent a problem from affecting downstream components. Your system will be able to mitigate transient and permanent failures, performance bottlenecks, and other problems that might affect reliability. You can also minimize the impact of any problems.

*Contoso's challenge*

- The team wants to reduce the chances of temporary errors causing users' payment requests to be rejected. The errors are often short-lived, so there's a good chance that the same request will go through if the user tries again.

*Applying the approach and outcomes*

- The team adds custom logic in the flow to retry the transaction after a short delay when a retryable failure is detected.

- They're changing the design to use the Retry pattern. This pattern makes the wait time between retries slightly longer until the request goes through or reaches the maximum number of attempts.
- The team also decides to separate the user interaction and back-end payment processing by using an event-driven approach with Service Bus. After the maximum number of retries, if the system still can't process the message, the back-end processor stops processing that request and leaves it in the queue for later processing.

## Build comprehensive redundancy and resiliency

**Build redundancy in layers and resiliency on various application tiers.**

Create backups for physical utilities and data. Aim for redundancy in the functional layer that covers services, operations, and personnel. Redundancy helps minimize single points of failure. For example, if an outage affects one or more components, an availability zone, or an entire regional, a redundant deployment such as an active-active or active-passive deployment helps you meet uptime targets.

Adding intermediaries prevents direct dependency between components and improves buffering. These benefits improve the resiliency of the system.

*Contoso's challenge*

- Adding retries and separating the payment gateway calls from the UI by using Service Bus dramatically increased the reliability of this flow. But the business stakeholders still worry about data loss if there's a major failure in the primary region.

*Applying the approach and outcomes*

- The team decides to upgrade to the Service Bus premium tier. This upgrade lets them use availability zones, which means that multiple copies of the data are stored across three physically separated facilities. So if one datacenter goes down completely, the service can handle it without any problems.

- The team configures Service Bus geo-disaster recovery to continuously replicate data to a secondary region. So if the primary region fails completely, the secondary region can take over.
