Azure Site Recovery lets IT administrators coordinate and automate the replication of Azure Virtual Machines (VMs) between regions, on-premises VMs, and physical servers to Azure, Azure VMs to on-premises VMs and on-premises machines to secondary datacenters.

Let's say that you're responsible for infrastructure operations at Adatum, which has several three-tier applications that run on virtual machines (VMs). All VM-hosted applications that were in Adatum's Melbourne datacenter have been migrated to Azure, and the datacenter has been decommissioned. Another set of applications is still running in Adatum's Sydney datacenter, and there are no plans to move these applications to Azure in the foreseeable future.

Until the closure of the Melbourne datacenter, you used a Hyper-V replica to replicate all the VMs between the Melbourne and Sydney datacenters to ensure that the applications remained available if one of the datacenters went offline. Now that the Melbourne datacenter is no longer available, you want the virtual machines in the Sydney datacenter to fail over to the Australia East Azure region if Adatum's Sydney datacenter becomes unavailable. This move to the Australia East Azure region should only be a temporary measure; once service is restored, the VM workloads should return to Adatum's Sydney datacenter.

Similarly, Adatum wants to ensure that the IaaS VMs that are hosted in the Australia East Azure datacenter fail over to the Australia Southeast region if the Australia East region becomes unavailable. To achieve this, you want to:

- Perform regular tests to verify that the existing replication solution works as expected.
- Configure the failover to occur to a previous version of the replicated workload as a measure of protecting against data corruption, with the preferred option being two weeks.

You've investigated Azure Site Recovery and believe that this Azure service can achieve these goals. This module explains what Azure Site Recovery does, how it works, and when you should choose to use Azure Site Recovery as a solution to meet your organization's needs.

## Learning objectives

In this module, you'll:

- Learn about Azure Site Recovery and its capabilities.
- Determine whether Azure Site Recovery meets the needs of your organization.
- Understand the difference between Azure Site Recovery and Azure Backup.

## Prerequisites

- Understanding of basic networking concepts
- Understanding of basic high-availability and disaster-recovery concepts
