No matter how well you plan, things sometimes go wrong. An organization that owns and manages IT resources must plan for the worst case and assume the worst case will someday occur. Disaster planning and recovery is one of the most critical elements of IT.

Modern cloud platforms provide a variety of tools to help organizations prepare for adverse circumstances and mitigate their effects when they occur. Cloud-based backup services, for example, can make replicas of data stored on-premises so the data can be restored in the event that it is deleted, corrupted, or destroyed. IaaS resources such as virtual machines and SQL workloads can be backed up as well. Some PaaS services feature automatic backups. Azure SQL Database, for example, creates full backups once a week, differential backups every 12 hours, and transaction log backups every few minutes. The backups are stored in geo-redundant storage that is replicated to a paired data center. Lost or damaged databases are easily restored from backups to a time of your choosing in the past.

Data loss isn't the only "disaster" that IT professionals must plan for. A comprehensive disaster-recovery plan also ensures the continuity of the business -- for example, redirecting requests ("failing over") to a secondary location when an application becomes unresponsive or an entire region of a public cloud suffers an outage. The cloud helps in this regard, too, by offering Disaster-Recovery-as-a-Service (DRaaS). The objective of systems architecture today is to avoid any reliance whatsoever upon one part that could become a single point of failure. This is the guiding principle of *resilience*: to permit and even plan for a reasonable degree of failure within the system, while at the same time maintaining acceptable service levels for an organization and its customers.

In this module, we begin with a comprehensive explanation of bugs, faults, and failures. Next, we introduce replication techniques for backing up applications, services, and data to minimize the chances of loss to the business and examine the backup services offered by leading cloud service providers. From there, we dive into disaster recovery, DRaaS, and mechanisms for achieving business continuity. Finally, we discuss how principles of resilience in cloud computing are altering organizations' approaches to preparedness, trading reactive measures for proactive ones.

## Learning objectives

- Understand the meaning of "fault tolerance"
- List reactive techniques used to achieve fault tolerance in cloud platforms
- List proactive techniques used to achieve fault tolerance in cloud platforms
- Understand the backup services offered by leading cloud service providers
- Understand the role that backup services play in disaster response and recovery
- Explain the difference between backup services and disaster-recovery services
- List the service-level objectives that drive disaster-recovery planning
- List the disaster-recovery services offered by leading cloud service providers
- Explain what resilience is and how it is measured
- Explain how resilience contributes to business continuity

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers
- Know the different type of clouds (public, private, hybrid)
- Recognize cloud service models such as IaaS, PaaS, and SaaS and differentiate between them
- Understand how cloud resource provisioning works
- Know how data centers work and how data is stored in the cloud
- Understand the basics of cloud security
