Whether you’re building new or migrating using a lift and shift pattern, [Azure virtual machines](/azure/virtual-machines/) (VMs) might be a choice for you. Azure VMs are the basis of the Azure [Infrastructure-as-a-Service (IaaS) model](https://azure.microsoft.com/overview/what-is-iaas/). Azure VMs can be used for the development, testing, deployment of applications in the cloud, or extension of your data center. Azure VMs provide a fast, scalable, flexible way to add more compute power to your enterprise. 

There are two main scenarios for deciding to use virtual machines.

- **Build new** because demand for your application can fluctuate. It makes economic sense to run it on a VM in Azure. 

- **Lift and shift (rehosting)** migration strategy that involves moving data and applications from an on-premises location to Azure-based virtual machines in the cloud. 

 

:::image type="content" source="../media/select-virtual-machines.png" alt-text="Flowchart for selecting Azure virtual machines.":::



Let's walk through a checklist of things to think about when designing for Azure VMs.

- Start with the network

- Name the VM

- Decide the location for the VM

- Determine the size of the VM

- Review the pricing model

- Review the storage options

- Select an operating system

### Start with the network

The first thing to think about isn't the virtual machine at all - it's the network. So, spend some time thinking about your network configuration. Network addresses and subnets aren’t trivial to change once you have them set up. If you have an on-premises network, you’ll want to carefully consider the network topology before creating any virtual machines.

### Name the virtual machine

One thing people don't put much thought into is the **name** of the VM. This name defines a manageable **Azure resource**, and it's also not easy to change. Choose names that are meaningful and consistent so you can easily identify what the VM does. For example, devusc-webvm01 might represent the first development web server hosted in the US South Central location.

### Decide the location for the VM

Azure has data centers all over the world filled with servers and disks. These datacenters are grouped into geographic regions ('West US', 'North Europe', 'Southeast Asia' …) to provide redundancy and availability.

Each virtual machine is in a region where you want the resources (CPU, storage …) to be allocated. Regional location lets you place your VMs as close as possible to your users. This location can improve performance and ensure you meet any legal, compliance, or tax requirements.

Two other things to think about the location choice. First, the location can limit your available options. Each region has different hardware available, and some configurations aren’t available in all regions. Second, there are price differences between locations. To find the most cost-effective choice, check for your required configuration in different regions.

### Determine the size of the VM

Once you have the name and location set, you need to decide on the size of your VM. Azure offers different memory and storage options for different [VM sizes](/azure/virtual-machines/sizes). 

The best way to determine the appropriate VM size is to consider the type of workload your VM needs to run. Based on the workload, you're able to choose from a subset of available VM sizes. Azure virtual machine workloads are classified as follows.

| **Option**| **Description** |
| - | - |
| General purpose| General-purpose VMs are designed to have a balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers. |
| Compute optimized| Compute optimized VMs are designed to have a high CPU-to-memory ratio. Suitable for medium traffic web servers, network appliances, batch processes, and application servers. |
| Memory optimized| Memory optimized VMs are designed to have a high memory-to-CPU ratio. Great for relational database servers, medium to large caches, and in-memory analytics. |
| Storage optimized| Storage optimized VMs are designed to have high disk throughput and IO. Ideal for VMs running databases. |
| GPU| GPU VMs are specialized virtual machines targeted for heavy graphics rendering and video editing. These VMs are ideal options for model training and inferencing with deep learning. |
| High performance computes| High performance compute is the fastest and most powerful CPU virtual machines with optional high-throughput network interfaces. |


 

> [!TIP]
> Try the [Virtual machines selector tool](https://azure.microsoft.com/pricing/vm-selector/) to find other sizes that best fit your workload.

### Review the pricing model

There are two separate costs the subscription will be charged for every VM: compute and storage. By separating these costs, you can scale them independently and only pay for what you need.

- **Compute costs** - Compute expenses are priced on a per-hour basis but billed on a per-minute basis. For example, you’re only charged for 55 minutes of usage if the VM is deployed for 55 minutes. You’re not charged for compute capacity if you stop and deallocate the VM. The [hourly price](https://azure.microsoft.com/pricing/details/virtual-machines/linux/) varies based on the VM size and OS you select.

- **Storage costs** - You’re charged separately for the storage the VM uses. The status of the VM has no relation to the storage charges that will be incurred. You are always charged for storage used by the disks. 

### Review the storage options

[Managed disks](/azure/virtual-machines/managed-disks-overview) handle Azure storage account creation and management in the background for you. You specify the disk size and the performance tier (Standard or Premium), and Azure creates and manages the disk. As you add disks or scale the VM up and down, you don't have to worry about the storage being used.

### Select an operating system

Azure provides various OS images that you can install into the VM, including several versions of Windows and flavors of Linux. Azure bundles the cost of the OS license into the price.

If you’re looking for more than just base OS images, you can search the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/compute). There are various install images that include not just the OS but popular software tools. For example, there is an image for WordPress. The image stack consists of a Linux server, Apache web server, a MySQL database, and PHP. So, instead of setting up and configuring each component, you can install a Marketplace image and get the entire stack all at once.

Lastly, if you can't find a suitable OS image, you can create your own disk image. Your disk image can then be uploaded to Azure storage and used to create an Azure VM. Keep in mind that Azure only supports 64-bit operating systems.

**Important**: There’s a lot to think about when planning for virtual machines. Take a few minutes to think through what you have learned? Will you need virtual machines? If so, what decisions will you make on size, pricing, and operating systems?