Organizations, such as Tailwind Traders, require a high degree of availability from their mission-critical applications. It's also vital that any mission-critical application, and its associated data, is designed in such a way that in the case of a region outage it can automatically failover and continue running in another region. 

Highly available workloads are those which are:

- Resilient to component failure

- Highly available, and can run in a healthy state with no significant downtime

To achieve the desired resilience and high availability, you must first define your requirements.

## Workload availability targets

Define your own target SLAs for each workload in your solution so you can determine whether the architecture meets the business requirements.

### Consider cost and complexity

Everything else being equal, higher availability is better. But as you strive for more nines, the cost and complexity grow. An uptime of 99.99% translates to about five minutes of total downtime per month. Is it worth the additional complexity and cost to reach five nines? The answer depends on the business requirements.

Here are some other considerations when defining an SLA:

- To achieve four nines (99.99%), you can't rely on manual intervention to recover from failures. The application must be self-diagnosing and self-healing.

- Beyond four nines, it's challenging to detect outages quickly enough to meet the SLA.

- Think about the time window that your SLA is measured against. The smaller the window, the tighter the tolerances. It doesn't make sense to define your SLA in terms of hourly or daily uptime.

- Consider the MTBF and MTTR measurements. The higher your SLA, the less frequently the service can go down and the quicker the service must recover.

- Get agreement from your customers for the availability targets of each piece of your application, and document it. Otherwise, your design may not meet the customers' expectations.

### Identify dependencies

Perform dependency-mapping exercises to identify internal and external dependencies. Examples include dependencies relating to security or identity, such as Active Directory, or third-party services such as a payment provider or e-mail messaging service.

Pay particular attention to external dependencies that might be a single point of failure or cause bottlenecks. If a workload requires 99.99% uptime but depends on a service with a 99.9% SLA, that service can't be a single point of failure in the system. One remedy is to have a fallback path in case the service fails. Alternatively, take other measures to recover from a failure in that service.

The following table shows the potential cumulative downtime for various SLA levels.

| **SLA**| **Downtime per week**| **Downtime per month**| **Downtime per year** |
| - | - | - | - |
| 99%| 1.68 hours| 7.2 hours| 3.65 days |
| 99.9%| 10.1 minutes| 43.2 minutes| 8.76 hours |
| 99.95%| 5 minutes| 21.6 minutes| 4.38 hours |
| 99.99%| 1.01 minutes| 4.32 minutes| 52.56 minutes |
| 99.999%| 6 seconds| 25.9 seconds| 5.26 minutes |


 

Every organization has unique requirements, and you should design your applications to best meet your complex business needs. Defining a target SLA will make it possible to evaluate whether the architecture meets your business requirements. Some things to consider include:

- What are the availability requirements?

- How much downtime is acceptable?

- How much will potential downtime cost your business?

- How much should you invest in making the application highly available?

- What are the data backup requirements?

- What are the data replication requirements?

- What are the monitoring requirements?

- Does your application have specific latency requirements?

For additional guidance, refer to [Principles of the reliability pillar](/azure/architecture/framework/resiliency/principles).

### Identify critical system flows

Understanding critical system flows is vital to assessing overall operational effectiveness and should be used to inform a health model for the application. It can also tell if paths of the application are over or underutilized and should be adjusted to better meet business needs and cost goals.

Critical sub-systems or paths through the application may have higher expectations around availability, recovery, and performance due to the criticality of associated business scenarios and functionality. This also helps to understand if cost will be affected due to these higher needs.

### Identify less critical components

Some less critical components or paths through the application may have lower expectations around availability, recovery, and performance. This can result in cost reduction by choosing lower SKUs with less performance and availability.

## Availability metrics

Use these measures to plan for redundancy and determine customer SLAs.

- **Mean time to recover (MTTR)** is the average time it takes to restore a component after a failure.

- **Mean time between failures (MTBF)** is the how long a component can reasonably expect to last between outages.

## Understand service-level agreements

In Azure, the [Service Level Agreement](https://azure.microsoft.com/support/legal/sla/) describes Microsoft's commitments for uptime and connectivity. If the SLA for a particular service is 99.9%, you should expect the service to be available 99.9% of the time. Different services have different SLAs.

The Azure SLA also includes provisions for obtaining a service credit if the SLA is not met, along with specific definitions of availability for each service. That aspect of the SLA acts as an enforcement policy.

The [Service Level Agreement Estimator](https://github.com/mspnp/samples/tree/master/Reliability/SLAEstimator) sample shows how to calculate the SLA of your architecture.