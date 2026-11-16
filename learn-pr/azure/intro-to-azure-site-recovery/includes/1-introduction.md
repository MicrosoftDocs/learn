Azure Site Recovery lets IT administrators coordinate and automate disaster recovery for Azure virtual machines (VMs) between Azure regions and for supported on-premises Hyper-V VMs, VMware VMs, and physical servers to Azure. Returning a workload from Azure to an on-premises environment is a scenario-specific failback operation after an earlier failover, not general initial protection of native Azure VMs to an on-premises datacenter.

Site Recovery also supports disaster recovery between availability zones in supported Azure regions. This module focuses on on-premises-to-Azure and cross-region recovery, and explains when zone-to-zone protection addresses a different need.

Let's say that you're responsible for infrastructure operations at Adatum, which has several three-tier applications that run on virtual machines (VMs). All VM-hosted applications that were in Adatum's Melbourne datacenter were migrated to Azure, and the datacenter was decommissioned. Another set of applications is still running in Adatum's Sydney datacenter, and there are no plans to move these applications to Azure in the foreseeable future.

Until the closure of the Melbourne datacenter, you used Hyper-V Replica to replicate all the VMs between the Melbourne and Sydney datacenters to help recover the applications if one of the datacenters went offline. Now that the Melbourne datacenter is no longer available, you want the virtual machines in the Sydney datacenter to fail over to the Australia East Azure region if Adatum's Sydney datacenter becomes unavailable. This move to the Australia East Azure region should only be a temporary measure. Once service is restored, the virtual machine workloads should return to Adatum's Sydney datacenter.

Similarly, if the Australia East region becomes unavailable, Adatum wants to ensure that the IaaS VMs that are hosted in the Australia East Azure datacenter fail over to the Australia Southeast region. To achieve this protection, you want to:

- Perform regular tests to verify that the existing replication solution works as expected.
- Retain backups that allow workloads in either location to be recovered to a version from two weeks earlier, alongside Site Recovery for outage recovery.

After investigating Azure Site Recovery, you believe it can provide the disaster-recovery capability Adatum needs. You'll combine it with Azure Backup or another supported backup solution that meets the historical recovery requirement for each workload. This module explains what Site Recovery does, how it works, and when to choose it.

## Learning objectives

In this module, you'll:

- Learn about Azure Site Recovery and its capabilities.
- Determine whether Azure Site Recovery meets the needs of your organization.
- Understand the difference between Azure Site Recovery and Azure Backup.

## Prerequisites

- Understanding of basic networking concepts
- Understanding of basic high-availability and disaster-recovery concepts
