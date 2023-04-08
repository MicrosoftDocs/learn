Azure VM is one of the most popular compute resource types in Azure. When compared with platform-as-a-Service (PaaS) compute services, one of the primary benefits Azure VM provides is an increased degree of control and flexibility regarding the VM operating system (OS) and its configuration. However, more control and flexibility require more planning to ensure an optimal outcome. This planning process should consider the compute, networking, and storage aspects of the VM configuration. Some of these characteristics are OS–specific, with implementation details varying across different Linux distributions.

Microsoft has partnered with prominent Linux vendors to integrate their products with the Azure platform. To fully benefit from this integration, you can create Azure VMs from prebuilt images for a variety of popular Linux distributions, such as SUSE, Red Hat, and Ubuntu. You also have the option to build your own custom image of a Linux distribution to run in the cloud environment. In such cases, there might be additional steps in your Azure VM provisioning process. In either case, you can typically optimize the resulting deployment further by following the guidance provided in this module. This optimization requires that you have a strong understanding of the Azure VM resource and its dependencies.

## Azure VM resource dependencies

When creating an Azure VM, you also need to create several associated resources that the Azure VM depends on. These resources provide full functionality to the virtualized OS, and include:

- Virtual disks to store the OS, applications, and data.
- A virtual network with one or more subnets to connect the Azure VM to other Azure services, or to your on-premises datacenters.
- A network interface to connect the Azure VM to a subnet of the virtual network.
- A resource group to host the Azure VM

In addition, you have the option to create a public IP address and associate it with the network interface of the Azure VM. This provides direct inbound access to the VM from the internet. 

> [!NOTE]
> Every network interface must have at least one private IP address assigned to it dynamically or statically. Private IP addresses are not separate Azure resources, they are part of the subnet configuration.

Now that you understand the Azure VM resource dependencies, you can begin planning for VM sizing.

## Plan for sizing of Azure VMs running Linux

To determine the appropriate size for your Azure VM, you need to consider its intended workload. The size you choose for the VM will determine its characteristics, including:

- Processing power
- Memory
- Storage capacity 
- Performance
- Support for advanced networking features

Azure offers a wide range of sizes with different specifications and price points. So, you should be able to find one suitable for your needs.  

> [!WARNING]
> Each subscription includes virtual CPU (vCPU) quota limits, which you should account for in your planning. To proactively raise quota limits, you must submit an online request to Azure Support.

VM sizes are grouped into multiple categories, representing the types of workloads they are optimized for. Within each category, you‘ll find one or more series, also referred to as _families_, which share common underlying hardware characteristics but offer a range of different sizes. 

The following table lists workload types and common use cases for each workload type. For information about their corresponding families, refer to the [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes?toc=%2Fazure%2Fvirtual-network%2Ftoc.json) Microsoft Learn article.

| **Workload type** | **Common use cases and requirements** |
|---|---|
| **General** **purpose** | This workload type is for testing and development, small-to-medium databases, and low-to-medium traffic web servers. |
| **Compute-intensive** | Use this workload type for medium-traffic web servers, network appliances, batch processes, and application servers. |
| **Memory-intensive** | This workload type is for relational database servers, medium-to-large caches, and in-memory analytics. |
| **Storage-intensive** | Use this workload type for big data, SQL, and NoSQL databases that require high disk throughput and input/output (I/O). |
| **Graphics Processing Unit (GPU)-enabled** | Use this workload type for heavy graphics rendering or video editing, model training and inferencing with deep learning. |
| **High-performance computing (HPC)** | This workload type is for the fastest and most powerful CPU VMs with optional high-throughput network interfaces that support Remote Direct Memory Access (RDMA). |

### Additional considerations

When planning for Azure VM sizes, you should consider the following additional factors:

Changing the Azure VM series or size, while very straightforward and commonly done, requires an OS restart. Therefore, we recommend you size it appropriately from the start if possible.

VM size availability varies by region, so make sure to take this into account when planning your deployments.

The maximum number of disks you can attach to an Azure VM depends on its size.

Consider using [Microsoft Azure VM Selector](https://azure.microsoft.com/pricing/vm-selector/) to determine the most suitable VM size based on the workload type, OS, software installed, and deployment region.

If you intend to use the same or similar size Azure VMs in the same Azure region over an extended period, consider leveraging Azure Reservations to significantly reduce the compute cost (by up to 72 percent). To lower the cost of Azure VMs with workloads that can handle interruptions (such as batch processing jobs, use Azure Spot VMs. For more information regarding these options, refer to the [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes?toc=%2Fazure%2Fvirtual-network%2Ftoc.json) Microsoft Learn article.

## Plan for networking of Azure VMs running Linux

VMs communicate with external resources by using a virtual network. A _virtual network_ represents a private network within an Azure region. Just as with on-premises networks, you can divide virtual networks into multiple subnets to facilitate isolation of Azure VM workloads. You can also connect them to other networks, including those residing in your on-premises datacenters, and apply traffic rules to control inbound and outbound connectivity.

Every Azure VM includes one or more network interfaces. In turn, each interface connects to a subnet within the same virtual network. 

While it is possible to create a virtual network and its subnets as part of a VM provisioning process, the recommended approach is to start your Azure VM deployment with network environment planning. After you’ve accounted for all networking requirements and created the corresponding virtual networks, you can proceed with deploying Azure VMs.

### Virtual networks and subnets

Each virtual network designates an IP address space that typically consists of one or more private address ranges as defined by Request For Comments (RFC) 1918. Each subnet within a virtual network represents one of these ranges. The platform automatically assigns an Azure VM connected to a subnet an IP address from the subnet’s range. The platform reserves the first four and the last IP address on each subnet exclusively for its own use and does not assign them.

Subnets allow you to divide the virtual network address space into segments that reflect the workload isolation needs. To enforce that isolation, associate a Network Security Group (NSG) with each subnet.

As you plan for Azure virtual network, keep in mind the following general design principles:

Ensure address spaces do not overlap. The IP address spaces for your virtual networks and on-premises networks must not overlap if you want to be able to connect them at some point.

Use a smaller number of larger virtual networks. Rather than using a larger number of smaller virtual networks, you should use a smaller number of larger virtual networks. This will help minimize management overhead and facilitate scalability.

### Remote connectivity

As part of your deployment planning, you also need to consider the most suitable approach to providing remote connectivity. Such connectivity typically involves the use of Secure Shell (SSH). SSH implements in-transit encryption of a terminal shell session. 

To authenticate over an SSH connection, you can use a combination of a username and password, or an SSH key pair. Using only passwords for SSH connections leaves the VM vulnerable to brute-force attacks. Using SSH keys is a more secure and preferred method of connecting to a Linux VM with SSH.

Even with SSH keys, by default you must open connectivity to a public address associated with the target Azure VM's network adapter. However, this also is vulnerable to external threats, and represents a potential attack vector. To mitigate this risk, consider implementing Azure Bastion or just-in-time (JIT) VM access. 

### _Azure Bastion_

The first method involves deploying the Azure Bastion service into a dedicated subnet of a virtual network with connectivity to the target VM. Azure Bastion serves as a broker for external SSH connections. These connections take place over HTTPS and are available only from the Azure portal. This eliminates the need for assigning public IP addresses to the target VM’s network interface. It also helps ensure that only authenticated and properly authorized users can initiate SSH connections. For more information regarding these options, refer to the [Azure Bastion](/azure/bastion/bastion-overview) Microsoft Learn article.

### _JIT VM Access_

JIT VM access is one of the Microsoft Defender for Cloud features. Its purpose is to limit access to a public IP address associated with an Azure VM’s network interface. Access limitations are achieved by dynamically adjusting the NSG to allow incoming connections only from an explicitly designated IP address range during a designated time window. As with Azure Bastion, a user must authenticate first before initiating a connection from the Azure portal.

> [!NOTE]
> In hybrid scenarios, to eliminate the need for public IP addresses when connecting from your on-premises environment to Azure VMs, you can use site-to-site (S2S) VPN or Azure ExpressRoute.

### Network throughput

Although an Azure VM can have multiple network interfaces, its available bandwidth is dependent exclusively on its size. In general, larger VM sizes are allocated more bandwidth than smaller ones. When measuring the amount of the actual network bandwidth against the allocated limit, the platform targets only egress traffic. All network traffic leaving the VM counts toward that limit, regardless of the traffic destination. The platform does not directly limit the ingress bandwidth. However, factors such as storage and compute resource utilization impact the volume of incoming data an Azure VM can process. 

> [!NOTE]
> For information about the expected outbound throughput and the maximum number of network interfaces for each VM size, refer to the [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes?toc=%2Fazure%2Fvirtual-network%2Ftoc.json) Microsoft Learn article.
