Before you create an Azure virtual machine, it's helpful to make a plan for the machine configuration. You need to consider your preferences for several options, including the machine size and location, storage usage, and associated costs.

### Things to know about configuring virtual machines

Let's walk through a checklist of things you need to consider when configuring a virtual machine.

- Start with the network.
- Choose a name for the virtual machine.
- Decide the location for the virtual machine.
- Determine the size of the virtual machine.
- Review the pricing model and estimate your costs.
- Identify which Azure Storage to use with the virtual machine.
- Select an operating system for the virtual machine.

#### Network configuration

Virtual networks are used in Azure to provide private connectivity between Azure Virtual Machines and other Azure services. Virtual machines and services that are part of the same virtual network can access one another. By default, services outside the virtual network can't connect to services within the virtual network. You can, however, configure the network to allow access to the external service, including your on-premises servers.

Network addresses and subnets aren't trivial to change after they're configured. If you plan to connect your private company network to the Azure services, make sure you consider the topology before you put any virtual machines into place.

#### Virtual machine name

The virtual machine name is used as the computer name, which is configured as part of the operating system. You can specify a name with up to 15 characters on a Windows virtual machine and 64 characters on a Linux virtual machine.

The virtual machine name also defines a manageable Azure resource, and it's not trivial to change later. You should choose names that are meaningful and consistent, so you can easily identify what the virtual machine does. A good convention uses several of the following elements in the machine name:

| Name element | Examples | Description |
| --- | --- | ---|
| **Environment or purpose** | `dev` (development), `prod` (production), `QA` (testing) | A portion of the name should identify the environment or purpose for the machine. |
| **Location** | `uw` (US West), `je` (Japan East), `ne` (North Europe) | Another portion of the name should specify the region where the machine is deployed. |
| **Instance** | `1`, `02`, `005` | For multiple machines that have similar names, include an instance number in the name to differentiate the machines in the same category. |
| **Product or service** | `Outlook`, `SQL`, `AzureAD`  | A portion of the name can specify the product, application, or service that the machine supports. |
| **Role** | `security`, `web`, `messaging` | A portion of the name can specify what role the machine supports within the organization. |

Let's consider how to name the first development web server for your company that's hosted in the US South Central location. In this scenario, you might use the machine name `devusc-webvm01`. `dev` stands for development and `usc` identifies the location. `web` indicates the machine as a web server, and the suffix `01` shows the machine is the first in the configuration.

#### Virtual machine location

Azure has datacenters all over the world filled with servers and disks. These datacenters are grouped into geographic regions like West US, North Europe, Southeast Asia, and so on. The datacenters provide redundancy and availability.

Each virtual machine is in a region where you want the resources like CPU and storage to be allocated. The regional location lets you place your virtual machines as close as possible to your users. The location of the machine can improve performance and ensure you meet any legal, compliance, or tax requirements.

There are two other points to consider about the virtual machine location.

- The machine location can limit your available options. Each region has different hardware available, and some configurations aren't available in all regions.

- There are price differences between locations. To find the most cost-effective choice, check for your required configuration in different regions.

#### Virtual machine size

Azure offers different memory and storage options for different [virtual machine sizes](/azure/virtual-machines/sizes). The best way to determine the appropriate machine size is to consider the type of workload your machine needs to run. Based on the workload, you can choose from a subset of available virtual machine sizes.

#### Azure Storage

[Azure Managed Disks](/azure/virtual-machines/managed-disks-overview) handle Azure storage account creation and management in the background for you. You specify the disk size and the performance tier (Standard or Premium). Azure creates and manages the disk. As you add disks or scale the virtual machine up and down, you don't have to worry about the storage being used.

#### Virtual machine pricing options

A subscription is billed two separate costs for every virtual machine: _compute_ and _storage_. By separating these costs, you can scale them independently and only pay for what you need.

- **Compute expenses** are priced on a per-hour basis but billed on a per-minute basis. If the virtual machine is deployed for 55 minutes, you're charged for only 55 minutes of usage. You're not charged for compute capacity if you stop and deallocate the virtual machine. The [hourly price](https://azure.microsoft.com/pricing/details/virtual-machines/linux/) varies based on the virtual machine size and operating system you select. For the compute costs, you're able to choose from two payment options:

   - **Consumption-based**: With the consumption-based option, you pay for compute capacity by the second. You're able to increase or decrease compute capacity on demand and start or stop at any time. Use consumption-based pricing if you run applications with short-term or unpredictable workloads that can't be interrupted. An example scenario is if you're doing a quick test or developing an app in a virtual machine.

   - **Reserved Virtual Machine Instances**: The Reserved Virtual Machine Instances (RI) option is an advance purchase of a virtual machine for one or three years in a specified region. The commitment is made up front, and in return, you get up to 72% price savings compared to pay-as-you-go pricing. RIs are flexible and can easily be exchanged or returned for an early termination fee. Use this option if the virtual machine has to run continuously, or you need budget predictability, and you can commit to using the virtual machine for at least a year.

- **Storage costs** are charged separately for the Azure Storage used by the virtual machine. The status of the virtual machine has no relation to the Azure Storage charges that are incurred. You're always charged for any Azure Storage used by the disks. 

#### Operating system

Azure provides various operating system images that you can install into the virtual machine, including several versions of Windows and flavors of Linux. Azure bundles the cost of the operating system license into the price.

- If you're looking for more than just base operating system images, you can search [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/compute). There are various install images that include not only the operating system but popular software tools, such as WordPress. The image stack consists of a Linux server, Apache web server, a MySQL database, and PHP. Instead of setting up and configuring each component, you can install an Azure Marketplace image and get the entire stack all at once.

- If you don't find a suitable operating system image, you can create your own disk image. Your disk image can be uploaded to Azure Storage and used to create an Azure virtual machine. Keep in mind that Azure only supports 64-bit operating systems.