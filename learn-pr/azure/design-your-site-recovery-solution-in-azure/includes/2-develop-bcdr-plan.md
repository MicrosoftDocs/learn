Your organization wants you to design a site recovery strategy for your applications. First, you should understand the specific requirements for building site recovery for your hybrid environment. You must also understand what tools are available in Azure to help you.

In this unit, you learn how to identify key infrastructures, recovery time objectives (RTOs), and recovery point objectives (RPOs). You learn what requirements might be relevant with any platform as a service (PaaS) services that you might be using. You also learn how to plan for backup and disaster recovery. Finally, you discover some of the Azure features that help you build a site recovery solution.

## Business continuity and disaster recovery

You need to develop a BCDR plan to design an appropriate site recovery solution. BCDR refers to a process that helps you restore your applications to a functional state after a significant event. This event could be a natural disaster, such as an earthquake. Or it could be technical in nature, such as the deletion of a database. These events are typically broader in scope and involve greater effort to recover from.

To devise a successful disaster recovery process, you first need to evaluate what kind of business impact any potential failures could have. Consider automating the recovery process as much as possible. Inevitably, some parts of your disaster recovery process involve human input, so you must fully document the process. You must also regularly simulate disasters so your recovery process remains effective.

### Identify key stakeholders and infrastructure

Identify everyone who has a stake in your applications remaining functional. These stakeholders can be external or internal users. Your support staff, and anyone required for manual input in the BCDR process, is a stakeholder. Other applications and services that rely on your applications can also be stakeholders.

Identify the infrastructure that composes the environment for your applications. This infrastructure is typically the virtual machines (VMs), network resources, storage resources, and any other services that run alongside them.

### Identify recovery point objectives and recovery time objectives

An RPO represents how much data loss is acceptable for your application if there's a disaster. For example, if your application is down, you might find it's only acceptable for it to run on data that's less than half an hour old after recovery. Some applications can function with older data, but for others it's critical to always run on the freshest data possible.

An RTO is the maximum duration of acceptable downtime for your application. For example, you might find it unacceptable for your application to be down for longer than four hours because of the potential loss to the business after this time. Critical applications require a shorter RTO.

:::image type="content" source="../media/2-rto-rpo.png" alt-text="Diagram that shows RPO as the loss of data and RTO as the time to recover from disaster.":::

Contractual or regulatory requirements can often influence the RPO and RTO for your application. The RPO and RTO might also vary per application. Less critical applications might have larger values for RPO and RTO, whereas business-critical applications might have a smaller tolerance for downtime and data loss. You calculate RTO and RPO based on your organization's understanding of the risk and the cost incurred from the loss of data and downtime.

### Identify any PaaS requirements

Although you might have control over downtime and recovery for the applications that you manage, you might not have the same control over PaaS services. Any PaaS services that you use might have their own availability guarantees and recovery plans that you must consider in your BCDR plan.

Identify and inventory the services that you depend on, so you can incorporate their recovery capabilities into your BCDR plan. It's important to understand the relevant requirements and how they affect the BCDR process.

## Azure Site Recovery

Azure Site Recovery is a service that provides BCDR features for your applications in Azure, on-premises, and in other cloud providers. Site Recovery has plans that help automate disaster recovery. It enables you to define how machines are failed over and the order in which they're restarted after being successfully failed over. In this way, Site Recovery helps to automate tasks and further reduce your RTO. You can also use Site Recovery to periodically test failovers and the overall effectiveness of the recovery process.

:::image type="content" source="../media/2-asr.png" alt-text="Diagram that shows the role of Azure Site Recovery in replicating the workloads on three virtual machines in the East US region to the West US region.":::

## Data backups

Backups help protect applications from accidental deletion or corruption of data. Backups play an important role in any BCDR plan. 

Your RPO depends on how often and how regularly you run backup processes. For example, if you have a backup process configured to run every two hours, and you experience a disaster five minutes before the next backup, you'll lose one hour and 55 minutes of data. Having more frequent backups means you achieve a reduced RPO. In your overall plan, you must include a detailed backup process.

You can use Azure Backup for your backup process. The Azure Backup service provides secure backup for all Azure-managed data assets. It uses zero-infrastructure solutions to enable self-service backups and restores, with at-scale management at a predictable cost.

Azure Backup offers specialized backup solutions for Azure and on-premises VMs. Azure Backup also enables workloads like SQL Server or SAP HANA running on Azure VMs to have enterprise-class backup and restore options.

Both Azure Backup and Azure Site Recovery aim to make the system more resilient to faults and failures. However, the primary goal of Azure Backup is to maintain copies of stateful data that allow you to go back in time. Site Recovery replicates the data in almost real time and allows for a failover. [Learn more about Azure Backup](/training/modules/protect-virtual-machines-with-azure-backup/).

## Azure resilience features

Azure comes with features to help ensure that your applications and infrastructure are resilient.

### Region pairing

All Azure regions are paired with a different region. In a region pair, the regions are never updated simultaneously. Instead, they're updated one by one. If something happens to one region, the other becomes available.

These region pairs are also used for replication. Storage services and many PaaS services are replicated and have failover pairs in the paired region. As part of your BCDR planning, it's important to use region pairing to take advantage of the isolation that it provides. You can reduce the amount of time it takes to recover from a failure and increase your availability.

### Availability sets

An availability set is a logical grouping capability in Azure. It ensures that the VM resources you place within it are isolated from each other when they're deployed within an Azure datacenter. Availability sets consist of *update domains* and *fault domains*.

:::image type="content" source="../media/2-availability-sets.png" alt-text="Diagram that shows update domains and fault domains in an availability set.":::

Update domains help ensure that a subset of your application's servers keep running when the VM hosts in an Azure datacenter require downtime for maintenance. Most updates to VM hosts can be performed without affecting the VMs running on them, but there are occasions when this type of update isn't possible.

To ensure that updates don't happen to all VMs simultaneously, the Azure datacenter is logically sectioned into update domains. When a maintenance event happens, such as a performance update and a critical security patch that need to be applied to the host, it's sequenced through update domains. The use of sequencing through update domains ensures that the whole datacenter isn't unavailable during platform updates and patching.

Fault domains represent physical sections of the datacenter and help ensure rack diversity of servers in an availability set. Fault domains align with the physical separation of shared hardware in the datacenter. Shared hardware includes power, cooling, and network hardware that supports the physical servers on server racks.

If the hardware that supports a server rack becomes unavailable, the outage affects only that server rack. When you place your VMs in an availability set, they're automatically spread across multiple fault domains. If a hardware failure occurs, it affects only some of your VMs.

### Availability zones

Availability zones are independent physical datacenter locations within a region. They include their own power, cooling, and networking. When you take availability zones into account as you're deploying resources, you can help protect workloads from datacenter outages while retaining presence in a region.

*Zonal services* are services (like virtual machines) that you can deploy to specific zones within a region. Other services are *zone-redundant services* and replicate across the availability zones in the specific Azure region. Both types help ensure that within an Azure region, there are no single points of failure.

:::image type="content" source="../media/2-availability-zones.png" alt-text="Diagram that shows three availability zones with a failure in one but no impact to the other two.":::
