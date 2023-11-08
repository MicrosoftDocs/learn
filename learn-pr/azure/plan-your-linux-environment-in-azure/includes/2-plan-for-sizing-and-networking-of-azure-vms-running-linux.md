Azure VM is a popular infrastructure-as-a-service (IaaS) compute resource type in Azure. Compared with platform-as-a-service (PaaS) compute services, Azure VMs provide more flexibility and control over the VM operating system (OS) and its configuration. The increased control and flexibility require more planning to support optimal outcomes.

This unit describes overall factors and considerations for planning Azure Linux VM deployments. The planning process should consider the compute, networking, and storage aspects of the VM configuration. Some of these characteristics are OS–specific, with implementation details varying across different Linux distributions.

Microsoft partners with prominent Linux vendors to integrate their products with the Azure platform. To fully benefit from this integration, you can create Azure VMs from prebuilt images for various popular Linux distributions, such as SUSE, Red Hat, and Ubuntu. Optionally, you can build a custom image of a Linux distribution to run in the cloud environment. In this case, there might be more steps in your Azure VM provisioning process.

In either case, this learning module can help further optimize your resulting deployment. Optimization requires you to have a strong understanding of the Azure VM resource and its dependencies.

## Understand resource dependencies

When you create an Azure VM, you also need to create several associated resources that the Azure VM depends on to provide full functionality to the virtualized OS. These resources include:

- Virtual disks to store the OS, applications, and data.
- A virtual network with one or more subnets to connect the Azure VM to other Azure services, or to your on-premises datacenters.
- A network interface to connect the Azure VM to a subnet of the virtual network.

  > [!NOTE]
  > Every network interface must have at least one private IP address assigned to it dynamically or statically. Private IP addresses aren't separate Azure resources, but are part of the subnet configuration.

- A resource group to host the Azure VM.
- Optionally, a public IP address associated with the VM's network interface, to provide direct inbound access to the VM from the internet.

Now that you understand the Azure VM resource dependencies, you can begin planning for VM sizing.

## Plan for sizing

To determine the right size for your Azure VM, you need to consider its intended workload. The size you choose determines the following characteristics of the VM:

- Processing power
- Memory
- Storage capacity 
- Performance
- Support for advanced networking features

> [!IMPORTANT]
> Azure VMs have virtual CPU (vCPU) quota limits, which you should account for in planning. To raise quota limits after deployment, you must submit an online request to Azure Support.

Azure offers a wide range of sizes with different specifications and price points to meet a wide variety of needs. VM sizes are grouped into several categories that represent the types of workloads they're optimized for. Each category includes one or more series, or *families*, which share common underlying hardware characteristics but offer a range of different sizes.

The following list shows the workload types and common use cases for each workload type. Each workload type has corresponding families that include various sizes.

- **General purpose**: Testing and development, small-to-medium databases, and low-to-medium traffic web servers.
- **Compute-intensive**: Medium-traffic web servers, network appliances, batch processes, and application servers.
- **Memory-intensive**: Relational database servers, medium-to-large caches, and in-memory analytics.
- **Storage-intensive**: Big data, SQL, and NoSQL databases that require high disk throughput and input/output (I/O).
- **Graphics Processing Unit (GPU)-enabled**: Heavy graphics rendering or video editing, and model training and inferencing with deep learning.
- **High-performance computing (HPC)**: Fastest and most powerful CPU VMs, with optional high-throughput network interfaces that support Remote Direct Memory Access (RDMA).

When you plan for Azure VM sizes, also consider the following factors:

- Changing the Azure VM series or size, while straightforward and commonplace, requires an OS restart. To avoid restarts, size the VM appropriately from the beginning if possible.
- VM size availability varies by region, so account for regional availability when you plan your deployment.
- The maximum number of disks you can attach to an Azure VM depends on its size.

### Other size considerations

Consider using the [Microsoft Azure VM Selector](https://azure.microsoft.com/pricing/vm-selector/) to determine the most suitable VM size based on the workload type, OS, software installed, and deployment region.

If you plan to use the same or similar size Azure VMs in the same region over an extended period, consider using [Azure Reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations) to reduce compute cost by up to 72 percent.

To lower the cost of Azure VMs for workloads that can handle interruptions, such as batch processing jobs, use [Azure Spot VMs](/azure/virtual-machines/spot-vms).

## Plan for networking

VMs communicate with external resources by using a *virtual network*. A virtual network represents a private network within an Azure region. You can connect virtual networks to other networks, including networks in your on-premises datacenters, and apply traffic rules to control inbound and outbound connectivity.

Each virtual network designates an *IP address space* that typically consists of one or more *private address ranges*, as defined by [RFC 1918](https://datatracker.ietf.org/doc/html/rfc1918). As with on-premises networks, you can divide the virtual network address space into multiple *subnets* to isolate Azure VM workloads. Each subnet within a virtual network represents a private address range. To enforce workload isolation, you associate a *Network Security Group (NSG)* with each subnet.

Every Azure VM includes one or more *network interfaces*, and each interface connects to a subnet within the same virtual network. Azure automatically assigns every VM in the subnet an IP address from the subnet's range. Azure reserves the first four and the last IP address on every subnet for its own use and doesn't assign them.

While it's possible to create a virtual network and subnets as part of a VM provisioning process, the recommended approach is to start Azure VM deployment planning with the network environment. After you account for all networking requirements and create the corresponding virtual networks, you can proceed with deploying the Azure VMs.

As you plan for Azure virtual networks and subnets, keep in mind the following design principles:

- Make sure address spaces don't overlap. If you want to connect your virtual networks and on-premises networks, the IP address spaces can't overlap.
- Use a smaller number of larger virtual networks rather than a larger number of smaller virtual networks. This practice helps minimize management overhead and facilitates scalability.

### Network bandwidth

Although an Azure VM can have multiple network interfaces, its available bandwidth depends completely on its size. In general, larger VM sizes are allocated more bandwidth than smaller sizes.

To measure the amount of actual network bandwidth against the allocated limit, Azure targets only egress traffic. All network traffic leaving the VM counts toward that limit, regardless of the traffic destination.

Azure doesn't directly limit ingress bandwidth. However, factors such as storage and compute resource utilization affect the volume of incoming data an Azure VM can process.

## Plan for remote connectivity

As part of your deployment planning, consider the most suitable approach to providing remote connectivity. For Linux VMs, remote connectivity typically involves using *Secure Shell (SSH)* to implement in-transit encryption of a terminal shell session.

To authenticate over an SSH connection, you can use a username and password or an *SSH key pair*. Using passwords for SSH connections leaves the VM vulnerable to brute-force attacks. Using SSH keys is a more secure and preferred method of connecting to a Linux VM with SSH.

Even with SSH keys, by default you must open connectivity to a public IP address associated with the target Azure VM's network adapter. This public IP is vulnerable to external threats and represents a potential attack vector. To mitigate this risk, consider implementing Azure Bastion or just-in-time (JIT) VM access.

> [!NOTE]
> In hybrid scenarios, to eliminate the need for public IP addresses when connecting from your on-premises environment to Azure VMs, you can use a site-to-site virtual private network (VPN) or Azure ExpressRoute.

### Azure Bastion

You deploy the Azure Bastion service into a dedicated subnet of a virtual network that has connectivity to the target VM. Azure Bastion serves as a broker for external SSH connections over HTTPS that are available only from the Azure portal. Azure Bastion eliminates the need for assigning public IP addresses to the target VM's network interface, and also ensures that only authenticated and properly authorized users can initiate SSH connections.

### JIT VM Access

JIT VM access is a Microsoft Defender for Cloud feature that limits access to a public IP address associated with an Azure VM's network interface. These limits dynamically adjust the NSG to allow incoming connections only from a designated IP address range during a designated time window. As with Azure Bastion, users must authenticate before initiating a connection from the Azure portal.

