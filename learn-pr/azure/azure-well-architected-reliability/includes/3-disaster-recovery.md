Designing for high availability helps keep an application or process running despite unfavorable events and adverse conditions. But what do you do when something so significant happens that you've lost data and it's impossible to keep your apps and processes from going down? When disaster strikes, you need to have a plan to get your services running again. You should know what your goals and expectations are for recovering, what are the costs and limitations of your plan, and how to execute on it.

## What is disaster recovery?

Disaster recovery is about recovering from high-impact events that result in downtime and data loss. A disaster is a single, major event with an impact much larger and long-lasting than the application can mitigate through the high-availability portion of its design.

The word *disaster* often evokes thoughts of natural disasters and external events (earthquakes, floods, tropical storms, and so on) but many other kinds of disasters exist as well. A failed deployment or upgrade can leave an app in an unrecognizable state. Malicious hackers can encrypt or delete data and inflict other kinds of damage that take an app offline or eliminate some of its functionality.

Regardless of its cause, the best remedy for a disaster once it has occurred is a well-defined, tested disaster recovery plan and an application that actively supports disaster recovery efforts through its design.

## How to create a disaster recovery plan

A disaster recovery plan is a single document that details the procedures that are required to recover from data loss and downtime caused by a disaster, and identifies who's in charge of directing those procedures. Operators should be able to use the plan as a manual to restore application connectivity and recover data after a disaster occurs. A detailed, written plan that's dedicated to disaster recovery is critical to ensuring a favorable outcome. The process of creating the plan will help to assemble a complete picture of the application. The resulting written steps will promote good decision-making and follow-through in the panicked, chaotic aftermath of a disaster event.

Creating a disaster recovery plan requires expert knowledge of the application's workflows, data, infrastructure, and dependencies.

### Risk assessment and process inventory

The first step in creating a disaster recovery plan is performing a risk analysis that examines the impact of different kinds of disasters on the application. The exact nature of a disaster isn't as important to the risk analysis as its potential impact through data loss and application downtime. Explore various kinds of hypothetical disasters and try to be specific when thinking about their effects. For example, a targeted malicious attack may modify code or data that results in a different kind of impact than an earthquake that disrupts network connectivity and datacenter availability.

The risk assessment needs to consider *every* process that can't afford unlimited downtime, and every category of data that can't afford unlimited loss. When a disaster that affects multiple application components occurs, it's critical that the plan owners can use the plan to take a complete inventory of what needs attention and how to prioritize each item.

Some apps may only constitute a single process or classification of data. This is still important to note, as the application will likely be one component of a larger disaster recovery plan that includes multiple applications with the organization.

### Recovery objectives

A complete plan needs to specify two critical business requirements for each process implemented by the application:

* **Recovery Point Objective (RPO)**: The maximum duration of acceptable data loss. RPO is measured in units of time, not volume: "30 minutes of data", "four hours of data", and so on. RPO is about limiting and recovering from data *loss*, not data *theft*.
* **Recovery Time Objective (RTO)**: The maximum duration of acceptable downtime, where "downtime" needs to be defined by your specification. For example, if the acceptable downtime duration is eight hours in the event of a disaster, then your RTO is eight hours.

![An illustration showing the duration, in hours, of the recovery point objective and recovery time objective from the time of the disaster.](../media/3-rto-rpo.png)

Each major process or workload that's implemented by an app should have separate RPO and RTO values. Even if you arrive at the same values for different processes, each one should be generated through a separate analysis that examines disaster scenario risks and potential recovery strategies for each respective process.

The process of specifying an RPO and RTO is effectively the creation of disaster recovery requirements for your application. It requires establishing the priority of each workload and category of data and performing a cost-benefit analysis. The analysis includes concerns, such as implementation and maintenance cost, operational expense, process overhead, performance impact, and the impact of downtime and lost data. You'll need to define exactly what "downtime" means for your application, and in some cases, you may establish separate RPO and RTO values for different levels of functionality. Specifying RPO and RTO should be more than simply choosing arbitrary values. Much of the value of a disaster recovery plan comes from the research and analysis that goes into discovering the potential impact of a disaster and the cost of mitigating the risks.

### Detailing recovery steps

The final plan should go into detail about exactly what steps should be taken to restore lost data and application connectivity. Steps often include information about:

* **Backups**: How often they're created, where they're located, and how to restore data from them.
* **Data replicas**: The number and locations of replicas, the nature and consistency characteristics of the replicated data, and how to switch over to a different replica.
* **Deployments**: How deployments are executed, how rollbacks occur, and failure scenarios for deployments.
* **Infrastructure**: On-premises and cloud resources, network infrastructure, and hardware inventory.
* **Dependencies**: External services that are used by the application, including SLAs and contact information.
* **Configuration and notification**: Flags or options that can be set to gracefully degrade the application, and services that are used to notify users of application impact.

The exact steps that are required will depend heavily on implementation details of the app, making it important to keep the plan updated. Routinely testing the plan will help identify gaps and outdated sections.

## Designing for disaster recovery

Disaster recovery is not an automatic feature. It must be designed, built, and tested. An app that needs to support a solid disaster recovery strategy must be built from the ground up with disaster recovery in mind. Azure offers services, features, and guidance to help you create apps that support disaster recovery, but it's up to you to include them in your design.

Designing for disaster recovery has two main concerns:

* **Data recovery**: Using backups and replication to restore lost data.
* **Process recovery**: Recovering services and deploying code to recover from outages.

### Data recovery and replication

Replication duplicates stored data between multiple data store replicas. Unlike *backup*, which creates long-lived, read-only snapshots of data for use in recovery, replication creates real-time or near-real-time copies of live data. The goal of replication is to keep replicas synchronized with as little latency as possible while maintaining application responsiveness. Replication is a key component of designing for high availability and disaster recovery, and is a common feature of production-grade applications.

Replication is used to mitigate a failed or unreachable data store by executing a *failover*: changing application configuration to route data requests to a working replica. Failover is often automated, triggered by error detection built into a data storage product, or detection that you implement through your monitoring solution. Depending on the implementation and the scenario, failover may need to be manually executed by system operators.

Replication is not something you implement from scratch. Most fully featured database systems and other data storage products and services include some kind of replication as a tightly integrated feature due to its functional and performance requirements. However, it's up to you to include these features in your application design and make appropriate use of them.

Different Azure services support various levels and concepts of replication. For example:

* **Azure Storage** replication capabilities depend on the type of replication that is selected for the storage account. This replication can be local (within a datacenter), zonal (between data centers within a region), or regional (between regions). Neither your application nor your operators interact with it directly. Failovers are automatic and transparent, and you simply need to select a replication level that balances cost and risk.

* **Azure SQL Database** replication is automatic at a small scale, but recovery from a full Azure datacenter or regional outage requires geo-replication. Setting up geo-replication is manual, but it's a first-class feature of the service and well supported by documentation.

* **Azure Cosmos DB** is a globally distributed database system, and replication is central to its implementation. With Azure Cosmos DB you configure options related to regions associated with your database, data partitioning, and data consistency.

Many different replication designs exist that place different priorities on data consistency, performance, and cost. *Active* replication requires updates to take place on multiple replicas simultaneously, guaranteeing consistency at the cost of throughput. In contrast, *passive* replication performs synchronization in the background, removing replication as a constraint on application performance, but increasing RPO. *Active-active* or *multi-master* replication enables multiple replicas to be used simultaneously, enabling load balancing at the cost of complicating data consistency, while *active-passive* replication reserves replicas for live use only during failover.

![An illustration showing an example of geographical replication. The primary writable database is placed at South Central US, whereas the readable secondary databases are placed at two different locations: West US and East US.](../media/3-geo-replication.png)

> [!IMPORTANT]
> **Neither replication nor backup are complete disaster recovery solutions on their own**. Data recovery is only one component of disaster recovery, and replication will not fully satisfy many kinds of disaster recovery scenarios. For example, in a data corruption scenario, the nature of the corruption may allow it to spread from the primary data store to the replicas, rendering all the replicas useless and requiring a backup for recovery.

### Process recovery

After a disaster, business data isn't the only asset that needs recovering. Disaster scenarios will also commonly result in downtime, whether it's due to network connectivity problems, datacenter outages, or damaged VM instances or software deployments. The design of your application needs to enable you to restore it to a working state.

In most cases, process restoration involves failover to a separate, working deployment. Depending on the scenario, geographic location may be a critical aspect. For example, a large-scale natural disaster that brings an entire Azure region offline will necessitate restoring service in another region. Your application's disaster recovery requirements, especially RTO, should drive your design and help you decide how many replicated environments you should have, where they should be located, and whether they should be maintained in a ready-to-run state or should be ready to accept a deployment in the event of disaster.

Depending on the design of your application, there are a few different strategies and Azure services and features that you can take advantage of to improve your app's support for process recovery after a disaster.

#### Azure Site Recovery

Azure Site Recovery is a service that's dedicated to managing process recovery for workloads running on VMs deployed to Azure, VMs running on physical servers, and workloads running directly on physical servers. Site Recovery replicates workloads to alternate locations and helps you to failover when an outage occurs and supports testing of a disaster recovery plan.

![An illustration showing the role of Azure Site Recovery in replicating the workloads on three virtual machines located in the East US to West US.](../media/3-azure-site-recovery.png)

Site Recovery supports replicating whole VMs and physical server images as well as individual *workloads*, where a workload may be an individual application or an entire VM or operating system with its applications. Any application workload can be replicated, but Site Recovery has first-class integrated support for many Microsoft server applications, such as SQL Server and SharePoint, as well as a handful of third-party applications like SAP.

Any app that runs on VMs or physical servers should at least investigate the use of Azure Site Recovery. It's a great way to discover and explore scenarios and possibilities for process recovery.

#### Service-specific features

For apps that run on Azure PaaS offerings like App Service, most such services offer features and guidance for supporting disaster recovery. For certain scenarios, you can use service-specific features to support fast recovery. For example, Azure SQL Server supports geo-replication for quickly restoring service in another region. Azure App Service has a Backup and Restore feature, and the documentation includes guidance for using Azure Traffic Manager to support routing traffic to a secondary region.

![An illustration showing a regional pair, within a geography, consisting individual datacenters.](../media/3-region-pairs.png)

## Testing a disaster recovery plan

Disaster recovery planning doesn't end once you have a completed plan in hand. Testing the plan is a crucial aspect of disaster recovery, to ensure that the directions and explanations are clear and up-to-date.

Choose intervals to perform different types and scopes of tests, such as testing backups and failover mechanisms every month, and performing a full-scale disaster recovery simulation every six months. Always follow the steps and details exactly as they're documented in the plan, and consider having someone unfamiliar with the plan give perspective on anything that could be made clearer. As you execute the test, identify gaps, areas of improvement, and places to automate and add these enhancements to your plan.

Make sure to include your monitoring system in your testing as well. For example, if your application supports automated failover, introduce failures in a dependency or other critical component to ensure that the application behaves correctly end-to-end, including detection of the failure and triggering of the automated failover.

 By carefully identifying your requirements and laying out a plan, you'll be able to determine what types of services you'll need to use to meet your recovery objectives. Azure provides several services and features to help you meet these objectives.
