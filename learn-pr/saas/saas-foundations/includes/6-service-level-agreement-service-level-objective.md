This unit discusses Service-Level Agreements (SLAs) and Service-Level Objectives (SLOs).

## Service-Level Agreement (SLA)

Since SaaS isn't only software but is primarily a service, one difference between SaaS and traditional software products is SLA. The SLA is an agreement between a SaaS provider and a client that describes the provider's commitments for uptime and connectivity. If the SaaS provider doesn't achieve and maintain the service levels for each service as described in the SLA, customers may be eligible for compensation.

SLA compensation and penalties for software providers depend on industry and type of business. The two most common scenarios are financial penalty and service credits. For service credits, customers may be eligible for a credit toward their monthly service fees.

Although you can define 100% uptime for your service, it's hard to achieve 100% availability for complex systems. Most SLAs are tied to the availability they can provide.

An SLA that specifies 100% uptime might not guarantee 100% availability. The 100% uptime might mean that if there are outages, customers get compensation according to the agreement. Building highly available systems is an engineering task, while SLA is a way to legally protect a company for outages.

For examples of Microsoft SLAs, see [Service Level Agreements (SLA) for Online Services](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services).

## Service-Level Objectives (SLOs)

SLOs are measurable goals set on key customer-centric service level indicators (SLIs). SLOs measure your customer's experience of a business or infrastructure workload.

SLOs determine whether the SaaS provider is meeting the commitments made in a formally negotiated SLA. SLOs and SLIs should be defined early in the design of any cloud business or infrastructure workload.

The focus for service owners is to determine:

- What scenarios are critical indicators of service health from the customer perspective.
- How to gather SLIs so they're as close as possible to the customer experience.
- What the SLOs should be for the SLIs.

There are two types of SLOs in the software industry:

- **Service-centric SLOs** are tactical goals that teams define to gradually improve the quality of their service over time.

  These SLOs are pragmatic goals that are achievable in an engineering milestone. For example, if a service is currently achieving 99.7% availability, the team could set a goal to reach 99.9% availability in the next quarter.
- **Customer-centric SLOs** define the ideal future state or goal beyond which further investments in quality are unnecessary, because the customers' expectations are fully met.

SLOs are important in cloud workload development and operations, and serve different purposes compared to SLAs. An SLO indicates the state and direction of tech teams, while SLA is a contract with customers about terms for provided services and compensation.

In Azure, service level management is lightweight, because Microsoft predefines the interfaces, functionality, and metrics. Consumers need to manage their service delivery expectations when they use cloud workloads.

## Contoso scenario

A simple SLA agreement between Contoso and their users first defines the guaranteed service levels and SLIs, such as:

- Users are able to access and sign in to the system, generate designs, and use other available functionality in the system.
- Contoso provides 99.99% availability for their services that cover the preceding scenarios.
- Requests in the last five minutes are served in under 1,000 milliseconds at 99%.

The SLIs are aggregations of time series data. How the SLIs are gathered is important. If the customer interacts with the service by using an API, measuring system latency and time to process requests are accurate SLIs. But if the customer interacts with the service by using a web portal, the total time to service the request should also include the JavaScript performance of the web page.

The SLA must also define downtime and the compensation for customers facing downtime. For example, there could be a compensation structure of uptime percentage correlated with percentage of monthly credits received, or a system of flat compensation for each minute of downtime.

Regarding SLOs, Contoso can start by defining:

- Quality of Service (QoS): The AI model should generate new design ideas within 3 minutes after a user request.
- Availability: 99.99% over a monthly period.
- Capacity: Target percentage utilization for CPU, storage, memory, latency, throughput, and scaling.
- Product adoption: Rate of acceptance of proposed design ideas should be above 20%.

