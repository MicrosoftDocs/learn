Azure Site Recovery can replicate your virtual machine workloads between Azure regions. You can also use Site Recovery to migrate VMs from other environments, such as on-premises infrastructure, to Azure.  You'll see that Site Recovery can be used for much more than just a backing up and restoring infrastructure.

Your organization recently suffered an outage caused by a hurricane. You'll identify the Site Recovery features required to protect your Azure virtual machines (VMs) by enabling failing over to a secondary Azure region.

In this unit, you'll learn about the Site Recovery features that will help to handle future outages.

## Site Recovery features

Site Recovery manages the orchestration of disaster recovery in Azure. It is designed to replicate workloads from a primary site or region, to a secondary site. If the primary site has an issue, Site Recovery can replicate protected VMs to another Azure region.

Site Recovery manages the replication of Azure VMs between regions, or the replication of on-premises VMs to Azure and back again. Because it's built natively into Azure, Site Recovery can run seamless tests (disaster recovery drills) without affecting production workloads.

### Azure virtual machine protection

Site Recovery will protect your VM instances in Azure automatically. Site Recovery mirrors the source VM configuration, and creates required or associated resource groups, storage accounts, virtual networks, and availability sets to a secondary Azure region. The resources created are appended with a Site Recovery suffix.

### Snapshots and recovery points

Site Recovery has customizable replication policies that allow you to define the retention history of replication points, and the frequency of snapshots. The two types of snapshots available are **App-consistent** and **Crash-consistent**. The default settings for a new replication policy are:

- Crash-consistent recovery points every five minutes.
- App-consistent recovery points every 60 minutes.

The recovery points are kept for 24 hours by default, although this period can be extended to 72 hours.

Crash-consistent recovery represents the data on-disk at the time the snapshot is taken. App-consistent recovery captures the same data as crash-consistent but also includes all in-memory data and in-process transactions. Including the in-memory data means Site Recovery can restore a VM and any running apps without any data loss.

### Replication to secondary region

When replication is enabled for an Azure VM, the Site Recovery mobility service extension is installed. When the extension is installed, it will register the VM with Site Recovery. The process for continuous replication of the VM then begins, so any writes to the disk are immediately transferred to the cached storage account.

Site Recovery processes data stored in the cache and syncs it with either the target storage account or replicated managed disks. After the data is processed, crash-consistent recovery points are created every five minutes. If app-consistent recovery points are enabled, they'll be generated on a schedule as set in the Site Recovery replication policy.

### Accelerated networking support

Site Recovery allows you to use accelerated networking for any Azure virtual machines that have been failed over to a different Azure region.  Accelerated networking will enable single root I/O virtualization on a VM, this vastly improves network performance. High performance is achieved by bypassing the host from the data path. This method reduces latency and CPU use, allowing the most demanding workloads to handle it.

### Disaster recovery (DR) drills

Site Recovery allows you to perform disaster recovery drills, after all pre-requisite configuration tasks are complete. Running a DR drill enables you to validate the replication strategy for your environment without losing data, having downtime, or compromising your production environment. Drills don't affect your production environment, and are great way to test that you have correctly configured everything.

### Flexible failover and failback

Site Recovery failover and failback can be easily started using the Azure portal. When running a failover, you select a recovery point then let Site Recovery take care of the failover. Failback is simple a reverse of this process. Select the failover you want, clean it up, and then select to fail over back to the primary region using the chosen recovery point.
