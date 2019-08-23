You need to develop a business continuity and disaster recovery plan so you can design an appropriate site recovery solution.

Your organization wants you to design a site recovery strategy for your applications. First, you need to understand the specific requirements involved in building site recovery for your hybrid environment. You need to also understand what tools are available in Azure to help you.

In this unit, you'll learn how to identify key infrastructures, recovery time objectives, and recovery point objectives. You'll learn what requirements might be relevant with any PaaS services you might be using. You'll also learn how to plan for backup and disaster recovery. You'll also discover some of the Azure features that will help you to build a site recovery solution.

## Identify key stakeholders and infrastructures

Identify everyone who has a stake in your applications remaining functional. These stakeholders can be external or internal users. Your support staff, and anyone required for manual input in the BCDR process, have a stake in your applications remaining functional. Other applications and services that rely on your applications being functional can also be stakeholders.

Identify the key infrastructures that compose the environment for your applications. These infrastructures are typically the machines, and the components and networks of your machines – and any other services that run alongside them.

## Identify recovery time objectives and recovery point objectives

Recovery time objective (RTO) is the amount of time beyond which it's unacceptable for an application to be unavailable after a failure. For example, you might find it unacceptable for your application to be down for longer than an hour – because of the potential loss to the business after this time. Critical applications will require a shorter RTO.

Recovery point objective (RPO) refers to how old your working data is allowed to be at the point of recovery. For example, if your application is down, you might find it's only acceptable for it to run on data that's less than half an hour old after recovery. Some applications can function with older data, but for others it's critical to always run on the freshest data possible. You calculate RTO and RPO based on your organization's understanding of the risk and the cost incurred through the loss of data and downtime.

## Identify any PaaS requirements

Any PaaS services you might want to make part of your BCDR plan may have their own requirements. For example, SQL Database has the following considerations:

- Turn on SQL Database Auditing. You can use auditing to monitor for suspicious activity or human error.
- Create a readable secondary in a different region through Active Geo-Replication.
- Shard your databases. Use sharding when you want to spread large numbers of similar data across separate databases.
- Perform a geo-restore so you can recover from outage and restore your database to another region.
- Point-in-time restore will help you recover from human mistakes. Only Standard and Premium tier give you longer point-in-time restores of up to 35 days. Basic tier gives you only seven days.

It's important to understand the relevant requirements, so you know how they affect the BCDR process.

## Plan disaster recovery and data backup

### Disaster recovery

Disaster recovery refers to a process that helps you restore your applications to a functional state after an incident that could result in serious loss.

To devise a successful disaster recovery process, you first need to evaluate what kind of business impact any potential failures will have. Consider automating the recovery process as much as possible. Inevitably, some parts of your disaster recovery process will involve human input, so you need to fully document the process. You need to also regularly simulate disasters, so your recovery process remains effective.

Azure Site Recovery has plans that help automate your disaster recovery by allowing you to define how machines are failed over – and the order in which they're restarted after being successfully failed over. In this way, Azure Site Recovery helps to automate tasks and further reduce your recovery time objective. You also use Azure Site Recovery to periodically test failovers and the overall effectiveness of the recovery process.

### Data backups

Backups protect applications from accidental deletion or corruption of data. You can't decide to create a disaster recovery process and ignore backups. Your recovery point objective depends on how often and how regularly you run backup processes. For example, if you have a backup process configured to execute every two hours – and you experience a disaster five minutes before the next backup – you'll lose 1 hour and 55 minutes of data. Having more frequent backups means you achieve a reduced RPO. In your overall plan, you must include a detailed backup process.

Use Azure Backup to back up your on-premises data and machines to the cloud – or keep their backups on-premises. Depending on the type of machine, you can back up individual files, folders, volumes, or the entire machine.
Backup allows you to secure backed up data, both at rest and while it's in transit. Your data is replicated three times in a data center, through locally redundant storage (LRS) for Azure Backup.

Additionally, you could replicate data to a secondary region that's miles away from the original data with geo-redundant storage (GRS) for Azure Backup. You can also achieve application-consistent backups so you don't need to add manual fixes to restore successfully. You might have up to 9,999 backup copies for each of your instances (machines or workloads) on Azure. If your backup frequency is daily – with a 24-hour recovery point – you could have recovery points that span a 27-year period before you hit the limit of recovery points you use for restoration.

## Use Azure native features

Azure comes with features designed from the ground up to help you achieve your objectives for business continuity and disaster recovery. Take a look at some of these features:

### Region pairing

Most Azure regions are paired with a different region in the same part of the world geographically. However, there are exceptions – Brazil, for example, has a region pair that's not in the same part of the world. In a region pair, the regions are never updated simultaneously. Instead, the regions are updated one by one. If something happens to one region, another one becomes available. As part of your BCDR planning, it's important to use region pairing to take advantage of the isolation it provides. You'll reduce the amount of time it takes to recover from a failure and increase your availability.

### Availability sets

Consider creating availability sets. Availability sets will  allow you to isolate virtual machines when you provision them in Azure. When you place virtual machines in availability sets, you're ensuring that they're running on separate servers, using multiple different network switches, and racks, among other things. Regardless of whether a software problem causes a failure, or a hardware failure occurs, availability sets can ensure you have another set of virtual machines running. Physical hardware in an availability set is spread across multiple update and fault domains. A single update domain consists of virtual machines – and the hardware they run on – that can be updated and restarted simultaneously. A fault domain refers to a set of virtual machines that use the same networking, power sources, and storage.

![Availability Set](../media/2-availability-sets.png)

<!---Feel free to format this diagram according to your own standards-->

### Availability zones

To help keep your applications running, consider using Azure availability zones. These availability zones are separate physical places in a single Azure region. Each location consists of at least one data center, and is designed to use its own separate networking, cooling systems, and power. If one location fails, another can be used. You'll usually have a minimum of three zones in each region.

Implementing availability zones means that your machines are spread over at least three update domains and three fault domains. These virtual machines, in three different regions, are never updated simultaneously. You can manually set a specific type of resource to be in a specific zone with some resources – such as virtual machines. And some services, such as SQL Database, will automatically copy across multiple availability zones.

![Availability Zones](../media/2-availability-zones.png)

<!---Feel free to format this diagram according to your own standards-->