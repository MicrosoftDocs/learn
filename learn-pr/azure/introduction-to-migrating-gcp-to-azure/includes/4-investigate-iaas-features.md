Assume that you start with an on-premises set of services, and you want to migrate those services into the cloud with the minimum amount of modification. You might choose to replicate your on-premises servers as cloud virtual machines (VMs), your networks as virtual network segments, and your disk storage as cloud storage services. Both Google Cloud and Azure can implement this approach, which is called *infrastructure as a service (IaaS)*.

In the scenario of the global cycling retailer, the competitor that the company recently acquired has its product database running on VMs and a set of virtual networks in its Azure subscription. The system stores product images and demonstration videos in Azure Blob Storage. You want to understand this system to assess whether to leave it in place or migrate the content to your product information store in Google Cloud.

In this unit, you compare compute, storage, and virtual network features in Google Cloud and Microsoft Azure.

:::image type="content" source="../media/iaas-overview.png" alt-text="Diagram that shows the types of services provided by Microsoft Azure and Google Cloud, with infrastructure as a service highlighted." border="false":::

## Compare compute services in Azure and Google Cloud

If you choose an IaaS approach, you usually migrate on-premises servers and their workloads to VMs as compute resources in the cloud. Azure and Google Cloud offer similar VM features, but their terminology is different:

| Compute subject | Azure | Google Cloud | Comments |
|---|---|---|---|
| VM sizes | VM sizes organized into series for different workloads | Categorized and custom machine types | Azure has a wide range of VM size choices in each series. In Google Cloud, you can specify exact CPU numbers for memory. |
| Regions and availability zones | Many geographical regions to choose from | Multiple regions and availability zones in each | Availability zones help ensure resilience against large failures. Azure and Google Cloud take similar approaches. Not all Azure regions have multiple availability zones. |
| Scaling out VMs | Virtual machine scale sets | Managed instance groups | Scale sets and instance groups provide identical, automatically scaling VMs for high availability. |
| Cost management | Microsoft Cost Management and Azure pricing calculator | Cost Management and pricing calculator | Both cloud services include closely analogous cost prediction and tracking tools for compute and other services. |

## Compare storage options in Azure and Google Cloud

Both Google Cloud and Azure provide scalable and flexible solutions for storing and managing data, so customers can access their information from anywhere. These services typically include object storage for unstructured data (like images and videos) and file storage. Both platforms also offer specialized services for message queues, NoSQL databases for semistructured data, and archival solutions for long-term data retention at lower costs. This versatility allows businesses to optimize their data management strategies based on access patterns, performance needs, and budget considerations.

Azure storage accounts provide a range of information storage services that are optimized to common tasks. This table compares those services to services in Google Cloud:

| Storage type | Azure | Google Cloud | Comments |
|---|---|---|---|
| Unstructured objects | Azure Blob Storage | Cloud Storage | These services are optimized for storing and serving large, unstructured files, such as images and videos. |
| File shares | Azure Files | Filestore | These services behave as shared file storage and are compatible with the Server Message Block (SMB) protocol. |
| NoSQL tables | Azure Table Storage | Bigtable, Datastore | These services provide semistructured tabular data stores.  |
| Messaging queues | Azure Queue Storage | Not applicable | Google Cloud has no precise equivalent of Queue Storage, but you might use Google Cloud Pub/Sub or Cloud Tasks for similar functionality. |

To manage Azure storage accounts, scale, and implement availability, use these product tiers and services:

| Task | Azure | Google Cloud | Comments |
|---|---|---|---|
| Balancing performance and cost | Storage tiers: Hot, Cool, Cold, Archive | Storage classes: Standard, Nearline, Coldline, Archive | Use tiers to implement high-performance storage at higher cost, or archival storage with lower performance at lower cost. |
| Maximizing performance | Use tiers: Premium and Standard | Standard and SSD-backed storage | Use to scale performance for high-traffic applications. |
| Encryption | Azure Storage service-side encryption (SSE), Azure Key Vault | Customer-supplied encryption keys (CSEKs), customer-managed encryption keys (CMEKs) | Use these tools and keys to encrypt information at rest. |
| Data migration | Azure Migrate, Azure Data Box | Storage Transfer Service, Transfer Appliance | Migrate data into cloud storage over the network or with a physical disk. |

## Compare networking services in Azure and Google Cloud

VMs and other services running in Azure or Amazon Web Services (AWS) must communicate with each other, internet destinations, and users on your premises. To enable, control, and help secure this communication, both cloud environments provide comparable networking features:

| Purpose | Azure object | Google Cloud object | Comments |
|---|---|---|---|
| Network segmentation | Virtual network | Virtual private cloud (VPC) | Use to define isolated networks of VMs and other resources. Google Cloud Platform (GCP) has the concept of a global network, which enables customers to have a VPC that spans across regions. In Azure, a VPC can be attached to only a single region. |
| Traffic filtering | Network security group | Firewall rule | Use to control inbound and outbound traffic by IP address and port number. |
| Load balancing | Azure Load Balancer (TCP and UDP protocols), Azure Application Gateway (HTTP and HTTPS protocols) | Load Balancing | In Google Cloud, Load Balancing can distribute load both for TCP and UDP (Layer 4) and for HTTP and HTTPS (Layer 7). |
| Domain Name System (DNS) | Azure DNS | Cloud DNS | These objects resolve host names to IP addresses. |
| Interconnection | Azure ExpressRoute | Cloud Interconnect | Connect cloud networks to on-premises systems. |
| Network monitoring | Azure Network Watcher | Network Intelligence Center | Use these tools to examine network load and to diagnose bottlenecks or security flaws. |

## Learn more

- [Virtual machines in Azure](/azure/virtual-machines/overview)
- [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes/overview)
- [Linux on Azure](/training/paths/azure-linux/)
- [Describe Azure compute and networking services](/training/modules/describe-azure-compute-networking-services/)
- [Describe Azure storage services](/training/modules/describe-azure-storage-services/)
- [Compare AWS and Azure computer services](/azure/architecture/aws-professional/compute#compare-aws-and-azure-compute-services)
