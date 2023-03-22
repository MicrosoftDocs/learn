[Azure Virtual Machines](/azure/virtual-machines/) is the basis of the Azure Infrastructure-as-a-Service (IaaS) model. Virtual Machines can be used for developing, testing, and deploying applications in the cloud, or to extend your datacenter. Virtual Machines offers a fast, scalable, flexible way to add more compute power to your enterprise. 

### Things to know about Azure Virtual Machines

There are two main scenarios where Azure Virtual Machines can be an ideal compute solution for an infrastructure. Virtual Machines can be used to build new workloads and migrate data by using the lift and shift pattern. 

:::image type="content" source="../media/select-virtual-machines.png" alt-text="Flowchart that shows the decision tree for selecting Azure Virtual Machines to build new workloads and to support lift and shift migration." border="false":::

- **Build new workloads**: Azure Virtual Machines is ideal when you're building new workloads and demand for your applications can fluctuate. It's economical to run your applications on a virtual machine in Azure. 

- **Lift and shift migration**: If you're using lift and shift (rehosting) migration to move data and applications from an on-premises location, targeting Azure Virtual Machines in the cloud is an effective strategy. 

### Things to consider when using Azure Virtual Machines

Let's walk through a checklist of things to consider when using Azure Virtual Machines as a compute solution. As you review these points, think about what configuration is needed for the Tailwind Traders requirements.

- Start with your network.
- Name your virtual machine, and decide the location.
- Determine the size of your virtual machine.
- Review the pricing model, and Azure Storage options.
- Select an operating system.

#### Network configuration

The first thing to think about isn't your virtual machines at all - it's the network. Spend some time thinking about your network configuration for Tailwind Traders. Network addresses and subnets aren't trivial to change after they're configured. If you have an on-premises network, you'll want to carefully consider the network topology before you create any virtual machines.

#### Virtual machine name

Some developers don't give much thought about the name for a virtual machine. However, the **virtual machine name** defines a manageable **Azure resource**, and the value isn't easy to change. Choose machine names that are meaningful and consistent, so you can easily identify what each virtual machine does. 

Consider how to name the first development web server for Tailwind Traders that's hosted in the US South Central location. In this scenario, you might use the machine name `devusc-webvirtual machine01`. `dev` stands for development and `usc` identifies the location. `web` indicates the machine as a web server, and the suffix `01` shows the machine is the first in the configuration.

#### Virtual machine location

Azure has datacenters all over the world filled with servers and disks. These datacenters are grouped into geographic regions like West US, North Europe, Southeast Asia, and so on. The datacenters provide redundancy and availability.

Each virtual machine is in a region where you want the resources like CPU and storage to be allocated. The regional location lets you place your virtual machines as close as possible to your users. The location of the machine can improve performance and ensure you meet any legal, compliance, or tax requirements.

There are two other points to consider about the virtual machine location.
- The machine location can limit your available options. Each region has different hardware available, and some configurations aren't available in all regions.
- There are price differences between locations. To find the most cost-effective choice, check for your required configuration in different regions.

#### Virtual machine size

After you choose the virtual machine name and location, you need to decide on the size of your machine. Azure offers different memory and storage options for different [virtual machine sizes](/azure/virtual-machines/sizes). 

The best way to determine the appropriate machine size is to consider the type of workload your machine needs to run. Based on the workload, you can choose from a subset of available virtual machine sizes. The following table shows size classifications for Azure Virtual Machines workloads and recommended usage scenarios.

| **Classification** | **Description** | **Scenarios** |
| --- | --- | --- |
| **General purpose** | General-purpose virtual machines are designed to have a balanced CPU-to-memory ratio. | - Testing and development <br> - Small to medium databases <br> - Low to medium traffic web servers |
| **Compute optimized** | Compute optimized virtual machines are designed to have a high CPU-to-memory ratio. | - Medium traffic web servers <br> - Network appliances <br> - Batch processes <br> - Application servers |
| **Memory optimized** | Memory optimized virtual machines are designed to have a high memory-to-CPU ratio. | - Relational database servers <br> - Medium to large caches <br> - In-memory analytics |
| **Storage optimized** | Storage optimized virtual machines are designed to have high disk throughput and I/O. | - Virtual machines running databases |
| **GPU** | GPU virtual machines are specialized virtual machines targeted for heavy graphics rendering and video editing. | - Model training and inferencing with deep learning |
| **High performance computes** | High performance compute offers the fastest and most powerful CPU virtual machines with optional high-throughput network interfaces. | - Workloads that require fast performance <br> - High traffic networks |

#### Virtual machine pricing

A subscription is billed two separate costs for every virtual machine: _compute_ and _storage_. By separating these costs, you can scale them independently and only pay for what you need.

- **Compute costs**: Compute expenses are priced on a per-hour basis but billed on a per-minute basis. If the virtual machine is deployed for 55 minutes, you're charged for only 55 minutes of usage. You're not charged for compute capacity if you stop and deallocate the virtual machine. The [hourly price](https://azure.microsoft.com/pricing/details/virtual-machines/linux/) varies based on the virtual machine size and operating system you select.

- **Storage costs**: You're charged separately for the Azure Storage the virtual machine uses. The status of the virtual machine has no relation to the Azure Storage charges that are incurred. You're always charged for any Azure Storage used by the disks. 

#### Azure Storage

[Azure Managed Disks](/azure/virtual-machines/managed-disks-overview) handle Azure storage account creation and management in the background for you. You specify the disk size and the performance tier (Standard or Premium). Azure creates and manages the disk. As you add disks or scale the virtual machine up and down, you don't have to worry about the storage being used.

#### Operating system

Azure provides various operating system images that you can install into the virtual machine, including several versions of Windows and flavors of Linux. Azure bundles the cost of the operating system license into the price.

- If you're looking for more than just base operating system images, you can search [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/compute). There are various install images that include not only the operating system but popular software tools, such as WordPress. The image stack consists of a Linux server, Apache web server, a MySQL database, and PHP. Instead of setting up and configuring each component, you can install an Azure Marketplace image and get the entire stack all at once.

- If you don't find a suitable operating system image, you can create your own disk image. Your disk image can be uploaded to Azure Storage and used to create an Azure virtual machine. Keep in mind that Azure only supports 64-bit operating systems.

#### Business application

Try the [Azure Virtual Machines selector tool](https://azure.microsoft.com/pricing/vm-selector/) to find other sizes that best fit your workload.