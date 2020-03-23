Nothing strikes fear into the hearts of IT personnel more than data loss. The most effective strategy for preventing data loss is to back up the storage volumes, virtual machines, databases, and other systems that store data so that their data may be restored. Cloud service providers offer backup services for just this purpose. Generally speaking, these services can be used to back up data stored on-premises as well as data stored in the cloud, and backups may be geographically replicated and dispersed to guard against events resulting in loss of data in an entire data center or region of the globe.

The public cloud is a deliverer of fluid resources in high volume - not just large chunks of storage, but highly scalable storage pools. They are at least as versatile, and in some cases more so, than the backup storage systems and tape drives they're replacing. And they're giving organizations new opportunities to implement redundancies, failovers, and safety nets that many never could have afforded in the era when all assets were purchased out of working capital. Public cloud storage options fulfill a role that data centers have always desperately needed, but that had been difficult to obtain until recently.

## Cloud-based backup services

What characterizes modern backup services offered by public cloud service providers (CSP) is the way they extend their customers' infrastructure. Prior to the advent of these services, an organization's typical backup strategy had two tiers: backing up data volumes that hosted databases and backing up virtual-machine images that hosted critical workloads. The theory behind backup was that when a system fault leads to a failure, that event takes down a server. The immediate course of action then becomes to restore the state of that server from a backup image.

Cloud-based infrastructure obsoletes the old theory of backup. In modern systems, servers are made up of software, not hardware. Virtual servers are either hosted by hypervisor-based virtual infrastructure, such as VMware's NSX, or assembled from containers and hosted by virtualized operating systems. In both cases, the software images of the workloads for applications and services are continually being managed, updated, and kept secure. Indeed, the active software components are themselves replicas of these secure masters, or for containerization, the products of original masters stored in container repositories and automatically assembled as needed. A hardware fault that takes down a server node simply makes the servers hosted by that node unavailable for a time; the infrastructure simply reroutes traffic around the node, and makes its best effort to replace it in the meantime. The infrastructure manager isn't doing anything it hasn't already been doing in the ordinary course of system administration.

However, as even a cursory examination of modern data centers will reveal, not all modern infrastructure is cloud-based infrastructure. Services are still hosted on bare metal in on-premises data centers. Client/server networks, complete with middleware, still abound. And in a hybrid system where one part designed a few years ago is connected to another part designed in the previous century, it remains necessary to store enough information about the constituency of a system that, if there is a disaster, the system can be reconstructed, by whatever practical but expeditious means there may be, in a new location with minimal impact to service levels. With modern backup strategies, the public cloud may be that location, even if the systems being snapshotted lay outside the cloud.

### AWS Backup

In early 2019, Amazon Web Services redesigned its cloud-based backup service for customers' hybrid cloud environments. At the center of the new AWS Backup, whose browser-based console appears in Figure 2, is a *policy engine*, not unlike the arbiter of rules for a firewall. With this engine, the backup administrator writes rules that specify the following:

- Which resources in a system require backup

- How each backup should be conducted, and how often

- Where the images of backups should be stored

- How the integrity of backup images should be monitored, including how often

- How long backup images should be retained

- Under what circumstances recovery and restoration should take place

The complete itinerary encompassing all active policies is the *backup plan*. Here, each rule refers to resources within the AWS cloud that require backup by the value of its tag, which is an arbitrary name given by the administrator. To include a resource such as an Elastic Block Storage (EBS) volume in a backup plan, its administrator need only give that resource a tag name that AWS Backup will recognize. This way, the administrator or caretaker with responsibility for an AWS resource does not need to use the AWS Backup console just to establish a resource under the caretaker's purview as part of an existing backup plan.

![Figure 2: The AWS Backup console. \[Courtesy Amazon\]](../media/fig9-2.jpg)

_Figure 2: The AWS Backup console. \[Courtesy Amazon\]_

On-premises resources may be incorporated into a backup plan by means of AWS Storage Gateway. For purposes of AWS Backup, Storage Gateway acts as an API wrapper around physical storage volumes and devices, making them accessible to AWS services.

Originally, Storage Gateway enabled substitutions of existing physical storage assets with cloud-based counterparts using the same interface. For example, an on-site iSCSI volume could be wrapped in what AWS calls a *cached volume*. This wrapper makes cloud storage accessible to existing, on-premises applications without customers having to re-engineer those applications. Frequently accessed data could continue to be stored on the iSCSI volume as a cache, reducing the amount of latency incurred. Alternately, recent changes to the gateway volume's contents can be stored locally as snapshots. But Storage Gateway also supports *stored volumes*, in which the on-site device continues to maintain a complete local copy of the volume, which Storage Gateway then mirrors in the cloud. The new AWS Backup leverages Storage Gateway's role-swapping with physical volumes, making the local copy the backup for the cloud-based volume, while adding a centralized policy management console, with rules that govern how both replicas are to be maintained.

For disaster-recovery purposes, one major benefit a CSP offers is the ability to quickly archive an organization's critical data in distant locations to achieve *geographical redundancy* or *geo-redundancy*. AWS operates cloud data centers in the greatest number of availability zones for any CSP. It advertises the native ability for applications it hosts to fail over automatically to alternate zones, and extends this capability to data backup redundancy. However, failover zones have been known to reside within the same AWS region. In an extreme disaster situation (which insurance agencies, and therefore risk managers, do take into account) such as a power utility grid failure, availability zones adjacent to one another could conceivably experience outages.

A software developer or an IT operator with developer experience can write custom policies for an organization's specific geo-redundancy routing using AWS' low-level routing service, Route 53. However, this technique requires a lot of effort. More recently, AWS has offered a more approachable service called AWS Global Accelerator, which is another policy engine that guides traffic and directs Route 53 as to where services and storage should be hosted.<sup>[1][^1]</sup> Global Accelerator may also be leveraged as a kind of "über-balancer," enabling the distribution of multiple sites for hosted applications (and with them, critical data) among disperse availability zones.

Another way to ensure that backed up data is stored in a respectably distant region, as Amazon technicians have suggested, is to establish a *bucket* (AWS's general-purpose backup container) as the initial backup destination, and then replicate that bucket to a redundant location in any designated availability zone. AWS offers Cross-Region Replication (CRR) as a separate service.<sup>[2][^2]</sup> AWS prices its backup service in terms of volume, both per gigabyte stored and per gigabyte restored.

From an architectural perspective, AWS Backup is designed to serve as a mirror for AWS resources. The way to make on-premises assets part of that plan is through a double back-door of sorts, first by converting those local assets into remote AWS volumes (remote from Amazon's perspective), then have Backup interface with the wrapper around those local assets.

### Azure Backup

Azure Backup is equally capable of backing up on-premises resources (servers and virtual machines) and resources hosted in Azure. It does not aim to change the existing backup policy in the data center - just to replace local discs and tape drives with cloud storage. The cloud-based location for backed-up files and volumes on Azure is called the *Recovery Services Vault*, whose browser-based console appears in Figure 3. During the setup process for this vault through the Azure portal, the administrator downloads and installs the client-side agent known as the Microsoft Azure Recovery Services agent or "MARS." In Windows Server, MARS runs as an application, looking very much like a System Center add-on. (Alternately, an admin may prefer to use System Center Data Protection Manager, where MARS functionality is already built in.) The administrator locates the volumes and services in the network whose data requires backup, and MARS distributes its agents to the server addresses responsible for those components.

![Figure 3: The console for Azure Recovery Services Vault. \[Courtesy Microsoft\]](../media/fig9-3.png)

_Figure 3: The console for Azure Recovery Services Vault. \[Courtesy Microsoft\]_

Azure Backup's delivery model is based around *service-level objectives* for disaster recovery, which provide reasonable metrics for determining how much time an organization can withstand not having access to the engine of its business, and how much data it can acceptably lose in a disaster event. These specific objectives (RPO, RTO, and retention) are covered in the next lesson on disaster recovery.

The type of recovery with which Azure Backup is concerned (as opposed to Azure Site Recovery, Microsoft's disaster-recovery service) is centered entirely around data replication rather than service restoration. For example, a customer may use Azure Backup to produce replicas of virtual machine image files (VHD). However, restoration of a VHD simply reproduces the archived image file in local storage once again and does not restart the virtual server based on that VHD.

Azure Backup charges only for storage space consumed per month, with no extra fee for restorations. Its storage pricing model is tied in with its redundancy options. Presently, Azure offers two such options: Locally Redundant Storage (LRS), which is the least expensive and replicates data three times within an Azure data center, and **Geo-Redundant Storage (GRS)**, which replicates data into a secondary region geographically distant from the primary region.

### Google Cloud Storage backup

Google offers a variety of Cloud Storage tiers based on the class of data being stored - for example, persistently available files, block storage for virtual machine images, object storage for videos. It does not explicitly market a branded backup service for any of these tiers, although storage services can certainly be used - and are used - for backup and recovery. And Google does assume that backups will be among the primary reasons an enterprise would invest in cloud storage at high volumes.

![Figure 4: The contents of a Google Cloud Storage bucket. \[Courtesy Google\]](../media/fig9-4.jpg)

_Figure 4: The contents of a Google Cloud Storage bucket. \[Courtesy Google\]_

As with AWS, Google calls its general-purpose storage container a *bucket*. Figure 4 shows one step in the process of importing data from local storage into a Google Cloud Storage (GCS) bucket. Similar to how Azure bases its delivery model around three key parameters, GCS's key parameters are:

- **Performance**, which in this context is synonymous with availability (how quickly servers will respond to customers' request for data reads)

- **Retention**, referring once again to how long the customer expects to keep data stored in the cloud

- **Access patterns**, which relates to accessibility (how often the customer expects to read or recall the stored data)

When initializing a bucket, the GCS customer chooses its *storage class*, which specifies its replication policy. This choice determines, once the bucket starts being used for backups, how widely dispersed the stored data will be. GCS presently offers three geolocation choices:

- **Regional** - Stored in only one select region of Google's service territory

- **Dual-regional** - Replicated across two selected service territories

- **Multi-regional** - Distributed redundantly across multiple service territories

Next, GCS subdivides its bucket storage classes based on how frequently they will be accessed:

- **Standard / High Availability** - Data intended to be readily accessible to applications and to users

- **Coldline** - Lets the customer trade part of the monthly storage fee for access and transfer charges, for data intended to be accessed no more frequently than a few times per year

- **Nearline** - More of a mid-range trade, for data planned to be accessed about once per month

Google's approach to marketing its cloud infrastructure to businesses is to present its services as a kind of appliance that you don't see. In that respect, it may be duplicated effort for Google to offer both what the appliance is and how it's used as separate services, like selling an oven and then a subscription to cooking food as a value-add.

This way, the GCS customer organization selects the infrastructure it needs for the jobs it has in mind, and tailors the settings for that infrastructure like features of an appliance. (Like AWS and Azure, Google offers a rack-mount appliance for data centers for the express purpose of high-speed transfer between local and cloud storage.) Those features may then be tweaked over time depending on how the use of that storage changes. For example, suppose a video production firm needed high quantities of backup storage, for versions of a film being edited. During the editing process, those copies may be retrieved fairly often, so the customer may set the bucket to Standard storage in Regional territory. Once the video is complete and publicly distributed, it may still be necessary to keep copies on hand for the next year, though they may not be accessed often. In that case, the Standard bucket may be transferred to a Coldline bucket, with Dual-Regional territory for archival and safety purposes.

### References

1. _Amazon Web Services, Inc. *Traffic management with AWS Global Accelerator* <https://aws.amazon.com/blogs/networking-and-content-delivery/traffic-management-with-aws-global-accelerator/>._

2. _Amazon Web Services, Inc. *Overview of Setting Up Replication* <https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-how-setup.html>._

[^1]: <https://aws.amazon.com/blogs/networking-and-content-delivery/traffic-management-with-aws-global-accelerator/>  "Amazon Web Services, Inc. *Traffic management with AWS Global Accelerator*."

[^2]: <https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-how-setup.html>  "Amazon Web Services, Inc. *Overview of Setting Up Replication*."
