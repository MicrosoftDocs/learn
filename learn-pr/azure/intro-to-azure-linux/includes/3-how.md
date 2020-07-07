Let's get a little more detailed. Understanding more about how Linux on Azure works can help you to better envision migrating to or building for the cloud and how exactly you'd go about it.

## Linux infrastructure as a service

The core of a Linux IaaS experience is the Linux distribution you choose to run on your Azure VMs, but there's quite a bit more to IaaS than that.

### Virtual machine images

A **VM image** is a snapshot of a virtual machine disk used as a template to create new VM instances. An image determines the initial contents of a VM's main disk, including its operating system and any preinstalled software and configuration.

When you create a virtual machine in Azure, you must specify the image that will be used to initialize it. There are two categories of images you can choose from: ready-made Azure Marketplace images and custom images.

#### Azure Marketplace images

Azure Marketplace is the online store for thousands of certified, open-source, and community VM images. The Marketplace contains images of base Linux distributions as well as images with preinstalled software tools installed on Linux for specific scenarios.

:::image type="content" source="../media/marketplace.png" alt-text="Screenshot of the Azure Marketplace in the Azure portal, showing Linux options":::

All Linux-based images on the Azure Marketplace include all of the software and configuration needed to ensure smooth operation on Azure VMs. This includes kernel-level driver support for Azure infrastructure like storage and networking, as well as Azure-supported features like Remote Direct Memory Access (RDMA).

Many of the images in the Azure Marketplace are completely free to use: you pay only for the virtual infrastructure your VM consumes. Some images have additional license and purchase terms for the software they include.

The Marketplace's collection of images can be searched and browsed from the Azure Marketplace web storefront, the Azure portal, Azure PowerShell or the Azure CLI.

#### Custom Linux images

Creating a custom image allows you to define the software and configuration installed on your VMs to your exact specifications. Using custom images can increase the speed of your virtual machine deployments by eliminating post-deployment tasks that would otherwise be needed to prepare a VM for its desired workload.

Custom images can be created by provisioning a VM based on a Marketplace image, making modifications manually or via automation, and capturing the result to a new image. You can also capture on-premises VMs to disk images and upload them to Azure. Alternatively, you can use **Azure Image Builder** or **HashiCorp Packer** to define and build custom images in a repeatable way through configuration. Microsoft also provides documentation for various Linux distributions about how to prepare an on-premises virtual machine for conversion to an Azure-compatible VM image.

If you have a large number of heavily-used custom images and want to make them available throughout your organization, you can use **Shared Image Galleries** for additional management and sharing options. Shared Image Galleries enable features such as global replication, high availability, versioning, and sharing within and across organizations.

### Endorsed Linux distributions

Microsoft contributes to the Linux kernel, ensuring that most newer Linux distributions are fully compatible with Azure VMs. Additionally, Microsoft maintains a list of **endorsed distributions** that carry additional guarantees and support when used on Azure. Microsoft has partnered with publishers of these Linux distributions to ensure a seamless Linux on Azure experience.

| Distribution             | Endorsed versions                      |
|--------------------------|----------------------------------------|
| CentOS                   | 6.x, 7.x, 8.x                          |
| Debian                   | 8.x, 9.x                               |
| Flatcar Container Linux  | Stable, Edge                           |
| Oracle Linux             | 6.x, 7.x, 8.x                          |
| Red Hat Enterprise Linux | 6.x, 7.x, 8.x                          |
| SUSE Linux Enterprise    | SLES/SLES for SAP 11.x, 12.x 15.x      |
| openSUSE                 | openSUSE Leap 15.x                     |
| Ubuntu                   | Ubuntu Server and Pro 16.x, 18.x, 20.x |

Additionally, Microsoft maintains a fully-supported FreeBSD image on the Marketplace.

Base images for all of the endorsed distributions are available on the Azure Marketplace. Microsoft works closely with its partners to optimize these images for Azure. They are the most popular Linux images on Azure, and Microsoft requires its partners to refresh them with updates and security fixes regularly.

The service level agreement for Azure virtual machines, which provides guarantees about connectivity, apply to Linux-based virtual machines only when endorsed distributions are used.

Microsoft's partnership with the publishers of the endorsed distributions has also resulted in valuable Azure-specific benefits. CentOS, Debian, SUSE Linux Enterprise and Ubuntu images include an Azure-tuned kernel with integrated features and performance improvements updated at a rapid cadence. Specialized images with application-specific Azure tuning such as SUSE Linux Enterprise Server for SAP, SUSE Linux Enterprise Server for High Performance Computing, and Red Hat Enterprise Linux for SAP are available. With integrated co-located support for Red Hat Enterprise Linux and SUSE Linux Enterprise, you can obtain support directly from the distribution publishing partner through your Azure support contract.

### Migrating on-premises Linux VMs and physical servers to Azure VMs

If your immediate concern is migrating specific workloads and applications to Azure with as little overhead as possible, the suite of tools provided by Azure Migrate support multiple key migration scenarios.

Azure Migrate can automatically discover, assess and migrate on-premises VMWare and Hyper-V VMs as well as physical servers. The Azure Migrate hub provides a centralized record of discovery, assessment, and migration activities.

Azure Migrate also includes tools for automatically assessing and migrating databases and web applications to Azure PaaS services.

### Virtual machine sizes and disks

:::image type="content" source="../media/sizes.png" alt-text="A screenshot of the Azure portal displaying the 'Select a VM Size' dialog":::

A VM's performance characteristics and pricing are determined by its *size*, which is selected independently from its image. You select a VM's size when you create it, and you can modify it at any time. Azure offers a wide variety of VM sizes across seven different optimization categories tuned for different kinds of workloads:

- **General purpose**. Balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers.
- **Compute optimized**. High CPU-to-memory ratio. Suitable for medium traffic web servers, network appliances, batch processes, and application servers.
- **Memory optimized**. High memory-to-CPU ratio. Great for relational database servers, medium to large caches, and in-memory analytics.
- **Burstable VMs**: For workloads that don’t require the full CPU performance all the time. These VMs can be purchased with VM-size baseline performance—meaning if a VM is using performing less than the baseline, it builds up credits. When higher CPU performance is required, it can burst up to 100 percent of the vCPU.
- **Storage optimized**: Optimized for storage-intensive workloads. High disk throughput and input/output (I/O) ideal for big data, SQL databases, NoSQL databases, data warehousing, and large transactional databases.
- **GPU-enabled VMs**: Specialized VMs targeted for heavy graphic rendering and video editing, as well as model training and inferencing (ND series) with deep learning. Available with single or multiple GPUs.
- **High performance compute**: Fastest and most powerful CPU VMs available with optional high-throughput network interfaces (remote direct memory access).

Every virtual machine you provision has a primary disk containing the boot volume with the VM's operating system, a temporary disk for short-term storage, and optional data disks for arbitrary persisted storage. Disks are available in four performance tiers:

- **Standard HDD** for latency-insensitive workloads at low cost
- **Standard SSD** for cost-effective, low-latency performance for workloads with relatively small data requirements
- **Premium SSD** for  guaranteed speed and throughput
- **Ultra disk** for data-intensive workloads such as databases

### Scaling

Individual VMs can be scaled up and down simply by modifying their sizes, but true cost-effective elastic scale is achieved with Azure's **virtual machine scale sets**.

A scale set allows you to provision and manage a group of identical VMs. Azure can automatically provision and deprovision VMs within the scale set using autoscale rules based on traffic, load, and timed schedules that you define. Scale sets integrate with Azure Load Balancer to distribute traffic to the VMs in the scale set.

Distributing an application's load across a scale set also ensures high availability. Individual VM instances that suffer from problems will not result in the application becoming completely unavailable. Health checks can be implemented with Azure Load Balancer to quickly detect and replace problematic instances. Scale sets also integrate with Azure's Availability Zones to ensure VM instances are distributed in a way that maximized resiliency.

### Virtual infrastructure and additional services

Provisioning for VM-based Linux workloads doesn't end with creating VMs:

- **Virtual networks** define how your VMs connect to each other and the internet
- **Network appliances and services** like load balancers and firewalls let you control how traffic moves through your virtual networks
- **Cloud storage and database services** like blob storage, Cosmos DB, Azure SQL, and Azure Cache for Redis can provide storage capabilities with features that can't be achieved in an IaaS-only architecture
- **Application services** such as Key Vault, Bot Service, and Cognitive Search add features and value to apps that are otherwise IaaS-based

All of these services and features work the same regardless of the Linux distribution you use on your IaaS VMs.

Azure provides a dedicated library of sample architectures for your reference - see the Azure Architecture Center link in the summary of this module. With many documented reference architectures available, you should be able to find the guidance you need to design and implement secure, highly available, performant, and resilient solutions on Azure.

### Management

All resources in Azure, including virtual machines, infrastructure and all the services you'd use as part of your solution, are provisioned, configured, and managed with **Azure Resource Manager**. The interface to Azure Resource Manager is a comprehensive REST API that defines actions for every kind of resource in Azure. This API is typically used through the Azure portal, Azure CLI, Azure PowerShell, or the Azure management libraries available for multiple popular programming languages.

:::image type="content" source="../media/manage.png" alt-text="A screenshot of the Azure portal showing the Cloud Shell and the Overview view of a virtual machine":::

Azure Resource Manager can be fully automated with scripts and template files for repeatability: you can define an entire virtual environment of VMs, infrastructure, and apps in a configuration file and deploy multiple instances of it for test and production environments.

### Pricing

|                                           |                                                                                                                                                                   |
|-------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Pay as you go**                         | VM usage of compute resources is billed by the second, with no commitments or up-front payments.                                                                  |
| **Reserved instances**                    | Purchase compute capacity for one to three years in advance at a significant savings. For stable workloads that allow you to plan your consumption ahead of time. |
| **Spot pricing**                          | Power workloads that can tolerate interruptions and delays by taking advantage of unused compute capacity at deep discounts.                                      |
| **Azure Reservations for software plans** | Pre-purchase one year or three year support agreement for Red Hat Enterprise Linux or SUSE Linux Enterprise Server for cost savings.                              |
| **Bring your own license/subscription**   | Bring your own Linux support license from your existing Red Hat or SUSE investment. See the links in the Summary unit for more information.                       |
| **Enterprise Agreement**                  | Use an existing Enterprise Agreement to purchase Red Hat Enterprise Linux and SUSE Linux Enterprise Server licenses.                                              |

Additional cost factors for IaaS workloads include infrastructure and service resources (see "Virtual infrastructure, management and additional services" above) and consumed bandwidth. The Azure pricing calculator can help you to determine the total costs for your workload. See the "Additional reading" section at the end of this module.

## Linux-based platform as a service

With Linux PaaS, you deploy your applications directly to Linux-based service platforms designed to support them.

**App Service** is a managed web application hosting platform. App Service significantly simplifies web server management tasks and eliminates the need to configure and maintain a Linux VM deployment. Use continuous integration to deploy your web applications and services into managed, scalable Linux environments with zero downtime.

**Azure Functions** provides serverless computing at the level of code. Write and deploy cloud-native, event-driven business logic and services without any concern for managing virtual infrastructure or even application platforms. With Functions, the operating system is almost entirely abstracted away from your code, but you can choose to host Functions on Linux to ensure compatibility for dependencies or configurations that require it.

**Azure Container Instances** is a serverless container execution environment. With Container Instances, you can run container-based workloads without managing any compute infrastructure. Azure Kubernetes Service can use Azure Container Instances for fast and flexible scaling.

**Azure Kubernetes Service** reduces the burden of managing a Kubernetes cluster by offloading responsibility for many critical tasks. When you deploy a cluster with AKS, Azure manages the master cluster nodes for you and handles tasks like logging and monitoring. AKS is also tightly integrated with Azure network infrastructure.

**Azure Red Hat OpenShift** provides first-class support for OpenShift container hosting on Azure. Specify and deploy scalable, resilient OpenShift clusters automatically and let Azure manage the cluster while you focus on your container-based applications.

Azure service platforms are all managed with the common Azure Resource Manager interface through the Azure portal, CLI, PowerShell, and management libraries available for multiple languages. Each service platform defines its own pricing and support model.
