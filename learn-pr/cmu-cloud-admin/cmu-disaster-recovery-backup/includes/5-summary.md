Disaster planning and recovery is a critical element of IT operations, whether an organization's systems are located on-premises, in the cloud, or a combination of both. Public cloud platforms offer services for backing up critical data, restoring it when lost, failing over to secondary systems when primary systems go down, and generally mitigating (and recovering from) the effects of failures. Here are some of the key points covered in this module:

-   To the extent possible, IT systems should be fault-tolerant. A *fault-tolerant* (FT) system is one that behaves as expected, or in accordance with service level agreement (SLA) expectations, in the presence of faults.

-   One way to achieve fault tolerance is to employ reactive methods such as task replication and restoration points.

-   Proactive methods such as resource replication and load balancing can also contribute to fault tolerance.

-   Major cloud platforms offer backup services that provide a safety net against data loss. Azure Backup is one example of a cloud-based backup service; AWS Backup is another.

-   Disaster recovery seeks to provide business continuity by redirecting traffic to secondary systems when necessary. Cloud service providers such as Amazon and Microsoft offer Disaster-Recovery-as-a-Service (DRaaS) in the form of services such as AWS CloudEndure and Azure Site Recovery.

-   Common service-level objectives that drive disaster-recovery plans include Recovery Point Objective (RPO), Recovery Time Objective (RTO), and retention period.

-   *Continuity* is the successful application of best practices to achieve a positive outcome when disaster strikes. A key factor in continuity is *resilience*.

-   Resilience can be quantified using metrics such as fault tolerance, disruption tolerance, and survivability. The ResiliNets model offers one way to codify resilience.

-   The international standard for business continuity strategy is ISO 22301. Azure uses the Azure Resiliency Framework to achieve ISO 22301 compliance.

For an information system to be resilient, its caretakers must strive for an ideal: that information systems evolve like living things, through consistent improvement and monitoring by things that actually are living, not robotic. Automated processes serve a positive purpose, but they do not substitute for active effort.
