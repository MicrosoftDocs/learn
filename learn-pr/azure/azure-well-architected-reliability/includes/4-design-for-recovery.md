| :::image type="icon" source="../media/goal.svg"::: The workload must be able to anticipate and recover from most failures, of all magnitudes, with minimal disruption to the user experience and business objectives. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

Even highly resilient systems need disaster preparedness approaches, in both architecture design and workload operations. On the data layer, you should have strategies that can repair workload state if there’s corruption.

**Example scenario**

Contoso currently hosts a large amount of data on an on-premises SQL Server database and has recently modernized their analytics solution for the data with Azure services. 

The new analytics solution utilizes Azure Analysis Services, Azure Data Factory, Azure Synapse Analytics, Power BI, and Azure Virtual Machines. All users of the solution are internal. After considering the availability requirements of the solution, the team decides to implement the solution in a single region. 

The data is ingested using Azure Data Factory and processed before being saved to the Analysis Services storage. Part of the process requires a legacy windows process, deployed to a VM in the cloud.

## Be prepared for disasters

**Have structured, tested, and documented recovery plans that are aligned with the negotiated recovery targets. Plans must cover all components in addition to the system as a whole.**

A well-defined process leads to a quick recovery that can prevent negative impact on the finances and reputation of your business. Conducting regular recovery drills tests the process of recovering system components, data, and failover and failback steps to avoid confusion when time and data integrity are key measures of success.

*Contoso's challenge*

- The solution is only used internally and isn't considered mission-critical. So, the workload team and business stakeholders agree that rebuilding the solution in a secondary region is a sufficient recovery model in the unlikely event that the Azure region where it is deployed is lost or the entire solution becomes unavailable for some other reason.
- The workload team describes how to build the solution in another region in their DR plan, but hasn't had the opportunity to perform a full DR drill yet.

*Applying the approach and outcomes*

- After experiencing a regional outage, the DR response team is able to follow the DR plan's instructions to redeploy the analytics solution in another region.
- The team discovers gaps in the DR plans for some of the operations required to deploy the solution, and the plan is updated to make the recovery more efficient in the future.
- The workload team and stakeholders agree to accelerate the planned DR testing to ensure that the updated plan enables a more efficient recovery.

## Address stateful data

**Ensure that you can repair data of all stateful components within your recovery targets.**

Backups are essential to getting the system back to a working state by using a trusted recovery point, like the last-known good state.

Immutable and transactionally consistent backups ensure that data can't be altered, and that the restored data isn't corrupted.

*Contoso's challenge*

- The workload team decides to move the SQL databases to Azure to cut down on the analytics processing times.  One of the databases is heavily used during the analytics process by the VMs, so the team needs to ensure that the database state can be recovered with the lowest possible RPO.

*Applying the approach and outcomes*

- Since the databases are large at over 4 TB each, migrating to Azure SQL Database isn’t achievable in the short term. So, the team migrates to Azure VMs running SQL Server 2022.
- The team decides to use the Automated  Backup function for all databases, including the critical ones, like the one used by the VMs.
- For the critical databases, the team plans to use the Automated Backup function along with the Managed Instance link function to actively replicate the databases to an Azure SQL Managed Instance.

## Implement automated self-healing capabilities in the design

**Self-healing capabilities are mechanisms that allow components of the workload to automatically resolve issues by recovering affected components and if needed, failing over to redundant infrastructure. Use design patterns to add resilience to your workload through self-healing mechanisms.**

Self-healing automation helps to reduce risks from external factors like human intervention, and shortens the break-fix cycle.

*Contoso's challenge*

- The Windows process invoked from Azure Data Factory when ingesting data was initially deployed to multiple VMs for increased availability.
- There have been a few cases where the legacy Windows process has crashed, requiring a restart of the VM. While the processing time overall has been minimally affected (because of the level of redundancy), the team would like to implement a solution that automates the detection of the failure and the recovery.

*Applying the approach and outcomes*

- The team decides to implement an Azure Virtual Machine Scale Set solution, which is configured to deploy the Application Health Extension to continuously monitor the health of the VM process.
- With Automatic Instance Repair enabled, the scale set is now able to repair the component by restarting the VM or creating a new instance based on the same image.