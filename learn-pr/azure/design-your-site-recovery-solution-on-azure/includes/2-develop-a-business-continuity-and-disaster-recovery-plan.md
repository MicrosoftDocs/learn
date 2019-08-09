You must develop a business continuity and disaster recovery plan so you can design an appropriate site recovery solution.

Your organization wants you to design a site recovery strategy for your applications. You need to understand the specific requirements involved in building site recovery for your hybrid environment. You need to understand what tools are available in Azure that can be part of your plan.

In this unit, you will learn how to identify key infrastructures. You will learn how to identify your recovery time objectives and your recovery point objectives. You will learn what requirements might be in place in any PaaS services you might be using. You will learn how to plan for backup and disaster recovery. And you will learn some of the Azure features that will help you when building a site recovery solution in Azure.

## Identify key stakeholders and key infrastructures

You must identify everyone who has a stake in your applications remaining functional. These stakeholders can be the users, external or internal. Your support staff, and anyone required for manual input in the BCDR process has a stake in your applications remaining functional. Other applications and services that rely on your applications being functional can also be stakeholders in their own right.

You must also identify the key infrastructures that compose the environment for your applications. These are typically the virtual machines, the components and networks of your machines, and any other services that run along side them. If the infrastructure running your applications consists of multiple machines and services that span across an on-premises and remote cloud-based network, you include them regardless of whether they are on-premises or in the cloud.

## Identify recovery time objectives and recovery point objectives

Recovery time objective (RTO) is the amount of time beyond which it's unacceptable for an application to be unavailable after a failure. For example, you may find it unacceptable for your application to be down for longer than an hour, because of the serious loss to the business after one hour. Critical applications will require the shorter a RTO.

Recovery point objective (RPO) refers to how old your working data is allowed to be at the point of recovery. For example, if your application is down you may only find it acceptable for it to run on data that is less than half an hour old once the application is recovered. Some applications can function with older data, but for some applications it is critical that the application runs on the freshest data possible at all times. It is up to you to figure out your RTO and RPO based on your organization's understanding of the risk and cost that would be introduced because of the loss of any data and downtime.

## Identify any PaaS requirements

Any PaaS services you use can come with their own requirements you need to consider for them to be part of your BCDR plan. For example, SQL Database has the following considerations:

- Turn on SQL Database Auditing. You can use auditing to monitor for suspicious activity or human mistakes.
- Create a readable secondary in a different region through Active Geo-Replication.
- Shard your databases. This will help you achieve fault isolation for your databases.
- Perform a geo-restore so you can recover from outage and restore your database to another region.
- Point-in-time-restore will help you recover from human mistakes. Only Standard and Premium tier give you longer point-in-time restores of up to 35 days. Basic tier only gives you 7 days.

It is important to understand what the requirements are, so that you know how they affect your BCDR process.

## Plan data backup and disaster recovery

### Disaster recovery

Disaster recovery refers to a process that helps you restore your applications to a functional state after a catastrophic incident that could result in disastrous loss.

You need to consider several things for your disaster recovery process to be successful. You need to evaluate what kind of business impact any potential failures will have. You need to also consider automating the recovery process as much as you can. For example, use alerts to notify services and users. There may inevitably be some parts of your disaster recovery process that needs human input, this means you need to document the process as much as possible. You also need to regularly simulate disasters against your process, so your disaster recovery process remains effective.

Azure Site Recovery, through its recovery plans, can help you automate your disaster recovery process by allowing you to define how machines can be failed over, and the order in which they are to be restarted after having been failed over successfully. Azure Site Recovery in this way helps you automate tasks in your recover process and further helps you reduce your recovery time objective. Azure Site Recovery also make it possible to test your failovers and so test the overall effectiveness of your recovery process periodically.

### Data backups

Backups exist to protect applications from accidental deletion or corruption of data. They are essentially functioning versions of parts of your application backed up from an earlier point in time.

You can't decide create a disaster recovery process and ignore backups. Your recovery point objective depends on how often and how regularly you run backup processes. To illustrate, if you have a backup process configured to execute every two hours, and you experience a disaster 5 minutes before your next backup, you will lose 1 hour and 55 minutes of data. Performing more frequent backups means you achieve a reduced RPO. In your overall plan, you must include a detailed backup process.

Azure Backup makes it possible for you to back up your on-premises data and machines to the cloud, or keep their backups on-premises. Depending on the type of machine, you can back up individual files, folders, volumes, or the entire virtual machine.
Azure backup allows you secure your backed up data both at rest and while it is in transit. Your data is replicated three times in a datacenter through locally redundant storage (LRS) for Azure Backup. Additionally, you can replicate your data to a secondary region many miles away from the original data with geo-redundant storage (GRS) for Azure Backup. You are able to achieve application-consistent backups. This means your backups don't need you to add fixes to restore your backups successfully. You are able to have up to 9999 backup copies for each of your instances (machines or workloads) on Azure. This means that if your backup frequency is daily because you have a recovery point objective of 24 hours, you can have recovery points that cover a span of 27 years before you have hit your limit of recovery points you can use for restoration.

## Use Azure native features

Azure comes with features that are designed from the ground up to help you achieve your objectives for your business continuity and disaster recovery. Below are some of these features.

### Region pairing

 Every Azure region is paired with a different region in the same part of the world. Some regions, such as Brazil have a region pair that is not in the same part of the world. In a region pair, the regions are never updated simultaneously. Rather they are updated one by one. If something happens to one region in the same part of the world, another one is available. As part of your BCDR planning, it is important to use region pairing so you can take advantage of the isolation it provides. You will be able to decrease the amount of time it takes to recover from a failure and you will be able to increase availability.

### Availability Sets

You must consider creating Availability Sets. Availability Sets allow you to isolate your virtual machines when you provision them in Azure. When you place virtual machines in Availability Sets, you are ensuring that your virtual machines are running on separate servers, using multiple different network switches, and racks among other things. Regardless of whether a software problem causes a failure, or a hardware failure occurs, your Availability Sets ensure you have another set of virtual machines running. Physical hardware in an availability set is spread across multiple update and fault domains. A single update domain consists of a virtual machines and the hardware they run on, that can be updated and restarted simultaneously. A fault domain refers to a set of virtual machines that use the same networking, power sources and storage.

### Availability Zones

You must also consider Azure Availability Zones to keep your applications running. These Availability Zones are separate physical places in a single Azure region. Each one of these locations consists of at least one datacenter, and they are designed to use their own separate networking, cooling systems, and separate power. You will usually have a minimum of three of these zones in each region. This means that your virtual machines that are hosting your applications for example, are spread over three update domains and three fault domains. This means these virtual machines in three different regions are never updated simultaneously. You can manually set a specific type of resource to be in a specific zone with some resources such as virtual machines. And some services such as SQL Database, copy across multiple availability zones automatically for you.
