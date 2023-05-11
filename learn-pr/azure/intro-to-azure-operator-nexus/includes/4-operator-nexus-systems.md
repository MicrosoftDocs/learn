Operator Nexus utilizes a curated and certified hardware Bill of Materials (BOM). It’s composed of commercially available off-the-shelf servers, network switches, and storage arrays. The infrastructure is deployed in operator’s on-premises data center.
The service that manages the Operator Nexus infrastructure is hosted in Azure. Operators can choose an Azure region that supports Operator Nexus for any on-premises Operator Nexus instance. The diagram illustrates the architecture of the Operator Nexus service.

- The management layer of Operator Nexus is built on Azure Resource Manager (ARM), that provides consistent user experience in the Azure portal and Azure APIs
- Azure Resource Providers provide modeling and lifecycle management of Operator Nexus resources such as bare metal machines, clusters, network devices, etc.
- Operator Nexus controllers: Cluster Manager and Network Fabric Controller, are deployed in a managed Virtual Network (VNet) connected to operator’s on-premises network. The controllers enable functionalities such as infrastructure bootstrapping, configurations, service upgrades etc.
- Operator Nexus is integrated with many Azure services such as Azure Monitor, Azure Container Registry, and Azure Kubernetes Services.
- ExpressRoute is a network connectivity service that bridges Azure regions and operators’ locations.

### Network Fabric Automation

Operator Nexus includes Network Fabric Automation (NFA) which enables operators to build, operate and manage carrier grade network fabrics. The reliable and distributed cloud services model supports the operators’ telco network functions. Operators can interact with Operator Nexus to provision the network fabric via Zero-Touch Provisioning (ZTP), as well as perform complex network implementations via a workflow driven, API model.

### Cluster manager

The Cluster Manager (CM) is hosted on Azure and manages the lifecycle of all on-premises clusters. Like NFC, a CM can manage multiple Operator Nexus instances. The CM and the NFC are hosted in the same Azure subscription.

### Bare metal and cluster management

Operator Nexus includes capabilities to manage the bare metal hosts in operators’ premises. Operators can provision the bare metal hosts using Operator Nexus and can interact to restart, shutdown, or re-image, for example. One important component of the service is Cluster Manager. Cluster Manager provides the lifecycle management of Kubernetes clusters that are made of the bare metal hosts.

## Operator Nexus key components

### Azure cloud services

[Azure Resource Manager (ARM)](\\azure\azure-resource-manager\management\overview) is the Azure deployment and management service that enables the creation, update, and deletion of resources. When a user sends a request from Azure, the Resource Manager receives the request, authenticates, authorizes the request and then sends the request to the Azure service. The Azure service performs the requested action. Because all requests are handled through the same API, users see consistent results and capabilities in all the different tools.

The **Network Cloud Resource Provider (RP)** is the primary Operator-facing component of Operator Nexus architecture. It provides the API interface to lifecycle on-premises environments and the higher-level resources like Kubernetes clusters, virtual machines, etc. Users can interact via ARM templates, the Portal and SDKs. The Network Cloud RP API will interact with the Network Cloud operators running within the operator’s on-premises environment to perform the actual lifecycle operation. A minimum set of administrative RPs will allow Microsoft to perform basic management of the Operator Nexus platform resources and components.

[Azure Arc](\\azure\azure-arc\overview) simplifies governance and management by delivering a consistent multi-cloud and on-premises management platform. Azure Arc is a set of technologies that brings Azure security and cloud-native services to hybrid and multi-cloud environments. It enables users to secure and govern infrastructure and applications from anywhere. Cloud-native apps can be built faster with familiar tools and services. They can be run on any Kubernetes platform, and modernize the data estate with Azure data and machine-learning services. Azure Arc provides a centralized, unified way to manage the Operators entire environment by projecting your existing non-Azure and/or on-premises resources into Azure Resource Manager. It allows for the management of the Physical and Virtual (VMs) Servers, Kubernetes clusters, etc. hosted outside of Azure as if they were running in Azure.

**Azure Operator Service Manager** is a service that allows Network Equipment Providers (NEP) to publish their NFs in Azure Marketplace. Operators can deploy them using familiar Azure APIs. Operator Service Manager provides a framework for NEPs and Microsoft to test and validate the basic functionality of the NFs. The validation includes lifecycle management of an NF on Operator Nexus.

**Observability**: Operator Nexus automatically streams the metrics and logs from the operator’s premises to Azure Monitor and Log Analytics workspace of:

- Infrastructure (compute, network and storage)
- Tenant Infrastructure (ex. VNF VMs).

Log Analytics has a rich analytical toolset that operators can use for troubleshooting or correlating for operational insights. Azure Monitor allows operators to specify alerts.

:::image type="content" source="../media/azure-cloud-services-and-on-prem.png" alt-text="The Azure cloud services and on-premises components that make up the Nexus architecture." border="false":::

### Host-level software components

#### Host operating system (OS)

[CBL-Mariner](https://github.com/microsoft/CBL-Mariner#cbl-mariner) is a Linux distribution for Microsoft’s cloud infrastructure and edge products and services and is used as the BareMetal host Operating System (OS). CBL-Mariner has been engineered with the notion that a small common core set of packages can address the universal needs of cloud and edge services. Users can add packages on top of the common core to produce images for their workloads. This customization is made possible by a simple build system that enables:

- **Package Generation**: This produces the desired set of RPM packages from SPEC files and source files.
- **Image Generation**: This produces the desired image artifacts like ISOs or VHDs from a given set of packages.

CBL-Mariner can be deployed as a container or a container host. It consumes limited disk and memory resources. It provides an 80% reduction in the base image size. It also provides a 40% reduction in node image upgrade times compared with other widely used Linux distributions. The lightweight characteristics of CBL-Mariner also provide faster boot times and a minimal attack surface.

#### Azure Kubernetes Services (AKS)

When users deploy an AKS cluster, the Kubernetes control plane and all nodes are deployed and configured for you. Since Kubernetes control plane is managed by Azure, users only manage and maintain the agent nodes.

Advanced networking, Azure Active Directory (Azure AD) integration, monitoring, and other features can be configured during the deployment process.

Details on the core concepts are available [here](https://microsoft-my.sharepoint.com/personal/pankajgoyal_microsoft_com/Documents/Documents/aks/concepts-clusters-workloads).

#### Virtual Machines

Operator Nexus Virtual Machine (VM) gives Operators the flexibility to run legacy virtualized workloads that aren’t available as containerized network functions.

#### AKS-Hybrid cluster

AKS-Hybrid brings Azure managed Kubernetes services to on-premises environments. It provides users the ability to create Kubernetes clusters and lifecycle them through an API. AKS-Hybrid supports multiple backends including VMware, Azure Stack Edge HCI and now Operator Nexus.

AKS-Hybrid integrates with Operator Nexus networking that support SRIOV and DPDK. It will also integrate with Operator Nexus storage backends such as Pure. These AKS-Hybrid subclusters will be used to deploy CNF workloads.

#### Network functions virtualization infrastructure capabilities

As a platform, Operator Nexus is designed for telco network functions and optimized for carrier-grade performance and resiliency. It has many built-in Network Functions Virtualization Infrastructure (NFVI) capabilities:

- Compute: NUMA aligned VMs with dedicated cores (both SMT siblings), backed by huge pages ensures consistent performance. There’s no impact from other workloads running on the same hypervisor host.
- Networking: SR-IOV & DPDK for low latency and high throughput. Highly available VFs to VMs with redundant physical paths provide links to all workloads. APIs are used to control access and trunk port consumption in both VNFs and CNFs.
- Storage: Filesystem storage for CNFs backed by high performance storage arrays
