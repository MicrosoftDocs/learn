In cloud services such as Azure and Amazon Web Services (AWS), you can mirror on-premises infrastructure in the cloud as a direct way to migrate applications. For example, your can replace physical servers with Virtual Machines (VMs), physical networks with virtual networks or private clouds, and storage capacity with cloud storage accounts. This approach is known as Infrastructure-as-a-Service (IaaS).

In your global clothing retailer, the competitor you recently merged with has extensive workloads implemented in Azure as Azure Kubernetes Service (AKS) clusters, virtual networks, load balancers, and other resources. Some of these systems closely resemble the ones you already have as Amazon Elastic Kubernetes Service (EKS) clusters, EC2 instances, virtual private clouds, and so on, in AWS. You want to understand these implementations and their resources, so that you can decide which to migrate from one cloud service to another.

In this unit, you compare compute, storage, and networking IaaS resources that you can create in Azure and consider their equivalents in AWS.

:::image type="content" source="../media/iaas-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Amazon AWS." border="false":::

## Compare Compute services in Azure and AWS

Azure offers scalable VMs similar to AWS EC2 instances. Both Azure and AWS offer on-demand VMs that you can use to run various operating systems and applications. Both services bill by the second while they're running. The terminology and management differs between Azure and AWS.

Azure offers different virtual machine (VM) sizes and types, such as General-purpose, Compute-optimized, Memory-optimized, Storage-optimized, GPU, and High-performance compute. These sizes are similar to the instance types in AWS, but with differences in the specification of each. To understand more about Azure VM sizes, see [Azure VM sizes](/azure/virtual-machines/sizes/overview).

The following table summarizes the similarities and differences in VM components on Azure and AWS:

| VM Component | Azure | AWS | Comments |
|---------|---------|---------|---------|
| Managed disks | Azure managed disks automatically handle storage account management that reduces the administrative overhead. | Elastic Block Store (EBS) volumes | AWS requires you to manage EBS volumes. |
| Availability | Availability Sets protect against hardware failures within a data center. Availability Zones protect against data center failures. | Availability Zones and Auto Scaling groups. | |
| Scaling | Azure Virtual Machine Scale Sets deploy and manage a set of identical VMs, enabling on demand scaling. | AWS Auto Scaling Groups |         |
| Networking | Virtual Networks (VNets), Network Security Groups (NSG), and the Azure Load Balancer | AWS VPC, Security Groups, and Elastic Load Balancing (ELB) | There are some differences in configuration and management. |
| Hybrid Benefits | [Azure Hybrid Benefit](/windows-server/get-started/azure-hybrid-benefit?tabs=azure). Reduce costs with on-premises Windows Server and SQL Server licenses, with Software Assurance. | Similar benefits through AWS License Manager.|   |
| Monitoring and Management | Azure Monitor, Azure Log Analytics, and Azure Automation for monitoring and managing VMs. | AWS CloudWatch and AWS Systems Manager | There are similarities and some differences in AWS and Azure capabilities and user interfaces. |

## Compare storage options in Azure and AWS

Azure Storage Accounts provide for a range of common file and data storage requirements. For example, these storage services can be used to act as file shares, store Binary Large Objects (Blobs) for web applications, or keep semi-structured data. Let's examine these services and highlight the equivalent AWS services:

| Purpose | Azure Storage service | AWS Service | Comments |
|---|---|---|---|
| Blobs | Blob Storage | AWS S3 | Optimized for storing unstructured data such as images, videos, and document files. |
| File shares | File Storage | AWS EFS | Fully managed file shares, compatible with Server Message Block (SMB). |
| VM disk storage | Azure managed disks | AWS EBS | Block-level storage volumes, optimized for VM disk performance. |
| Message queues | Azure Queue Storage | Amazon Simple Queue Service (SQS) | Queues of messages that custom application components can use to communicate reliably. |
| Nonrelational data | Azure Cosmos DB | AWS DynamoDB | Storage for semi-structured, NoSQL databases. |

In both Azure and AWS, you can choose to optimize your storage according to the frequency of access you expect. In Azure, you choose a "tier" (from **Hot**, **Cool**, **Cold**, and **Archive**) and in AWS you choose an S3 storage class (from **Standard**, **Intelligent-Tiering**, **Standard-IA**, **One Zone-IA**, **Glacier**, and **Glacier Deep Archive**). This choice can reduce costs.

You can also reduce licensing costs by using hybrid capabilities: Azure Hybrid Benefit lets you use on-premises Windows and SQL Server licenses to subsidize your Azure subscription. In AWS, you can do similar optimization with License Manager.

Both services also offer tools to transfer large quantities of data into storage. For example, Azure Databox and AWS Snowball.

## Compare networking services in Azure and AWS

VMs and other services running in Azure or AWS must communicate with each other, internet destinations, and users on your premises. To enable, control, and secure this communication, both cloud environments provide comparable networking features:

| Purpose | Azure object | AWS object | Comments |
|---|---|---|---|
| Network segmentation | Virtual Networks (VNets) | Virtual Private Clouds (VPCs) | VNets and VPCs provide isolated networks, within which communication is permitted. Access outside these networks required configuration and is tightly controlled. Both VNets and VPCs can be subdivided into IP subnets. |
| Traffic filtering | Network Security Groups (NSGs) | Security Groups | NSGs and AWS Security Groups filter traffic as it enters and exits a virtual network or VPC. |
| Load balancing | Azure Load Balancer | Elastic Load Balancing (ELB) | These objects accept requests from users and distribute them between VMs or other services in order to optimize performance. |
| Domain Name System (DNS) | Azure DNS | Route 53 | These objects resolve host names to IP addresses. |
| Virtual Private Networks (VPNs) | VPN Gateway | AWS VPN | These objects enable encrypted communication tunnels to be established through the internet between the cloud and your on-premises network. These tunnels allow users to communicate with VMs and other resources as if they are on the local network. |
| Private connections | ExpressRoute | Direct Connect | These services establish private connections to the cloud that don't traverse the public internet. |
| Firewalls | Azure Firewall | AWS Network Firewall | These objects provide advanced network filtering based on characteristics of packet sources and destinations. |

## Learn more

- [Virtual machine sizes overview](/azure/virtual-machines/sizes/overview)
- [Virtual machines in Azure](/azure/virtual-machines/overview).
- [Linux on Azure](/training/paths/azure-linux/)
- [Describe Azure compute and networking services](/training/modules/describe-azure-compute-networking-services/)
- [Describe Azure storage services](/training/modules/describe-azure-storage-services/)
- [Compare AWS an Azure Computer services](/azure/architecture/aws-professional/compute#compare-aws-and-azure-compute-services)
