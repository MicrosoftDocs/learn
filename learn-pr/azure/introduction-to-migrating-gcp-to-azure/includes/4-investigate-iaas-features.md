If you start with an on-premises set of services, and you want to migrate them into the cloud with the minimum amount of modification, you might choose to replicate your on-premises servers as cloud Virtual Machines (VMs), your networks as virtual network segments, and your disk storage as cloud storage services. Both Google Cloud and Azure can implement this approach, which is known as Infrastructure as a Service (IaaS)

In your global cycling manufacturer, the competitor you recently acquired has its product database running on VMs and a set of virtual networks in their Azure subscription. The system stores product images and demonstration videos in Azure Binary Large Object (Blob) storage. You want to understand this system to assess whether to leave it in place or migrate the content to your Google Cloud product information store.

In this unit, you compare compute, storage, and virtual networking features in Google Cloud and Microsoft Azure.

:::image type="content" source="../media/iaas-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Google Cloud.":::

## Compare compute services in Azure and Google Cloud

If you choose an IaaS approach, you usually migrate on-premises servers and their workloads to Virtual Machines (VMs) as compute resources in the cloud. Azure and Google Cloud offer similar VM features but their terminology is different.

This table compares VM configuration options in the two cloud services:

| Compute subject | Azure | Google Cloud | Comments |
|---|---|---|---|
| VM sizes | VM sizes organized into series for different workloads. | Categorized and custom machine types. | Azure has a wide range of VM size choices in each series but in Google Cloud you can specify exact CPU numbers memory. |
| Regions and availability zones | Choose from many different geographical regions. | Multiple regions and availability zones in each. | Availability zones ensure resilience against large failures. Azure and Google Cloud take similar approaches. Not all Azure regions have multiple availability zones. |
| Scaling VMs out | Azure Virtual Machine Scale Sets | Managed Instance Groups | Scale Sets and Instance Groups provide identical, automatically scaling VMs for high-availability. |
| Cost management | Azure Cost Management and Azure Pricing Calculator | Pricing Calculator and Cost Management Suite | Both cloud services include closely analogous cost prediction and tracking tools for compute and other services. |

## Compare storage options in Azure and Google Cloud

Both Google Cloud and Azure provide scalable and flexible solutions for storing and managing data, so customers can access their information from anywhere. These services typically include object storage for unstructured data (like images and videos) and file storage. The services also offer specialized services for message queues, NoSQL databases for semi-structured data, and archival solutions for long-term data retention at lower costs. This versatility allows businesses to optimize their data management strategies based on access patterns, performance needs, and budget considerations.

Azure Storage Accounts provide a range of information storage types, optimized to common tasks. This table compares those types to features in Google Cloud:

| Storage type | Azure | Google Cloud | Comments |
|---|---|---|---|
| Unstructured objects | Blob Storage | Cloud Storage | These services are optimized for storing and serving large unstructured files such as images and videos. |
| File shares | File Storage | Cloud Filestore | These services behave as shared file storage compatible with the SMB protocol. |
| No SQL tables | Table Storage | Cloud Bigtable, Cloud Datastore | Semi-structured tabular data stores.  |
| Messaging queues | Queue Storage | | Google Cloud has no precise equivalent of Queue Storage, but you might use Google Cloud Pub/Sub or Google Cloud Tasks for similar functionality. |

To manage Azure Storage accounts, scale, and implement availability, use these features:

| Task | Azure | Google Cloud | Comments |
|---|---|---|---|
| Balance performance and cost | Storage tiers - Hot, Cool, Cold, Archive | Storage classes - Standard, Nearline, Coldline, Archive | Use tiers to implement high performance storage at higher cost, or archival storage with lower performance at lower cost. |
| Maximize performance | Use tiers - Premium and Standard | Use Standard and SSD-backed storage | Use to scale performance for high traffic applications. |
| Encryption | Azure Storage Service Encryption (SSE), Azure Key Vault | Customer-Supplied Encryption Keys (CSEK), Customer-Managed Encryption Keys (CMEK) | Use these tools and keys to encrypt information at rest. |
| Data migration | Azure Migrate, Azure Data Box | Storage Transfor Service, Transfer Appliance | Migrate data into cloud storage over the network or with a physical disk. |

## Compare networking services in Azure and Google Cloud

VMs and other services running in Azure or AWS must communicate with each other, internet destinations, and users on your premises. To enable, control, and secure this communication, both cloud environments provide comparable networking features:

| Purpose | Azure object | Google Cloud object | Comments |
|---|---|---|---|
| Network segmentation | Virtual Networks (VNets) | Virtual Private Cloud (VPC) | Use to define isolated networks of VMs and other resources. GCP has the concept of Global Network that allows customer to have a VPC spanning across regions, in Azure a VPC can only be attached to a single region |
| Traffic filtering | Network Security Groups (NSGs) | Firewall rules | Use to control inbound and outbound traffic by IP address and port number. |
| Load balancing | Azure Load Balancer (TCP, UDP), Azure Application Gateway (HTTP, HTTPS) | Cloud Load Balancing | In Google Cloud, Load Balancing can distribute load both for TCP and UDP (Layer 4) and for HTTP and HTTPS (Layer 7). |
| DNS | Azure DNS | Cloud DNS | These objects resolve host names to IP addresses. |
| Interconnection | ExpressRoute | Cloud Interconnect | Connect cloud networks to on-premises systems. |
| Network monitoring | Azure Network Watcher | Network Intelligence Center | Use these tools to examine network load and diagnose bottlenecks or security flaws. |

## Learn more

- [Virtual machine sizes overview](/azure/virtual-machines/sizes/overview)
- [Virtual machines in Azure](/azure/virtual-machines/overview).
- [Linux on Azure](/training/paths/azure-linux/)
- [Describe Azure compute and networking services](/training/modules/describe-azure-compute-networking-services/)
- [Describe Azure storage services](/training/modules/describe-azure-storage-services/)
- [Compare AWS an Azure Computer services](/azure/architecture/aws-professional/compute#compare-aws-and-azure-compute-services)
