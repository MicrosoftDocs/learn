This unit focuses on resiliency design best practices for application deployments with different resiliency requirements. Typically, customers classify applications into categories or tiers based on these requirements. In this unit, we use an example application from each category to discuss how you can design applications to be resilient to different types of failures. The applications we address are:

- Tier 4 application. 99% availability SLO, 24-hour RPO, 72-hour RTO
- Tier 3 application. 99.95% availability SLO, 4-hour RPO, 8-hour RTO
- Tier 2 application. 99.99% availability SLO, 30-minute RPO, 4-hour RTO
- Tier 1 application. 99.99% availability SLO, 5-minute RPO, 1-hour RTO

> [!IMPORTANT]
> Cross Region Restore requires a supported workload and must be enabled on a geo-redundant Recovery Services vault. It restores recovery points already available in the paired region; it doesn't provide continuous replication of the running application. For Azure VM backups, the secondary-region RPO can be up to 36 hours in the worst case. Treat it as a recovery fallback, and verify that the age of available recovery points and the complete restore time meet the applicable RPO and RTO.

## Tier 4 application design pattern

Tier 4 applications have less stringent availability requirements. The example application has a 99% availability SLO, a 24-hour RPO, and a 72-hour RTO. Tier 4 applications can be internal applications, such as tooling applications, build servers, and project document-sharing websites.

A multi-tier web application in this category can be deployed within an Azure region with a single VM for each tier. If you want an explicit SLA guarantee at the VM level, you can use premium storage for your VMs. For a relatively important application in this category, weigh the benefits of premium storage for the database VM against its additional cost. The databases can be backed up using backup software. For example, use Azure Backup to configure database backups for SQL Server and SAP HANA running on Azure VMs. You can also precreate Azure Resource Manager (ARM) templates for your VMs so that you can redeploy them if there's an issue with the single-instance VM in any tier in that region. For the database VM, you can use a backup copy to recreate the databases.

You can use Azure Backup on your single-instance VMs to protect your data and test backups using its restore feature. If there's any data or VM-level corruption, you can recover the file, folder, disk, or VM using Azure Backup's restore capabilities. You can also protect application data stored in Azure Blobs, Azure Disks, and Azure File Shares, providing recovery from data corruption or loss.

For disaster recovery during a regional failure, consider replicating only the database VM with Azure Site Recovery. The web and app tier VMs can be redeployed in another Azure region using ARM templates if they're stateless or can be recovered from a backup copy. Note that the recovery time could be high for this approach. If you can accept higher costs, replicate the VMs across all tiers to another region. Azure Site Recovery doesn't require running additional VM instances in the disaster recovery region. The VMs are created only when you perform failover operations.

You can monitor the health of the web application by using an automation script that periodically checks if the website endpoint is reachable. Create a custom endpoint that reports on the overall health of the application. The endpoint should return an HTTP error code if any critical dependency is unhealthy or unreachable. Don't report errors for noncritical services, however.  

> [!NOTE]
> Use dependency-aware readiness checks to decide whether an instance can serve requests. When a platform uses probes to restart processes, use a separate, shallow liveness check: restarting a healthy process doesn't repair a failed shared dependency. Configure probe timeouts and failure thresholds so that brief failures don't trigger unnecessary recovery actions.

You can use a precreated script to monitor VM health metrics for issues. You can also troubleshoot issues by checking these metrics in the Azure portal. Check component health, such as CPU, memory, and disk usage, for potential load issues. If you consistently see issues with components such as CPU or RAM, consider resizing the VM to a larger size or scaling the application by deploying more VMs at each tier.

> [!NOTE]
> Azure provides host-level VM metrics, but guest operating-system telemetry requires additional collection configuration. Configure Azure Monitor Agent with data collection rules to collect guest performance data such as memory and filesystem usage. VM insights can simplify onboarding by deploying the agent and a preconfigured performance-data collection rule; it isn't an agentless alternative.

You can deploy application software updates on the VMs using automation scripts during a weekend maintenance window. Make sure you have an automated rollback script ready if any issues occur during deployment.

The following table provides a resiliency strategy for a Tier 4 application.
 
| **Failure type** | **Resilience strategy** |
|:---|:---|
| **Hardware failure** | Use ready-to-use templates to deploy another instance using backup copies if required. Test your templates by deploying VMs into a test subnet or a test virtual network. |
| **Datacenter failure** | Use ready-to-use templates to deploy another instance in another zone using backup copies if required. Test your templates by deploying VMs into a test subnet or a test virtual network in another availability zone. |
| **Regional failure** | Use Azure Site Recovery to replicate the database VM. Test disaster recovery using Test failover and Azure Site Recovery recovery plans. Perform disaster recovery failover in the event of an extended outage in the source region. Where supported and enabled, Azure Backup Cross Region Restore can recover Azure VMs from recovery points already available in the paired secondary region. Validate this option against the secondary recovery-point age and end-to-end recovery-time limitations described above; it doesn't by itself establish the tier's RPO or RTO. |
| **Heavy load** | Use monitoring tools to identify load surges on the VM. Scale up by increasing the VM size, or scale out by adding more instances. |
| **Accidental data deletion or corruption** | Use Azure Backup to back up the VM, protect SQL Server and SAP databases running on Azure VMs, and back up data stored in Azure Disks, Azure Blobs, and Azure File Shares. Restore these resources if data is lost or corrupted. |
| **Application deployment failure** | Use automation scripts to deploy updates. If there's an issue during or after an update, roll back to the previous version with an automated script. Also, use Azure Backup's on-demand backup of protected resources before an application deployment or upgrade. Use the backup to restore a previously known state if deployment fails. |

## Tier 3 application design pattern

Tier 3 applications are business-critical and require high availability, but they can tolerate some downtime. This example Tier 3 application has a 99.95% availability SLO, a 4-hour RPO, and an 8-hour RTO requirement. Tier 3 applications can include internal expense management or travel management applications. A few hours of downtime might affect operations but won't significantly affect revenue. Lower-revenue, customer-facing applications can also be part of this category.

Deploy at least two VMs in an availability set for each tier to reduce correlated hardware failures. Meeting the conditions of the VM availability-set SLA doesn't provide an end-to-end application SLA. For illustration, three independent, required tiers each modeled at 99.95% availability give approximately 99.85% availability before other dependencies are considered. Design and validate redundancy against the availability target for the complete critical user flow.

For local database high availability, use SQL Server Always On availability groups with synchronous-commit primary and secondary replicas. Lossless failover requires a synchronized target. For SQL Server on Windows, automatic failover also requires both replicas to be configured for automatic failover, cluster quorum, and a failure that meets the configured failover policy. Asynchronous-commit replicas are useful for geographically separated disaster recovery, but while configured in that mode support only forced manual failover with possible loss of transactions that haven't reached the secondary replica.

Configure appropriate health-aware routing and failover for each tier. Load-balancer health probes allow new connections to be directed to healthy instances after a failure is detected. In-flight requests and existing connections can still fail, so applications need suitable timeout, retry, and reconnection behavior.

Azure Backup helps quickly restore Azure virtual machines from recent backups using the Instant Restore feature, eliminating the need to transfer a backup from vault storage to the customer's subscription and thereby lowering RTO. Restore options include creating a new virtual machine, restoring disks, or recovering a specific file or folder to meet different needs. By configuring backups for Azure Blobs, Azure Disks, and Azure File Shares, you can also restore application data stored in these Azure services. Databases are critical to many applications. Azure Backup provides point-in-time recovery for SQL Server databases, including those in Always On availability groups, and SAP HANA databases running on Azure VMs, with an RPO as low as 15 minutes.

For disaster recovery during a regional failure, consider replicating only the database VM with Azure Site Recovery. The web and app tier VMs can be redeployed in another Azure region using ARM templates if they're stateless or can be recovered from a backup copy. Note that the recovery time could be high for this approach. If you can accept higher costs, replicate the VMs across all tiers to another region. Azure Site Recovery doesn't require running additional VM instances in the disaster recovery region. The VMs are created only when you perform failover operations.

You can monitor the health of the web application by using an automation script that periodically checks if the website endpoint is reachable. Create a custom endpoint that reports on the overall health of the application. The endpoint should return an HTTP error code if any critical dependency is unhealthy or unreachable.  

You can use a precreated script to monitor VM health metrics for issues. You can also troubleshoot issues by checking these metrics in the Azure portal. Check component health, such as CPU, memory, and disk usage, for potential load issues. If you consistently see issues with components such as CPU or RAM, consider resizing the VM to a larger size or scaling the application by deploying more VMs at each tier. Monitor database replication health, replication lag, and failover events for both synchronous and asynchronous configurations.

You can deploy application software updates on the VMs using automation scripts during a weekend maintenance window. Make sure you have an automated rollback script ready if any issues occur during deployment.

The following table provides a resiliency strategy for a Tier 3 application.

| **Failure type** | **Resiliency strategy** |
|:---|:---|
| **Hardware failure** | Build redundancy by deploying two or more instances in an availability set within a datacenter. |
| **Datacenter failure** | Use ready-to-use templates to deploy another instance in another availability zone using backup copies if required. Test your templates by deploying VMs into a test subnet or a test virtual network in another zone. |
| **Regional failure** | Use Azure Site Recovery to replicate the database VM. Test disaster recovery using Test failover and Azure Site Recovery recovery plans. Perform disaster recovery failover in the event of an extended outage in the source region. Where supported and enabled, Azure Backup Cross Region Restore can recover Azure VMs from recovery points already available in the paired secondary region. Validate this option against the secondary recovery-point age and end-to-end recovery-time limitations described above; it doesn't by itself establish the tier's RPO or RTO. |
| **Heavy load** | Use monitoring tools to identify load surges on the VM. Scale up by increasing the VM size, or scale out by adding more instances. |
| **Accidental data deletion or corruption** | Use Azure Backup to back up the VM, protect SQL Server and SAP databases running on Azure VMs, and back up data stored in Azure Disks, Azure Blobs, and Azure File Shares. Restore these resources if data is lost or corrupted. |
| **Application deployment failure** | Use safe deployment practices to roll out updates to a small set of customers before deploying them widely. Use automation scripts with automatic rollback capabilities if there's an issue with the update. Configure alerts to send alarms or notifications if an issue occurs after deployment, and have an automated rollback script ready to execute. Additionally, use Azure Backup's on-demand backup feature to back up protected resources before an application deployment or upgrade. Use the backup to restore a previously known state if deployment fails. |


## Tier 2 application

Tier 2 applications are business-critical and can significantly affect revenue if there's downtime. The sample application has a 99.99% availability SLO, a 30-minute RPO, and a 4-hour RTO. Examples include external customer-facing e-commerce websites, content-streaming platforms, and financial transaction-handling applications. The application should be highly available with resilience to all component failures.

The following table summarizes resiliency strategies for Tier 2 applications deployed in Azure.


| **Failure type** | **Resiliency strategy** |
|:---|:---|
| **Hardware failure** | Build redundancy by deploying two or more instances across availability zones within a region.  |
| **Datacenter failure** | Build redundancy by deploying two or more instances across availability zones within a region. |
| **Regional failure** | Use Azure Site Recovery to replicate the database VM. Test disaster recovery using Test failover and Azure Site Recovery recovery plans. Perform disaster recovery failover in the event of an extended outage in the source region. Where supported and enabled, Azure Backup Cross Region Restore can recover Azure VMs from recovery points already available in the paired secondary region. Validate this option against the secondary recovery-point age and end-to-end recovery-time limitations described above; it doesn't by itself establish the tier's RPO or RTO. Include a tested recovery or redeployment procedure for the web and application tiers and their dependencies; database recovery alone doesn't restore the complete application. |
| **Heavy load** | Provision enough capacity for the application. Use tools to monitor the load and add more instances automatically using scripts if the threshold is hit (say, 70%). |
| **Accidental data deletion or corruption** | Use Azure Backup to back up the VM, protect SQL Server and SAP databases running on Azure VMs, and back up data stored in Azure Disks, Azure Blobs, and Azure File Shares. Restore these resources if data is lost or corrupted. Match protection to each data source. The [Enhanced Azure VM backup policy](/azure/backup/backup-azure-vms-enhanced-policy) supports scheduled backups as frequently as every four hours; [Azure Disk Backup](/azure/backup/backup-managed-disks#create-backup-policy-for-azure-disks) uses hourly or longer schedules, depending on disk type. These scheduled backups alone don't establish a 30-minute logical-data-loss RPO. For affected data, validate a supported finer-grained recovery approach against that target, or obtain approval for a separate recovery objective for this scenario. |
| **Application deployment failure** | Use safe deployment practices to roll out updates to a small set of customers before deploying them widely. Use automation scripts with automatic rollback capabilities if there's an issue with the update. Configure alerts to send alarms or notifications if an issue occurs after deployment, and have an automated rollback script ready to execute. Additionally, use Azure Backup's on-demand backup feature to back up protected resources before an application deployment or upgrade. Use the backup to restore a previously known state if deployment fails. |

## Tier 1 application design pattern

Tier 1 applications are business-critical and mission-critical, like Tier 2. They have stricter requirements for data loss and recovery time. In this example, a Tier 1 application is assigned a 99.99% availability SLO, a 5-minute RPO, and a 1-hour RTO. More than a few minutes of data loss can significantly affect revenue and business operations. Customer-facing applications such as order processing systems and banking applications fall into this category.

> [!IMPORTANT]
> Validate recovery targets separately for regional outages and logical data loss. Azure Backup's 15-minute SQL Server and SAP HANA log-backup protection alone doesn't establish this example's five-minute RPO. Use an additional validated protection strategy, or document a different recovery objective for that failure scenario.

The following table summarizes resiliency strategies for Tier 1 applications deployed in Azure.

| **Failure type** | **Resiliency strategy** |
|:---|:---|
| **Hardware failure** | Build redundancy by deploying two or more instances across availability zones within a region. |
| **Datacenter failure** | Build redundancy by deploying two or more instances across availability zones within a region. |
| **Regional failure** | Use Azure Site Recovery to replicate all the VMs in the web and middle tiers. Use native replication technologies such as SQL Always On. Test disaster recovery for the complete application, including SQL Always On failover, using Azure Site Recovery recovery plans and Test failover capabilities. Perform disaster recovery failover in the event of an extended outage in the source region. |
| **Heavy load** | Provision enough capacity for the application. Use tools to monitor the load and add more instances automatically using scripts if the threshold is hit (say, 70%). |
| **Accidental data deletion or corruption** | Use Azure Backup to back up the VM, protect SQL Server and SAP databases running on Azure VMs, and back up data stored in Azure Disks, Azure Blobs, and Azure File Shares. Restore these resources if data is lost or corrupted. This backup option alone doesn't establish the five-minute RPO; validate a logical-data-recovery strategy against that target, or obtain approval for a different objective for this scenario. |
| **Application deployment failure** | Use safe deployment practices to roll out updates to a small set of customers before deploying them widely. Use automation scripts with automatic rollback capabilities if there's an issue with the update. Configure alerts to send alarms if an issue occurs after deployment, and have an automated rollback script ready to execute. Additionally, use Azure Backup's on-demand backup feature to back up protected resources before an application deployment or upgrade. Use the backup to restore a previously known state if deployment fails. |
