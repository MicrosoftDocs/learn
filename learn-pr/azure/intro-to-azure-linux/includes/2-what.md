"Linux on Azure" broadly encompasses two different kinds of Azure support for Linux applications and workloads: **infrastructure as a service (IaaS)** and **platform as a service (PaaS)**. Let's explore exactly what those terms mean, and learn more about additional Azure services and features you can take advantage of regardless of how you use Linux on Azure.

## Linux infrastructure as a service (IaaS)

With IaaS, you deploy your applications and workloads to virtual machines that run in Azure. These VMs are connected to each other and to the internet by virtual network infrastructure that you define and configure.

You can provision and manage VMs on an individual basis, or as *virtual machine scale sets*: groups of identical VMs managed through a central configuration interface. With scale sets, you can distribute your workloads to achieve high availability, redundancy, load balancing, and manual and automatic elastic scale.

Azure virtual machines support most common Linux distributions. Azure Marketplace has hundreds of preconfigured Linux disk images across many popular distributions, all of which include first-class Azure platform support. You can also create or migrate your own disk images, upload them to Azure, and create virtual machines from them.

IaaS is frequently the initial target for cloud migrations. The IaaS model allows you to reuse much of your on-premises architecture, while taking advantage of many benefits provided by the cloud.

## Linux platforms as a service (PaaS)

PaaS enables you to deploy applications to the cloud without managing infrastructure. These managed service platforms trade the flexibility of virtual infrastructure for reduced maintenance concerns and easier scalability. Azure PaaS services let you control, configure, and deploy your applications with the same centralized, globally available Azure Resource Manager management tools and libraries that you use for provisioning.

The Linux-based managed platforms of Azure allow you to take advantage of the benefits of PaaS, while retaining the technology foundation you're already familiar with. Azure App Service, Azure Functions, Azure Red Hat OpenShift, Azure Kubernetes Service, and Azure Container Instances all support the use of Linux as their foundation. You can use these Azure services to host Linux-based applications and code natively.

If your organization uses a Linux-powered development workflow or runs production applications on Linux, you can often deploy or migrate applications to a managed Azure platform.

## Additional Azure tools and services

Regardless of whether you use IaaS or PaaS, Azure tools and services offer a lot of additional value to Linux workloads beyond the standard cloud benefits of elasticity, agility, and reduced maintenance.

### Azure Resource Manager

Azure Resource Manager provides a standard interface and set of concepts for managing every kind of Azure service and platform. Manage all of your resources and workloads in a single, browser-based graphical experience with the Azure portal. Automate resource provisioning and management from the command line with Azure PowerShell and the Azure CLI, available locally and in the browser via the Azure Cloud Shell. Alternatively, you can do this from your own application code by using libraries available for most common languages. Use Azure Resource Manager templates and Azure Blueprints to perform configurable, repeatable deployments of cloud infrastructure. With broad compatibility for third-party tools, you can preserve your existing investments in tools like Ansible, Chef, Puppet, Terraform, and Packer.

### Azure storage services

Get durable, scalable, web-accessible storage with the core Azure storage services: Azure Blob storage for unstructured cloud-native storage; Azure File storage for mountable file shares; and Azure Queue storage for reliable messaging between applications. Mountable disk storage for virtual machines is managed just like other cloud resources, and Linux images in Azure Marketplace have all the required drivers built in. Ultra disk storage provides industry-leading throughput and sub-millisecond latency.

### Azure virtual networking and network appliances

Achieve flexible and secure communication between VMs, services, and the internet. Use network security groups and Azure Firewall for fine-grained control over the traffic in your virtual network. Direct web traffic to your applications with a comprehensive suite of load balancing and firewall services. Extend your on-premises network connectivity to Azure with Azure VPN Gateway and Azure ExpressRoute. Use HPC-grade VMs with Remote Direct Memory Access (RDMA) to drive demanding, high-performance workloads, such as weather modeling and physical simulations.

### Azure database services

Database services provide both familiar features and unique innovation in cloud-hosted databases. The Azure SQL family of products provides the SQL Server database engine in multiple forms:

- Azure SQL Database for fully managed, PaaS-style database support.
- Azure SQL Managed Instance for on-premises SQL Server compatibility with PaaS management benefits.
- SQL Server on Windows and Linux VMs for full operating system access, and complete compatibility for migration.

Azure Cosmos DB offers global distribution and multiple storage models, in a globally distributed data platform designed for the cloud. Azure Cache for Redis enables you to use the fast, well-known Redis storage server, without managing a virtual machine.

### AI and Azure Cognitive Services

Improve the intelligence of your apps with AI and Azure Cognitive Services. The search APIs of Cognitive Services provide fully managed, AI-powered search as a service. Azure Machine Learning helps developers and data scientists of all skill levels be productive, by using guided machine learning model development and drag-and-drop interaction. Azure Bot Service lets you create conversational bots to interact with your users. Azure Cognitive Services is a family of vision, speech, language, web search, and decision APIs for adding cognitive features to applications.

### Governance and monitoring

Maintain control of your applications with a comprehensive set of governance and monitoring capabilities. Monitor and optimize spending with Azure Cost Management budgeting and reporting capabilities. Enforce organizational standards with Azure Policy business rules and alerts. Define policy-backed resources with Azure Blueprints. Centralize monitoring, logging, and performance analysis across your entire cloud infrastructure with Azure Monitor. Instrument applications with Application Insights, perform deep queries with Log Analytics, and trigger automated actions and notifications with alerts.

### Security tools and capabilities

Build a secure foundation for your apps and workloads with security tools and capabilities in Azure. Harden your VMs and services with the recommendations provided by Azure Security Center. Protect and manage secure application configuration and certificates with Azure Key Vault. Detect and respond to security incidents in real time, with the intelligent analytics of Azure Sentinel. Azure Active Directory provides cloud-native identity and access management for role-based access control across all of your Azure resources. Most Azure services encrypt stored data by default, including VM disks.

### Business continuity and disaster recovery

Keep your data safe and your workloads online with an Azure-supported business continuity and disaster recovery strategy. Azure Backup creates encrypted snapshot backups of all of your VMs, and supports application consistency. This ensures that applications start up as expected after restoring a snapshot. Azure Site Recovery ensures that apps and workloads remain up and running during outages, by replicating VMs across geographical regions.

### Azure Migrate

This service helps you migrate your business workloads from on-premises platforms (whether deployed on physical or virtual servers) to Azure. Use Azure Migrate tools to discover and assess on-premises VMware VMs, Hyper-V VMs, and physical servers, to determine whether they're ready for migration. Then, use the migration tools to test migration and migrate automatically. The Azure Migrate hub provides a centralized record of discovery, assessment, and migration activities.
