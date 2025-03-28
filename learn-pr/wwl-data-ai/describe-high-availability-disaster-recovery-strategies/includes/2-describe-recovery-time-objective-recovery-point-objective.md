Understanding recovery time and recovery point objectives are crucial to your high availability and disaster recovery (HADR) plan as they're the foundation for any availability solution.

## Recovery Time Objective

Recovery Time Objective (RTO) is the maximum amount of time available to bring resources online after an outage or problem. If that process takes longer than the RTO, there could be consequences such as financial penalties, work not able to be done, and so on. RTO can be specified for the whole solution, which includes all resources, and for individual components such as SQL Server instances and databases.

## Recovery Point Objective

Recovery Point Objective (RPO) is the point in time to which a database should be recovered and equates to the maximum amount of data loss that the business is willing to accept. For example, suppose an IaaS VM containing SQL Server experiences an outage at 10:00 AM and the databases within the SQL Server instance have an RPO of 15 minutes. No matter what feature or technology is used to bring back that instance and its databases, the expectation is that there will be at most 15 minutes worth of data lost. That means the database can be restored to 9:45 AM or later to ensure minimal to no data loss meeting that stated RPO. There may be factors that determine if that RPO is achievable.

## Defining Recovery Time and Recovery Point Objectives

RTOs (Recovery Time Objectives) and RPOs (Recovery Point Objectives) are driven by business requirements and many technological factors, including the skills of administrators. While businesses may desire no downtime or zero data loss, this is often unrealistic. Determining RTO and RPO should involve open discussions among all parties.

Understanding the cost of downtime is crucial for defining RTO and RPO. For example, if downtime costs the business $10,000 per hour or results in fines, this helps in setting realistic objectives. The investment in a High Availability and Disaster Recovery (HADR) solution should be proportional to the cost of downtime. If a solution prevents hours or days of downtime, it justifies its cost.

RTO should be defined at both the component level (for example, SQL Server) and the entire application architecture. The overall RTO is determined by the slowest component to recover. For instance, if SQL Server recovers in five minutes but application servers take 20 minutes, the overall RTO is 20 minutes.

RPO focuses on data and influences the design of HADR solutions and administrative policies. Features used must support the defined RTO and RPO. For example, if transaction log backups are scheduled every 30 minutes but the RPO is 15 minutes, the database can only be recovered to the last backup, which could be 30 minutes old. Regularly testing backups ensures their reliability.

The choice of solutions, such as Always On Availability Groups (AG) or Failover Cluster Instances (FCI), affects RTO and RPO. Depending on configuration, IaaS or PaaS solutions may not automatically fail over, leading to longer downtime. If RTO and RPO are unrealistic, they must be adjusted. For example, if a backup takes three hours to copy but the RTO is two hours, the RTO is missed.

RTOs and RPOs should be defined for both High Availability (HA) and Disaster Recovery (DR). HA events are localized and easier to recover from, such as an AG failing over within an Azure region, potentially taking seconds. DR involves bringing up a new data center, which can take hours or longer, hence separate RTOs and RPOs.

All RTOs and RPOs should be documented and periodically revised. Once documented, appropriate technologies and features can be considered for the architecture.