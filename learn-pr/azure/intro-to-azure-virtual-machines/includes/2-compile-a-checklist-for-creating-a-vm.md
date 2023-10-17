Performing a migration of on-premises servers to Azure requires planning and care. You can move them all at once, or more likely, in small batches or even individually. Before you create a single VM, you should sit down and sketch out your current infrastructure model and see how it might map to the cloud.

## What is an Azure resource?

An **Azure resource** is a manageable item in Azure. Just like a physical computer in your datacenter, VMs have several elements that are needed to do their job:

- The VM itself
- Disks for storage
- Virtual network
- Network interface to communicate on the network
- Network Security Group (NSG) to secure the network traffic
- An IP address (public, private, or both)

Azure creates all of these resources if necessary, or you can supply existing ones as part of the deployment process. Each resource needs a name that's used to identify it. If Azure creates the resource, it uses the VM name to generate a resource name - another reason to be consistent with your VM names!


## Required resources for IaaS Virtual Machines

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWjVUg]


Let's walk through a checklist of things to think about.

- The network
- VM name
- Location
- The VM size
- Disks
- Operating system

## The network

The first thing you should think about isn't the virtual machine at all - it's the network. Take a look at on of your on-premises servers:
- What does the server communicate with?
- Which ports are open?

Virtual networks (VNets) are used in Azure to provide private connectivity between Azure Virtual Machines and other Azure services. VMs and services that are part of the same virtual network can access one another. By default, services outside the virtual network can't connect to services within the virtual network. You can, however, configure the network to allow access to the external service, including your on-premises servers.

This latter point is why you should spend some time thinking about your network configuration. Network addresses and subnets aren't trivial to change once you have them set up. If you plan to connect your private company network to the Azure services, you want to make sure you consider the topology before putting any VMs into place.

When you set up a virtual network, you specify the available address spaces, subnets, and security. If the VNet is connected to other VNets, you must select address ranges that aren't overlapping. This is the range of private addresses that the VMs and services in your network can use. You can use unroutable IP addresses such as 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16, or define your own range. Azure treats any address range as part of the private VNet IP address space if it's only reachable within the VNet, within interconnected VNets, and from your on-premises location. If someone else is responsible for the internal networks, you should work with that person before selecting your address space to make sure there's no overlap. Let them know what space you want to use, so they don’t try to use the same range of IP addresses.

### Segregate your network

After deciding the virtual network address space(s), you can create one or more subnets for your virtual network. You create these subnets to break up your network into more manageable sections. For example, you might assign 10.1.0.0 to VMs, 10.2.0.0 to back-end services, and 10.3.0.0 to SQL Server VMs.

> [!NOTE]
> Azure reserves the first four addresses and the last address in each subnet for its use.

### Secure the network

By default, there's no security boundary between subnets, so services in each of these subnets can talk to one another. However, you can set up Network Security Groups (NSGs), which allow you to control the traffic flow to and from subnets and to and from VMs. NSGs act as software firewalls, applying custom rules to each inbound or outbound request at the network interface and subnet level. This way, you can fully control every network request coming in or out of the VM.

## Plan each VM deployment

Once you have mapped out your communication and network requirements, you can start thinking about the VMs you want to create. A good plan is to select a server and take an inventory:

- Which OS is used?
- How much disk space is in use?
- What kind of data does this use? Are there restrictions (legal or otherwise) around how it's stored or where it's physically located?
- What sort of CPU, memory, and disk I/O load does the server have? Is there burst traffic to account for?

We can then start to answer some of the questions Azure has for a new virtual machine.

### VM name

The VM name is used as the computer name, which is configured as part of the operating system. You can specify a name of up to 64 characters on a Linux VM and 15 characters on a Windows VM.

This name also defines a manageable **Azure resource**, and it's not trivial to change later. That means you should choose names that are meaningful and consistent, so you can easily identify what the VM does. A good convention is to include the following information in the name:

| Element | Example | Notes |
| --- | --- | --- |
| Environment |dev, prod, QA |Identifies the environment for the resource |
| Location | `eus` for East US, `jw` for Japan West |Identifies the region into which the resource is deployed |
| Instance |01, 02 |For resources that have more than one named instance (web servers, etc.) |
| Product or Service |service |Identifies the product, application, or service that the resource supports |
| Role |sql, web, messaging |Identifies the role of the associated resource |

For example, `deveus-webvm01` might represent the first development web server hosted in the East US location.


### Decide the location for the VM

Azure has datacenters all over the world filled with servers and disks. These datacenters are grouped into geographic _regions_ ('West US', 'North Europe', 'Southeast Asia', etc.) to provide redundancy and availability.

When you create and deploy a virtual machine, you must select a region where you want to allocate the resources. You can place your VMs as close as possible to your users to improve performance and to meet any legal, compliance, or tax requirements.

Two other things to think about regarding the location choice. First, the location can limit your available options. Each region has different hardware available and some configurations aren't available in all regions. Second, there are price differences between locations. If your workload isn't bound to a specific location, it can be very cost effective to check your required configuration in multiple regions to find the lowest price.

### Determine the size of the VM

Once you have the name and location set, you need to decide on the [size of your VM](/azure/virtual-machines/sizes). Rather than specify processing power, memory, and storage capacity independently, Azure provides different _VM sizes_ that offer variations of these elements in different sizes. Azure provides a wide range of VM size options allowing you to select the appropriate mix of compute, memory, and storage for what you want to do.

The best way to determine the appropriate VM size is to consider the type of workload your VM needs to run. Based on the workload, you're able to choose from a subset of available VM sizes. Workload options are classified as follows on Azure:

| Option              | Description |
|---------------------|-------------|
| [General purpose](/azure/virtual-machines/sizes-general) | General-purpose VMs are designed to have a balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers. |
| [Compute optimized](/azure/virtual-machines/sizes-compute) | Compute optimized VMs are designed to have a high CPU-to-memory ratio. Suitable for medium traffic web servers, network appliances, batch processes, and application servers. |
| [Memory optimized](/azure/virtual-machines/sizes-memory) | Memory optimized VMs are designed to have a high memory-to-CPU ratio. Great for relational database servers, medium to large caches, and in-memory analytics. |
| [Storage optimized](/azure/virtual-machines/sizes-storage) | Storage optimized VMs are designed to have high disk throughput and IO. Ideal for VMs running databases. |
| [GPU](/azure/virtual-machines/sizes-gpu) | GPU VMs are specialized virtual machines targeted for heavy graphics rendering and video editing. These VMs are ideal options for model training and inferencing with deep learning. |
| [High performance compute](/azure/virtual-machines/sizes-hpc) | High performance compute is the fastest and most powerful CPU virtual machines with optional high-throughput network interfaces. |

You're able to filter on the workload type when you configure the VM size in the Azure. The size you choose directly affects the cost of your service. The more CPU, memory, and GPU you need, the higher the price point.

### What if my size needs change?

Azure allows you to change the VM size when the existing size no longer meets your needs. You can upgrade or downgrade the VM - as long as your current hardware configuration is allowed in the new size. The ability to change VM size provides a fully agile and elastic approach to VM management.

The VM size can be changed while the VM is running, as long as the new size is available in the current hardware cluster the VM is running on. The Azure portal makes the size options obvious by only showing you available size choices. The command line tools report an error if you attempt to resize a VM to an unavailable size. Changing a running VM size automatically reboots the machine to complete the request.

If you stop and deallocate the VM, you can then select any size available in your region since deallocation removes your VM from the cluster it was running on.

> [!WARNING]
> Be careful about resizing production VMs - they will be rebooted automatically which can cause a temporary outage and change some configuration settings such as the IP address.

### Understanding the pricing model

There are two separate costs the subscription is charged for every VM: compute and storage. By separating these costs, you scale them independently and only pay for what you need.

**Compute costs** - Compute expenses are priced on a per-hour basis but billed on a per-minute basis. For example, you're only charged for 55 minutes of usage if the VM is deployed for 55 minutes. You're not charged for compute capacity if you stop and deallocate the VM since deallocation releases the hardware. The hourly price varies based on the VM size and OS you select. Linux-based instances are cheaper because there's no operating system license charge. For Windows, the cost for a VM includes the charge for the operating system.

> [!TIP]
> You might be able to save money by reusing existing licenses with the **Azure Hybrid benefit** for [Linux](/azure/virtual-machines/linux/azure-hybrid-benefit-linux) or [Windows](/azure/virtual-machines/windows/hybrid-use-benefit-licensing).

You're able to choose from two payment options for compute costs.

| Option | Description |
|--------|-------------|
| **Pay as you go** | With the **pay-as-you-go** option, you pay for compute capacity by the second, with no long-term commitment or upfront payments. You're able to increase or decrease compute capacity on demand and start or stop at any time. Select this option if you run applications with short-term or unpredictable workloads that can't be interrupted. For example, if you're doing a quick test, or developing an app in a VM, **pay-as-you-go** is the appropriate option. |
| **Reserved Virtual Machine Instances** | The Reserved Virtual Machine Instances (RI) option is an advance purchase of a virtual machine for one or three years in a specified region. The commitment is made up front, and in return, you get up to 72% price savings compared to pay-as-you-go pricing. **RIs** are flexible and can easily be exchanged or returned for an early termination fee. Select this option if the VM has to run continuously, or you need budget predictability, **and** you can commit to using the VM for at least a year. |

**Storage costs** - You're charged separately for the storage the VM uses. The status of the VM has no relation to the storage charges that are incurred. If the VM is stopped/deallocated and you aren’t billed for the running VM, you're still charged for the storage used by the disks.

### Storage for the VM

All Azure virtual machines have at least two virtual hard disks (VHDs). The first disk stores the operating system, and the second is used as temporary storage. You should add more data disks to store application data. Separating out the data to different disks allows you to manage the disks independently. The VM size determines the maximum number of data disks you can attach to your VM, typically two per vCPU.

There are five disk types, each intended to address a specific customer scenario:

- [Ultra disks](/azure/virtual-machines/disks-types#ultra-disks)
- [Premium SSD v2 (preview)](/azure/virtual-machines/disks-types#premium-ssd-v2-preview)
- [Premium SSDs (solid-state drives)](/azure/virtual-machines/disks-types#premium-ssds)
- [Standard SSDs](/azure/virtual-machines/disks-types#standard-ssds)
- [Standard HDDs (hard disk drives)](/azure/virtual-machines/disks-types#standard-hdds)

The following table provides a comparison of the five disk types to help you decide which to use.

|         | Ultra disk | Premium SSD v2 | Premium SSD | Standard SSD | <nobr>Standard HDD</nobr> |
| ------- | ---------- | ----------- | ------------ | ------------ | ------------ |
| **Disk type** | SSD | SSD |SSD | SSD | HDD |
| **Scenario**  | IO-intensive workloads such as [SAP HANA](/azure/virtual-machines/workloads/sap/hana-vm-operations-storage), top tier databases (for example, SQL, Oracle), and other transaction-heavy workloads. | Production and performance-sensitive workloads that consistently require low latency and high IOPS and throughput | Production and performance sensitive workloads | Web servers, lightly used enterprise applications and dev/test | Backup, noncritical, infrequent access |
| **Max disk size** | 65,536 gibibytes (GiB) | 65,536 GiB |32,767 GiB | 32,767 GiB | 32,767 GiB |
| **Max throughput** | 4,000 MB/s | 1,200 MB/s | 900 MB/s | 750 MB/s | 500 MB/s |
| **Max IOPS** | 160,000 | 80,000 | 20,000 | 6,000 | 2,000 |
| **Usable as OS Disk?** | No | No | Yes | Yes | Yes |
### Select an operating system

Azure provides various OS images that you can install into the VM, including many Linux distributions. The choice of OS might influence your hourly compute pricing as Azure bundles the cost of the OS license into the price.

If you're looking for more than just base OS images, you can search the Azure Marketplace for more sophisticated images that include the OS and popular software tools for specific scenarios. For example, if you needed a new WordPress site, the standard technology stack would consist of a Linux server, Apache web server, a MySQL database, and PHP. Instead of setting up and configuring each component, you can use a Marketplace image and install the entire stack all at once.

Finally, if you can't find a suitable OS image, you can create your own image with what you need, and use them to create VMs. You can create individual images for use in development and test. Or, you can create an [Azure Compute Gallery](/azure/virtual-machines/azure-compute-gallery) to manage multiple images and replicate them to the regions where they're needed.
