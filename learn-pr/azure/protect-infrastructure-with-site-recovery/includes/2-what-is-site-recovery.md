**Azure Site Recovery (ASR)** can replicate workloads between a Azure regions, and can also be used to migrate VMs from other environvments, such as on-premises infrastructure, to Azure.  **ASR** is much more than just a backup tool for restoring infrastructure.

Your first point of call is to understand the features of ASR, following your organizations recent outage from a hurricane. You need to identify the features required to failover existing Azure virtual machines (VMs) to a secondary region.

In this unit, you'll learn about the features of ASR and how they help towards preventing outages harnessing the power of the cloud.

## Azure Site Recovery Features

For most businesses, a loss of service can be catastrophic, having systems unavailable can cause lost revenue or come with large financial penalities for breaching contractual arrangements.

ASR can contribute towards your BCDR plan, formal documents for disaster recovery and continuity, to keep your workloads running when unplanned (or planned) outages occur. There are two tools in Azure that are designed to assist with this, **Azure Site Recovery**, and **Azure Backup**.

ASR is a native disaster recovery as a service (DRaaS) in Azure designed to replicate workloads from a primary site or region, to a secondary site. If the primary site has an issue ASR can automatically replicate protected VMs to another Azure region.

## Azure virtual machine protection

ASR will protect your VM instances in Azure automatically, once enabled, by mirroring the source VM infrastructure configuration and creating any required or associated resource groups, storage accounts, virtual networks and availability sets to a secondary Azure region. The resources created by ASR are appended with an asr suffix.

## Snapshots and recovery points

ASR has customizable replication policies built in, these policies allow you to define the retention history of replication points and the frequency of snapshots. There are two types of snapshots available **App-consistent** and **Crash-consistent**. The default settings for a new replication policy are:

- Crash consistent recovery points every 5 minutes.
- App-consistent recovery points every 60 minutes.

The recovery points are retained for 24 hours by default, although this can be extended to 72 hours.

Crash-consistent recovery represents the data on-disk at the time the snapshot is taken. App-consistent recovery captures the same data as crash-consistent but also includes all in memory data and in process transactions.

## Replication to secondary region

When replication is enabled for an Azure VM, the ASR mobility service extension gets installed. Once installed the extension will register the VM with ASR. This begins the process for continuous replication of the VM so any writes to the disk are immediately transferred to the cached storage account.
Following ASR processes data stored in the cache and syncs it with either the target storage account or replicated managed disks. Once the data has been processed crash-consistent recovery points get created every 5 minutes, if app-consistent recovery points are enabled these will be generated on a schedule as set in the ASR replication policy.

## Accelerated Networking support

ASR allows you to take advantage of accelerated networking for any Azure virtual machines that have been failed over to a different Azure region.  Accelerated Networking will enable single root I/O virtualization on a VM, this vastly improves the network performance. The high performance is achieved by bypassing the host from the datapath. This method reduces latency and CPU utilization allowing the most demanding workloads to use it.

## Disaster recovery drills

ASR allows you to perform disaster recovery drills, once all pre-requisite configuration tasks are complete. Running a DR drill which enable you to validate the replication strategy for your environment without losing data, having downtime or comprimising your production environment. Drills do not effect your production environment in any way.

## Flexible failover and failback

ASR Failover and failback can be initiated with a single click using the Azure Portal. When running a failover you simply need to select a Recovery Point and then let ASR take care of the failover for you. Failback, also has a simple process to flow. Simply select the desired failover, only failover committed VMs, clean it up and then select to failover back to the primary region using the chosen recovery point.