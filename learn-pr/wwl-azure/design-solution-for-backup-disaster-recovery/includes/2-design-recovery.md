Organizations, such as Tailwind Traders, require a high degree of reliability from their mission-critical apps. To achieve the desired reliability for on-premises based apps, it's typical to purchase more computing resource, such as servers and storage. By purchasing more computing resources, organizations can build redundancy into their on-premises infrastructure.

It's also vital that any mission-critical app, and its associated data, is recoverable following a failure-ideally to the point of failure. This recoverability is often provided by backup, restore components, and procedures. For organizations with apps hosted in Azure, or organizations with hybrid app deployments, there are other considerations and options.

Reliable apps are those which are:

- Resilient to component failure.

- Highly available and can run in a healthy state with no significant downtime.

To achieve the desired resilience and high availability, you must first define your requirements.

>[!NOTE]
>This module will use the term resiliency as the ability of a system to gracefully handle and recover from failures, both inadvertent and malicious.

 

### Define your requirements

Defining your requirements involves:

- Identifying your business needs.

- Building your resiliency plan to address those needs.

Use the following table of considerations to provide guidance on this process.

| **Consideration**| **Description** |
| - | - |
| What are your workloads and their usage?| A workload is a distinct capability or task that is logically separated from other tasks, in terms of business logic and data storage requirements. Each workload probably has different requirements for availability, scalability, data consistency, and disaster recovery. |
| What are the usage patterns for your workloads?| Usage patterns can determine your requirements. Identify differences in requirements during both critical and non-critical periods. To ensure uptime, plan redundancy across several regions in case one region fails. Conversely, to minimize costs during non-critical periods, you can run your application in a single region. |
| What are the availability metrics?| Mean time to recovery (MTTR) and mean time between failures (MTBF) are the typically used metrics. MTBF is how long a component can reasonably expect to last between outages. MTTR is the average time it takes to restore a component after a failure. Use these metrics to determine where you need to add redundancy, and to determine service-level agreements (SLAs) for customers. |
| What are the recovery metrics?| The recovery time objective (RTO) is the maximum acceptable time one of your apps can be unavailable following an incident. The recovery point objective (RPO) is the maximum duration of data loss that is acceptable during a disaster. Also consider the recovery level objective (RLO). This metric determines the granularity of recovery. In other words, whether you must be able to recover a server farm, a web app, a site, or just a specific item. To determine these values, conduct a risk assessment. Ensure that you understand the cost and risk of downtime or data loss in your organization. |
| What are the workload availability targets?| To help ensure that your app architecture meets your business requirements, define target SLAs for each workload. Account for the cost and complexity of meeting availability requirements, in addition to application dependencies. |
| What are your SLAs?| In Azure, the SLA describes the Microsoft commitments for uptime and connectivity. If the SLA for a particular service is 99.9 percent, you should expect the service to be available 99.9 percent of the time. |


 

> [!TIP]
> If the MTTR of any critical component in a highly available scenario exceeds the system RTO, then a failure in the system might cause an unacceptable business disruption. In other words, you can't restore the system within the defined RTO.

 

Define your own target SLAs for each workload in your solution by answering the preceding questions. This helps ensure that the architecture meets your business requirements. For example, if a workload requires 99.99 percent uptime, but depends on a service with a 99.9 percent SLA, that service can't be a single point of failure in the system.

After you've defined your recovery requirements, you're ready to select a suitable recovery technology.