| :::image type="icon" source="../media/goal.svg"::: Create a workload that can anticipate and recover from most failures with minimal disruption to the user experience and business goals. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

Even highly resilient systems need disaster preparedness approaches, in both architecture design and workload operations. On the data layer, you should have strategies that can fix any corruption.

**Example scenario**

Contoso hosts a large amount of data on an on-premises SQL Server database and recently modernized their analytics solution for the data with Azure services. 

The new analytics solution uses Azure Analysis Services, Azure Data Factory, Azure Synapse Analytics, Power BI, and Azure Virtual Machines. All users are internal. After thinking about availability needs, the team decides to keep everything in one region. 

The data is ingested by using Azure Data Factory, processed, and then saved to the Analysis Services storage. Part of the process requires a legacy windows process, deployed to a VM in the cloud.

## Be prepared for disasters

**Have structured, tested, and documented recovery plans that match your recovery targets. Plans must cover all components in addition to the system as a whole.**

A well-defined process leads to a quick recovery that can prevent negative impacts on the finances and reputation of your business. Regular recovery drills test the process of recovering system components, data, and failover and failback steps to avoid confusion when time and data integrity are crucial.

*Contoso's challenge*

- The solution is only used internally and isn't considered mission-critical. So, the workload team and business stakeholders agree that rebuilding the solution in a secondary region is a sufficient recovery model if the Azure region where it's deployed goes down or the entire solution becomes unavailable for some other reason.

- The workload team outlines how to build the solution in another region in their disaster recovery (DR) plan. But they haven't done a full DR drill yet.

*Applying the approach and outcomes*

- After a regional outage, the DR response team follows the DR plan's instructions to redeploy the analytics solution in another region.

- The team finds gaps in the DR plans for some of the operations required to deploy the solution. The plan is updated to make the recovery more efficient in the future.
- The workload team and stakeholders agree to speed up the planned DR testing to ensure that the updated plan works better.

## Address stateful data

**Ensure that you can fix data for all stateful components within your recovery targets.**

Backups are essential to getting the system back to a working state by using a trusted recovery point, like the last-known good state.

Immutable and transactionally consistent backups ensure that data can't be changed and that the restored data isn't corrupted.

*Contoso's challenge*

- The workload team decides to move the SQL databases to Azure to speed up the analytics processing times. The VMs use one of the databases a lot during the analytics process. So the team needs to ensure that the database state can be recovered with the lowest possible recovery point objective (RPO).

*Applying the approach and outcomes*

- The databases are over 4 TB each, so the team can't move them to Azure SQL Database right now. Instead, the team moves them to Azure VMs that run SQL Server 2022.

- The team decides to use the Automated Backup function for all databases, including critical databases that the VMs use.
- For the critical databases, they're also using the Managed Instance link function to actively replicate the databases to an Azure SQL Managed Instance.

## Add automated self-healing capabilities to the design

**Use design patterns to add resilience to your workload through self-healing mechanisms.**

Self-healing capabilities let parts of the workload fix themselves by recovering affected components and, if needed, switching to backup infrastructure. 

Self-healing automation helps reduce risks from external factors like human intervention and shortens the time that it takes to fix problems.

*Contoso's challenge*

- The Windows process invoked from Azure Data Factory when ingesting data was initially deployed to multiple VMs for increased availability.

- There have been a few cases where the legacy Windows process has crashed, requiring a restart of the VM. While the processing time overall has been minimally affected (because of the level of redundancy), the team would like to implement a solution that automates the detection of the failure and the recovery.

*Applying the approach and outcomes*

- The team decides to implement an Azure Virtual Machine Scale Set solution, which is configured to deploy the Application Health Extension to continuously monitor the health of the VM process.

- With Automatic Instance Repair enabled, the scale set is now able to repair the component by restarting the VM or creating a new instance based on the same image.