The deployment scenarios described earlier rely extensively on Availability Sets. In some cases, these scenarios can be adapted to the use of Azure availability zones. This, however, warrants some other considerations and architectural changes.

An Azure availability zone is defined as: Unique physical locations within a region. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. As of the typical SAP NetWeaver or S/4HANA architecture, you need to protect three different layers:

- **SAP application layer**, which can be one to a few dozen virtual machines. You want to minimize the chance of virtual machines getting deployed on the same host server. You also want those virtual machines within acceptable proximity to the DBMS layer to keep network latency in an acceptable window.
- **SAP ASCS/SCS layer** that represents a single point of failure in the SAP NetWeaver and S/4HANA architecture. You usually look at two virtual machines that you want to cover with a failover framework. Therefore, these virtual machines should be allocated in different infrastructure fault and update domains.
- **SAP DBMS layer**, which represents a single point of failure as well. In the usual cases, it consists of two virtual machines that are covered by a failover framework. Therefore, these virtual machines should be allocated in different infrastructure fault and update domains. Exceptions are SAP HANA scale-out deployments where more than two virtual machines are can be used.

Every organization has unique requirements, and you should design your applications to best meet your complex business needs. Defining a target SLA makes it possible to evaluate whether the architecture meets your business requirements. Some things to consider include:

- What are the availability requirements?
- How much downtime is acceptable?
- How much will potential downtime cost your business?
- How much should you invest in making the application highly available?
- What are the data backup requirements?
- What are the data replication requirements?
- What are the monitoring requirements?
- Does your application have specific latency requirements?

Considerations for deciding to using availability zones:

- There are no guarantees regarding the distances between various availability zones within an Azure region.
- Availability zones aren't an ideal DR solution. Natural disasters can cause widespread damage in world regions, including heavy damage to power infrastructures. The distances between various zones might not be large enough to constitute a proper DR solution.
- The network latency across availability zones isn't the same in all Azure regions. In some cases, you can deploy and run the SAP application layer across the different zones because the network latency from one zone to the active DBMS virtual machine is acceptable. But in some Azure regions, the latency between the active DBMS virtual machine and the SAP application instance, when deployed in different zones, might not be acceptable for SAP business processes. In these cases, the deployment architecture needs to be different, with an active/active architecture for the application or an active/passive architecture where cross-zone network latency is too high.
- When deciding where to use availability zones, base your decision on the network latency between the zones. Network latency plays an important role in two areas:

  - Latency between the two DBMS instances that need to have synchronous replication. The higher the network latency, the more likely it affects the scalability of your workload.
  - The difference in network latency between a virtual machine running an SAP dialog instance in-zone with the active DBMS instance and a similar virtual machine in another zone. As this difference increases, the influence on the running time of business processes and batch jobs also increases, dependent on whether they run in-zone with the DBMS or in a different zone.

When you deploy Azure Virtual Machines across availability zones and establish failover solutions within the same Azure region, some restrictions apply:

- Azure Managed Disks must be used when you deploy to Azure availability zones.
- The mapping of zone enumerations to the physical zones is fixed on an Azure subscription basis. If you're using different subscriptions to deploy your SAP systems, you need to define the ideal zones for each subscription.
- You can't deploy Azure availability sets within an Azure availability zone. Choose one or the other as a deployment framework for virtual machines.
- You can't use an Azure Basic load balancer to create failover cluster solutions based on Windows Server Failover Clustering or Linux Pacemaker. Instead, you need to use the Azure Standard load balancer SKU.
