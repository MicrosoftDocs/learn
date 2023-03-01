Organizations like Tailwind Traders require a high degree of reliability from their mission-critical applications. To achieve the desired reliability for on-premises based apps, it's typical to purchase more computing resources, such as servers and storage. Companies can purchase more computing resources to build redundancy into their on-premises infrastructure.

It's also vital that any mission-critical application and its associated data are recoverable following a failure, and ideally, to the point of failure. The recoverability is often provided by backups, restore components, and procedures. For organizations with applications hosted in Azure, or organizations with hybrid application deployments, there are other considerations and options.

### Things to know about backup and recovery

Azure Architects address several points as they plan for backup and recovery of their infrastructure. Let's review some of the common concepts and prominent considerations.

- A primary goal for backup and recovery is to ensure your business applications are reliable:
   - Resilient to component failure
   - Highly available (can run in a healthy state with no significant downtime)

- To achieve your desired level of resilience and high availability, you need to accurately define your requirements:
   - Identify your business needs
   - Build your resiliency plan to address all of your business needs

   > [!NOTE]
   > In this module, _resiliency_ is the ability of a system to gracefully handle and recover from failures, both inadvertent and malicious.

- Requirements must be defined for each workload to back up, along with their usage patterns:

   - A **workload** is a distinct capability or task that's logically separated from other tasks in terms of business logic and data storage requirements. Each workload can have different requirements.
   
   - The **usage patterns** for a workload reveal differences in requirements to support the workload. Usage patterns can show how workload usage might change based on the time of day/week or region/geographic location.

- Calculate the availability metrics for your infrastructure components:

   - **Mean time to recovery (MTTR)**: Determine the average time it takes to restore a component after a failure. 
   - **Mean time between failures (MTBF)**: Identify how long a component can reasonably expect to last between outages.

- Account for the cost and risk of downtime or data loss, and calculate your recovery metrics:

   - **Recovery time objective (RTO)**: Set the maximum acceptable time one of your apps can be unavailable following an incident.
   - **Recovery point objective (RPO)**: Set the maximum duration of data loss that's acceptable during a disaster.
   - **Recovery level objective (RLO)**: Specify the granularity of your required recovery, such as recovering a web app, a website, or a specific resource. 

- Take into consideration documented service-level agreements (SLAs) along with your desired target SLAs for each workload.

### Things to consider when planning for backup and recovery

Now that you understand the prominent characteristics of planning for backup and recovery, let's examine how to apply these considerations to develop your own solution.

- **Consider your workloads and usage**. Identify all your business workloads and their associated usage. Record the unique usage requirements for each workload, such as availability, scalability, data consistency, and disaster recovery.

- **Consider usage patterns**. Identify the differences in requirements for reach workload during both critical and non-critical periods. To ensure uptime, plan redundancy across several regions in case one region fails. Conversely, to minimize costs during non-critical periods, you can run your application in a single region.

- **Consider availability metrics**. Capture MTTR and MTBF availability metrics for all your infrastructure components. Use these metrics to determine where you need to add redundancy, and to determine SLAs for customers.

- **Consider recovery metrics**. Determine your RTO, RPO, and RLO recovery metrics. Conduct a risk assessment to account for the cost and risk of downtime or data loss in your organization. Identify whether you need to be able to recover a server farm, a web application, a full website, or just a specific resource or component. 

   > [!TIP]
   > If the MTTR of any critical component in a highly available scenario exceeds the system RTO, then a failure in the system might cause an unacceptable business disruption. In other words, you can't restore the system within the defined RTO.

- **Consider availability targets**. Define your target SLAs for each workload to support your business scenarios. Be sure to account for the cost and complexity of meeting availability requirements, in addition to application dependencies.

- **Consider service SLAs**. Outline the documented SLAs for your services and compare them to your workload targets. Determine where changes in compute resources or storage might be needed.

   In Azure, the SLA describes the Microsoft commitments for uptime and connectivity. If the SLA for a particular service is 99.9 percent, you should expect the service to be available 99.9 percent of the time.

By including these considerations in your planning, you can define appropriate target SLAs for each workload in your solution. These targets help to ensure the architecture meets your business requirements. Suppose you have a workload that requires 99.99 percent uptime, but depends on a service with a 99.9 percent SLA. In this case, you can determine that the dependent service can't be a single point of failure in your system.

After you define your backup and recovery requirements, you're ready to select a suitable recovery technology.