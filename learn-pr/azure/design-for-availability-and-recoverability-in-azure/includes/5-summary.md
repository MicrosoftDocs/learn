We've discussed how to make your application available and recoverable by architecting for high availability, disaster recovery, and backups. Let's take a look at some of the key takeaways.

## High availability

- High availability is the ability to handle the loss or severe degradation of a component of a system.
- Evaluate your application for high availability by focusing on three key areas:
  - Your defined SLA.
  - The HA capabilities of your application.
  - The HA capabilities of dependent applications.
- Use availability sets and availability zones on Azure to provide HA for VM workloads.
- Use load balancing services such as Azure Traffic Manager, Azure Application Gateway, and Azure Load Balancer to distribute load across available systems.
- PaaS services have HA built in, so leverage these services in your architecture where possible.

## Disaster recovery

- Disaster recovery is about *recovering from high-impact events* that result in downtime and loss of data.
- Create a disaster recovery plan to define the procedures, responsibilities, and activities needed to recover from a disaster.
- Define the RPO and RTO for your application to help determine the DR requirements for your application.
- Use backup and replication to provide copies of your systems and data to recover to.
- Use Azure Site Recovery for DR process recovery capabilities for your application.
- Test your disaster recovery plan to identify gaps and relevance of steps.

## Backup and restore

- Use backups to restore your data as part of your DR strategy or for more isolated data loss scenarios.
- Use Azure Backup for full VM backup, file and folder backup, and backup of systems in an on-premises environment.
- Backup capabilities are often built into PaaS services, such as Azure SQL Database and Azure App Service. Take advantage of these backup capabilities when possible, understand their default configuration and overall capabilities.
- Test your restoration processes and procedures regularly to ensure they are valid and sufficient.
